import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/live_class_model/live_class_model.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/shared_preferences/shared_pref.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:video_player/video_player.dart';

class LiveClassesController extends GetxController {
  final Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);
  final Rx<ChewieController?> chewieController = Rx<ChewieController?>(null);
  Rx<TextEditingController> liveChatController = TextEditingController().obs;
  RxBool isInitialized = false.obs;
  RxBool isSkeletonLoader = false.obs;
  String videoUrl = "";
  Rx<LiveModelData> liveLectureData = LiveModelData().obs;
  late IO.Socket socket;

  // Use RxList to hold the comments
  RxList<String> comments = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    isSkeletonLoader.value = true;
    studentLiveLecturesApi();
    _connectSocket();
  }

  // Connect to Socket and Authenticate
  void _connectSocket() async {
    String token = await SharedPref.getToken() ?? "";
    socket = IO.io(ApiUrl.liveStreamUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();
    socket.emit('authenticate', token);

    // Listen for the 'authenticated' event
    socket.on('authenticated', (data) {
      if (data['success'] == true) {
        print('Successfully authenticated');
        fetchSocketComments(); // Fetch the comments after authentication
      } else {
        print('Authentication failed: ${data['error']}');
      }
    });
  }

  // Fetch comments from the socket
  void fetchSocketComments() {
    socket.emit('joinLiveClass', liveLectureData.value.id);
    socket.emit('getComments', liveLectureData.value.id);
    socket.on('comments', (data) {
      print("All Initial Comments: $data");

      // Ensure that data is a List and contains objects with a 'content' field
      if (data is List) {
        List<String> newComments = data
            .where((comment) => comment['content'] != null)
            .map<String>((comment) => comment['content'].toString()) // Ensure the content is a String
            .toList();

        // Add the new comments to the existing list
        comments.addAll(newComments);
      }
    });
  }


  // Add comment and send it through the socket
  void addCommentAndFetch() {
    socket.emit('sendComment', {'liveClassId': liveLectureData.value.id, 'content': liveChatController.value.text});
    comments.add(liveChatController.value.text);  // Add comment to the list
    liveChatController.value.clear();
  }

  // Fetch live lecture data
  void studentLiveLecturesApi() {
    final data = {
      "liveClassId": getIt.globalVariable.liveClassesCourseId,
    };

    ApiController().liveClassMethod(apiUrl: ApiUrl.liveClassStream, data: data).then((response) {
      Future.delayed(const Duration(seconds: 2), () {
        isSkeletonLoader.value = false;
      });

      if (response != null && response.success == true) {
        liveLectureData.value = response.data;
        videoUrl = liveLectureData.value.hlsUrl ?? "";
        if (videoUrl.isNotEmpty) {
          initializePlayer();
        }
      }
    });
  }

  // Initialize video player
  void initializePlayer() {
    final videoCtrl = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    videoCtrl.initialize().then((_) {
      videoPlayerController.value = videoCtrl;
      final chewieCtrl = ChewieController(
        videoPlayerController: videoCtrl,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowPlaybackSpeedChanging: false,
        allowMuting: true,
        showControlsOnInitialize: false,
        showOptions: false,
        isLive: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: const Color(0xFF2196F3),
          handleColor: const Color(0xFF42A5F5),
          backgroundColor: const Color(0xFFBDBDBD),
          bufferedColor: Colors.white,
        ),
      );

      // Listen to fullscreen changes
      chewieCtrl.addListener(() {
        if (chewieCtrl.isFullScreen) {
          // Entering fullscreen: landscape
          SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
        } else {
          // Exiting fullscreen: portrait
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        }
      });

      chewieController.value = chewieCtrl;
      isInitialized.value = true;
    });
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}
