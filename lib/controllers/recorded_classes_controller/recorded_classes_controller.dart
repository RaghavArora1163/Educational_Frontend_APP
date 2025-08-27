import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:video_player/video_player.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/student_lectures_model/student_lectures_model.dart';

class RecordedClassesController extends GetxController {
  final Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  final Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);

  RxBool isInitialized = false.obs;
  RxBool isControllerIconShow = true.obs;
  RxString videoUrl = "".obs;
  Rx<LecturesData> lecturesData = LecturesData().obs;
  RxBool isSkeletonLoader = false.obs;
  RxBool isNavigating = false.obs;

  @override
  void onInit() {
    super.onInit();
    print("Initializing controller with tag: ${Get.currentRoute}, lectureId: ${getIt.globalVariable.studentLectureId}");
    isSkeletonLoader.value = true;
    studentLecturesApi();
  }

  Future<void> studentLecturesApi() async {
    final data = {
      "courseId": getIt.globalVariable.studentSelectedCourseId,
      "lectureId": getIt.globalVariable.studentLectureId,
    };
    print("Fetching lecture with data: $data");

    try {
      final response = await ApiController()
          .studentLecturesDetail(apiUrl: ApiUrl.lectureDetails, data: data)
          .timeout(const Duration(seconds: 15), onTimeout: () {
        throw Exception("API request timed out");
      });
      print("API response: ${response?.toJson()}");
      await Future.delayed(const Duration(milliseconds: 500));
      isSkeletonLoader.value = false;

      if (response != null && response.success == true) {
        lecturesData.value = response.data ?? LecturesData();
        videoUrl.value = lecturesData.value.lecture?.videoUrl ?? "";
        print("New video URL: ${videoUrl.value}");
        if (videoUrl.isNotEmpty) {
          await initializePlayerWithRetry();
        } else {
          print("No video URL found");
          isInitialized.value = false;
          Get.snackbar("Error", "No video URL available for this lecture",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        print("API call failed or response unsuccessful");
        isInitialized.value = false;
        Get.snackbar("Error", "Failed to load lecture data",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (error) {
      print("API error: $error");
      isSkeletonLoader.value = false;
      isInitialized.value = false;
      Get.snackbar("Error", "An error occurred while loading the lecture: $error",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> initializePlayerWithRetry({int retryCount = 2}) async {
    print("Initializing player with URL: ${videoUrl.value}, retry count: $retryCount");
    for (int attempt = 1; attempt <= retryCount; attempt++) {
      try {
        final videoCtrl = VideoPlayerController.networkUrl(Uri.parse(videoUrl.value));
        await videoCtrl.initialize().timeout(const Duration(seconds: 10), onTimeout: () {
          throw Exception("Video initialization timed out");
        });
        videoPlayerController.value = videoCtrl;
        final chewieCtrl = ChewieController(
          videoPlayerController: videoCtrl,
          autoPlay: true,
          looping: false,
          allowFullScreen: true,
          allowPlaybackSpeedChanging: false,
          allowMuting: true,
          showControlsOnInitialize: false,
          materialProgressColors: ChewieProgressColors(
            playedColor: const Color(0xFF2196F3),
            handleColor: const Color(0xFF42A5F5),
            backgroundColor: const Color(0xFFBDBDBD),
            bufferedColor: Colors.white,
          ),
          errorBuilder: (context, errorMessage) {
            return Center(
              child: Text(
                "Error playing video: $errorMessage",
                style: const TextStyle(color: Colors.red),
              ),
            );
          },
        );

        // Listen to fullscreen changes
        chewieCtrl.addListener(() {
          if (chewieCtrl.isFullScreen) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          } else {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);
          }
        });

        chewieController.value = chewieCtrl;
        isInitialized.value = true;
        print("Player initialized successfully with state: ${videoCtrl.value}");
        return; // Exit on success
      } catch (error) {
        print("Player initialization error on attempt $attempt: $error");
        if (attempt == retryCount) {
          isInitialized.value = false;
          Get.snackbar("Error", "Failed to initialize video player after $retryCount attempts: $error",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          print("Retrying player initialization...");
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    }
  }

  Future<void> cleanupPlayer() async {
    print("Cleaning up player");
    try {
      if (chewieController.value != null) {
        await chewieController.value?.pause();
        chewieController.value?.dispose();
      }
      if (videoPlayerController.value != null) {
        await videoPlayerController.value?.pause();
        await videoPlayerController.value?.dispose();
      }
      chewieController.value = null;
      videoPlayerController.value = null;
      isInitialized.value = false;
      print("Player cleaned up successfully");
      // Additional delay to ensure SurfaceTexture release
      await Future.delayed(const Duration(milliseconds: 100));
    } catch (error) {
      print("Error cleaning up player: $error");
    }
  }

  @override
  void dispose() {
    print("Disposing RecordedClassesController with tag: ${Get.currentRoute}");
    cleanupPlayer();
    super.dispose();
  }
}