// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';
// import 'package:online/controllers/recorded_classes_controller/recorded_classes_controller.dart';
//
// class FullScreenVideoPlayer extends StatelessWidget {
//   FullScreenVideoPlayer({super.key});
//
//   final recordedClassController = Get.find<RecordedClassesController>();
//
//   String formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Obx(() {
//         final vidController = recordedClassController.vidController.value;
//
//         if (vidController == null || !recordedClassController.isInitialized.value) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         return Stack(
//           children: [
//             Center(
//               child: AspectRatio(
//                 aspectRatio: vidController.value.aspectRatio,
//                 child: VideoPlayer(vidController),
//               ),
//             ),
//             Positioned(
//               top: 30,
//               right: 20,
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.close,
//                   color: Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   // Exit full screen
//                   Get.back(); // Go back to previous screen
//                 },
//               ),
//             ),
//             Positioned(
//               bottom: 50,
//               left: 20,
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(
//                       recordedClassController.isPlaying.value
//                           ? Icons.pause_circle
//                           : Icons.play_circle,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                     onPressed: recordedClassController.togglePlayPause,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     formatDuration(recordedClassController.currentPosition.value),
//                     style: const TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                   const Text(" / ", style: TextStyle(color: Colors.white)),
//                   Text(
//                     formatDuration(recordedClassController.totalDuration.value),
//                     style: const TextStyle(fontSize: 14, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
