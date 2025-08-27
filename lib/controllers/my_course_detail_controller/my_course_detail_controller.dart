import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/course_detail_model/course_detail_model.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class MyCourseDetailController extends GetxController{

  RxInt selectCurrentIndex = 500.obs;
  final Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  final ScrollController scrollController = ScrollController();
  TextEditingController userNameTxFCont = TextEditingController();
  TextEditingController userMobileTxFCont = TextEditingController();
  final Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);
  RxSet<int> courseSelectedIndex = <int>{}.obs;
  RxBool isEnrolled = false.obs;
  RxString videoUrl = "".obs;
  Rx<CoursesDetailData> coursesDetail = CoursesDetailData().obs;
  RxBool isInitialized = false.obs;
  RxBool isSkeletonizerLoader = false.obs;

  // Toggle state for course description expansion
  RxBool isDescriptionExpanded = false.obs;


  @override
  void onInit() {
    isSkeletonizerLoader.value = true;
    fetchCoursesDetailApi();
    super.onInit();
  }

  void toggleSelection(int index){
    if(courseSelectedIndex.contains(index)){
      courseSelectedIndex.remove(index);
    }else{
      courseSelectedIndex.add(index);
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


  void fetchCoursesDetailApi() {
    Map<String,dynamic> data = {
      'courseId' : getIt.globalVariable.courseDetailId,
    };
    ApiController().coursesDetail(apiUrl: ApiUrl.courseDetail, data:data).then((response){
      Future.delayed(const Duration(seconds: 2),(){
        isSkeletonizerLoader.value = false;
      });
      if(response != null){
        if(response.success == true){
          coursesDetail.value = response.data;
          isEnrolled.value = coursesDetail.value.courseDetails?.isEnrolled ?? false;
        }else{
        }
      }

    });
  }
}