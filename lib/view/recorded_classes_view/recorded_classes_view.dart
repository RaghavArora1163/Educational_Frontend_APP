import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:online/controllers/recorded_classes_controller/recorded_classes_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import '../../data/app_environment/main.dart';

class RecordedClassesView extends StatelessWidget {
  RecordedClassesView({super.key});

  // Use a unique tag for each controller instance
  final String controllerTag =
      "${Get.arguments?['lectureId'] ?? ''}_${DateTime.now().millisecondsSinceEpoch}";
  late final RecordedClassesController controller =
  Get.put(RecordedClassesController(), tag: controllerTag);

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await controller.cleanupPlayer();
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffold2,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0.0,
              toolbarHeight: Get.height * 0.2,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonAppbar(
                title: 'All Classes',
                isDrawerShow: false,
                isNotificationShow: false,
                onLeadingTap: () async {
                  await controller.cleanupPlayer();
                  Get.back();
                },
                clipper: CustomAppBarClipper(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Obx(() => Skeletonizer(
                  enabled: controller.isSkeletonLoader.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildVideoPlayer(),
                      SizedBox(height: Get.height * 0.02),
                      _buildLectureTitle(),
                      SizedBox(height: Get.height * 0.015),
                      const Divider(color: AppColor.dividerClr, thickness: 1.0),
                      SizedBox(height: Get.height * 0.02),
                      if (controller.lecturesData.value.lecture?.resources
                          ?.isNotEmpty ??
                          false) ...[
                        _buildNotesSection(),
                        SizedBox(height: Get.height * 0.015),
                        const Divider(color: AppColor.dividerClr, thickness: 1.0),
                        SizedBox(height: Get.height * 0.02),
                      ],
                      if (controller
                          .lecturesData.value.nextLectures?.isNotEmpty ??
                          false) ...[
                        _buildUpNextSection(context),
                      ],
                    ],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Obx(() {
      final chewieCtrl = controller.chewieController.value;
      return SizedBox(
        child: chewieCtrl == null || !controller.isInitialized.value
            ? const Center(child: CircularProgressIndicator())
            : AspectRatio(
          aspectRatio: controller.videoPlayerController.value?.value.aspectRatio ??
              16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Chewie(controller: chewieCtrl),
          ),
        ),
      );
    });
  }

  Widget _buildLectureTitle() {
    return Obx(() => Text(
      controller.lecturesData.value.lecture?.title ?? "No Title",
      style: const TextStyle(
        fontSize: 22.0,
        color: AppColor.textClr,
        fontWeight: FontWeight.w600,
      ),
    ));
  }

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Notes & Books",
          style: TextStyle(
            fontSize: 20.0,
            color: AppColor.textClr,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Obx(() => ListView.builder(
          itemCount:
          controller.lecturesData.value.lecture?.resources?.length ?? 0,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildNoteCard(index);
          },
        )),
      ],
    );
  }

  Widget _buildNoteCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RoutesName.pdfViewScreen, arguments: {
            'link': controller.lecturesData.value.lecture?.resources?[index].url ?? "",
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColor.scaffold1,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowClr.withOpacity(0.3),
                blurRadius: 6.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: AppColor.quizOptionCardClr,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(AppIcons.bookNotesIcons, width: 24, height: 24),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Note ${index + 1}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textClr,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      controller.lecturesData.value.lecture?.resources?[index].title ?? "No Title",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightTextClr,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Text(
                "View",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff428BC1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpNextSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Up Next",
          style: TextStyle(
            fontSize: 20.0,
            color: AppColor.textClr,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: Get.height * 0.02),
        Obx(() => ListView.builder(
          itemCount:
          controller.lecturesData.value.nextLectures?.length ?? 0,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _buildUpNextCard(index);
          },
        )),
      ],
    );
  }

  Widget _buildUpNextCard(int index) {
    final lecture = controller.lecturesData.value.nextLectures?[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () async {
          if (controller.isNavigating.value) {
            print("Navigation in progress, ignoring tap");
            return;
          }
          controller.isNavigating.value = true;
          print("Tapped lecture ID: ${lecture?.sId}");
          // Update lecture ID
          getIt.globalVariable.studentLectureId = lecture?.sId ?? "";
          // Clean up current player
          await controller.cleanupPlayer();
          // Navigate to a new instance with a longer delay
          await Future.delayed(const Duration(milliseconds: 500));
          print("Navigating to new lecture: ${lecture?.sId}");
          Get.off(() => RecordedClassesView(), arguments: {
            'lectureId': lecture?.sId,
          });
          // Reset navigation flag
          await Future.delayed(const Duration(milliseconds: 500));
          controller.isNavigating.value = false;
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: AppColor.scaffold1,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowClr.withOpacity(0.3),
                blurRadius: 6.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: lecture?.courseImage ?? "",
                  height: Get.height * 0.08,
                  width: Get.width * 0.25,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColor.scaffold2,
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    color: AppColor.bgColor,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lecture?.title ?? "No Title",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textClr,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      lecture?.moduleTitle ?? "No Module",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: AppColor.lightTextClr,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}