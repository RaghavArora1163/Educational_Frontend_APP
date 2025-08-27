import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/my_course_detail_controller/my_course_detail_controller.dart';
import 'package:online/controllers/payment_controller/payment_controller.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/course_detail_model/course_detail_model.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyCourseDetailScreen extends StatelessWidget {
  MyCourseDetailScreen({super.key});

  final MyCourseDetailController myDetailCourseCont =
      Get.find<MyCourseDetailController>();
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: myDetailCourseCont.scrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                toolbarHeight: Get.height * 0.200,
                automaticallyImplyLeading: false,
                backgroundColor: AppColor.scaffold2,
                scrolledUnderElevation: 0,
                flexibleSpace: CommonAppbar(
                  isDrawerShow: false,
                  isSearchShow: false,
                  isNotificationShow: false,
                  title: 'Course Details',
                  onLeadingTap: () => Get.back(),
                  clipper: CustomAppBarClipper(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Obx(
                    () => Skeletonizer(
                      enabled: myDetailCourseCont.isSkeletonizerLoader.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _userEnrollContainer(context),
                          const SizedBox(height: 24.0),
                          _descriptionSection(),
                          const SizedBox(height: 32.0),
                          const Divider(
                              color: AppColor.dividerClr, thickness: 0.5),
                          if (myDetailCourseCont.isEnrolled.value) ...[
                            if (myDetailCourseCont.coursesDetail.value
                                    .courseDetails?.modules?.isNotEmpty ==
                                true) ...[
                              const SizedBox(height: 32.0),
                              const Text(
                                "What You’ll Learn",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: AppColor.textClr,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              _learnCard(),
                              const SizedBox(height: 32.0),
                              const Divider(
                                  color: AppColor.dividerClr, thickness: 0.5),
                              const SizedBox(height: 32.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Course Content",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      color: AppColor.textClr,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    myDetailCourseCont.coursesDetail.value
                                            .courseDetails?.session ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: AppColor.lightTextClr,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              _courseContent(),
                              const SizedBox(height: 32.0),
                              const Divider(
                                  color: AppColor.dividerClr, thickness: 0.5),
                              const SizedBox(height: 32.0),
                            ],
                            if (myDetailCourseCont.coursesDetail.value
                                    .assignments?.isNotEmpty ==
                                true) ...[
                              const Text(
                                "Assignments",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: AppColor.textClr,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: ScrollController(),
                                  padding: const EdgeInsets.all(0.0),
                                  itemCount: myDetailCourseCont.coursesDetail
                                          .value.assignments?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: _commonSubmitCard(
                                        onTap: () {},
                                        title: myDetailCourseCont
                                                .coursesDetail
                                                .value
                                                .assignments?[index]
                                                .title ??
                                            "",
                                        btnName: 'Submit',
                                        dueDate: myDetailCourseCont
                                                .coursesDetail
                                                .value
                                                .assignments?[index]
                                                .dueDate ??
                                            "",
                                        fileName: myDetailCourseCont
                                                .coursesDetail
                                                .value
                                                .assignments?[index]
                                                .description ??
                                            "",
                                        status: myDetailCourseCont
                                                .coursesDetail
                                                .value
                                                .assignments?[index]
                                                .status ??
                                            "",
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              const Divider(
                                  color: AppColor.dividerClr, thickness: 0.5),
                              const SizedBox(height: 32.0),
                            ],
                            if (myDetailCourseCont
                                    .coursesDetail.value.quizzes?.isNotEmpty ==
                                true) ...[
                              const Text(
                                "Quizzes",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: AppColor.textClr,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Obx(
                                () => ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: ScrollController(),
                                  padding: const EdgeInsets.all(0.0),
                                  itemCount: myDetailCourseCont.coursesDetail
                                          .value.quizzes?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: _commonSubmitCard(
                                        onTap: () => Get.toNamed(
                                            RoutesName.quizViewScreen),
                                        title: myDetailCourseCont.coursesDetail
                                                .value.quizzes?[index].title ??
                                            "",
                                        btnName: 'Take Quiz',
                                        dueDate: myDetailCourseCont
                                                .coursesDetail
                                                .value
                                                .quizzes?[index]
                                                .duration ??
                                            "",
                                        fileName: myDetailCourseCont
                                                .coursesDetail
                                                .value
                                                .quizzes?[index]
                                                .description ??
                                            "",
                                        status: myDetailCourseCont.coursesDetail
                                                .value.quizzes?[index].status ??
                                            "",
                                        isIconShow: false,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 32.0),
                              const Divider(
                                  color: AppColor.dividerClr, thickness: 0.5),
                              const SizedBox(height: 32.0),
                            ],
                            if (myDetailCourseCont.coursesDetail.value
                                    .studentResources?.resources?.isNotEmpty ==
                                true) ...[
                              const Text(
                                "Notes & Books",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: AppColor.textClr,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Obx(() => ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    controller: ScrollController(),
                                    padding: const EdgeInsets.all(0.0),
                                    itemCount: myDetailCourseCont
                                            .coursesDetail
                                            .value
                                            .studentResources
                                            ?.resources
                                            ?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: _commonSubmitCard(
                                          onTap: () => notesBookResourcesBS(
                                              myDetailCourseCont
                                                  .coursesDetail.value),
                                          title: 'Resources',
                                          btnName: 'Open',
                                          dueDate:
                                              'Total books & notes: ${myDetailCourseCont.coursesDetail.value.studentResources?.totalResources ?? 0}',
                                          fileName: '',
                                          status: 'Available',
                                          isIconShow: false,
                                        ),
                                      );
                                    },
                                  )),
                              const SizedBox(height: 32.0),
                              const Divider(
                                  color: AppColor.dividerClr, thickness: 0.5),
                              const SizedBox(height: 32.0),
                            ],
                            if (myDetailCourseCont.coursesDetail.value
                                    .liveClasses?.isNotEmpty ==
                                true) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Live Classes",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      color: AppColor.textClr,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    myDetailCourseCont.coursesDetail.value
                                            .liveClasses?.first.startTime
                                            ?.split(' ')
                                            ?.first ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: AppColor.lightTextClr,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              _liveClasses(),
                              const SizedBox(height: 32.0),
                              const Divider(
                                  color: AppColor.dividerClr, thickness: 0.5),
                              const SizedBox(height: 32.0),
                            ],
                          ],
                          const Text(
                            "Meet Your Instructor",
                            style: TextStyle(
                              fontSize: 24.0,
                              color: AppColor.textClr,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          _meetInstructorCard(context),
                          const SizedBox(
                              height: 100.0), // Extra space for sticky button
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
// Sticky Enroll Button for Non-Enrolled Users
          Obx(() => myDetailCourseCont.isEnrolled.value
              ? const SizedBox.shrink()
              : Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.boxShadowClr.withOpacity(0.2),
                          blurRadius: 8.0,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        paymentController
                          ..id = myDetailCourseCont
                                  .coursesDetail.value.courseDetails?.sId ??
                              ""
                          ..type = "course"
                          ..onPaymentSuccessCallback =
                              myDetailCourseCont.fetchCoursesDetailApi
                          ..pay(
                            amount: int.parse(
                              myDetailCourseCont.coursesDetail.value
                                      .courseDetails?.coursePrice
                                      ?.replaceAll(RegExp(r'[^0-9]'), '') ??
                                  "0",
                            ),
                            name: "AIIMS Nursing Institute",
                            description: (myDetailCourseCont.coursesDetail.value
                                        .courseDetails?.description ??
                                    "")
                                .substring(
                              0,
                              (myDetailCourseCont
                                              .coursesDetail
                                              .value
                                              .courseDetails
                                              ?.description
                                              ?.length ??
                                          0) >
                                      255
                                  ? 255
                                  : myDetailCourseCont.coursesDetail.value
                                          .courseDetails?.description?.length ??
                                      0,
                            ),
                            contact: '9672606380',
                            email: 'usertest@gmail.com',
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.introBtnClr,
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        elevation: 0.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            myDetailCourseCont.coursesDetail.value.courseDetails
                                        ?.courseType ==
                                    "free"
                                ? "Enroll for Free"
                                : "Enroll Now for ₹${myDetailCourseCont.coursesDetail.value.courseDetails?.coursePrice}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(Icons.arrow_forward,
                              color: Colors.white, size: 20.0),
                        ],
                      ),
                    ),
                  ),
                )),
        ],
      ),
    );
  }

  Widget _userEnrollContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Intro Video or Course Image
        Obx(() => myDetailCourseCont.coursesDetail.value.courseDetails?.introVideo?.isNotEmpty == true
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayer(),
            const SizedBox(height: 24.0),
          ],
        )
            : Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: context.screenHeight * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowClr.withOpacity(0.2),
                blurRadius: 8.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: CachedNetworkImage(
              imageUrl: myDetailCourseCont.coursesDetail.value.courseDetails?.courseImage ?? "",
              height: context.screenHeight * 0.2,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey.shade200,
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 40.0,
                    color: AppColor.lightTextClr,
                  ),
                ),
              ),
            ),
          ),
        )),
        // Course Details Card
        Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.boxShadowClr.withOpacity(0.2),
                  blurRadius: 12.0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  myDetailCourseCont.coursesDetail.value.courseDetails?.title ?? "",
                  style: const TextStyle(
                    fontSize: 28.0,
                    color: AppColor.textClr,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                const SizedBox(height: 12.0),
                Obx(() => Text(
                  myDetailCourseCont.coursesDetail.value.courseDetails?.instructor?.name ?? "",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: AppColor.lightTextClr,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Icon(Icons.star, color: Color(0xFFFFDF00), size: 20.0),
                    const SizedBox(width: 4.0),
                    Text(
                      myDetailCourseCont.coursesDetail.value.courseDetails?.instructor?.instructorReviews ?? "No reviews",
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.lightTextClr,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Obx(() => Text(
                  "Duration: ${myDetailCourseCont.coursesDetail.value.courseDetails?.courseDuration ?? ""}",
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColor.lightTextClr,
                    fontWeight: FontWeight.w400,
                  ),
                )),
                const SizedBox(height: 12.0),
                const Text(
                  "59 seats left!",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFFEB4824),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Obx(() => Text(
                      myDetailCourseCont.coursesDetail.value.courseDetails?.courseType == "free"
                          ? "Free"
                          : "₹${myDetailCourseCont.coursesDetail.value.courseDetails?.coursePrice}",
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Color(0xFF2CBA4B),
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    const SizedBox(width: 12.0),
                    const Text(
                      "₹3399",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColor.lightTextClr,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Obx(() => myDetailCourseCont.isEnrolled.value
                    ? Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2CBA4B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Enrolled',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2CBA4B),
                      ),
                    ),
                  ),
                )
                    : const SizedBox.shrink()),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildVideoPlayer() {
    return Obx(() {
      final chewieCtrl = myDetailCourseCont.chewieController.value;
      return SizedBox(
        child: chewieCtrl == null || !myDetailCourseCont.isInitialized.value
            ? Container(
                // height: context.screenHeight * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(child: CircularProgressIndicator()),
              )
            : AspectRatio(
                aspectRatio: myDetailCourseCont
                        .videoPlayerController.value?.value.aspectRatio ??
                    16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Chewie(controller: chewieCtrl),
                ),
              ),
      );
    });
  }

  Widget _descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "About This Course",
          style: TextStyle(
            fontSize: 24.0,
            color: AppColor.textClr,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowClr.withOpacity(0.15),
                blurRadius: 8.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Obx(() => AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: myDetailCourseCont.isDescriptionExpanded.value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                firstChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myDetailCourseCont
                              .coursesDetail.value.courseDetails?.description ??
                          "",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.lightTextClr,
                        height: 1.6,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () =>
                          myDetailCourseCont.isDescriptionExpanded.value = true,
                      child: const Text(
                        "Show More",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColor.introBtnClr,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myDetailCourseCont
                              .coursesDetail.value.courseDetails?.description ??
                          "",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppColor.lightTextClr,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    GestureDetector(
                      onTap: () => myDetailCourseCont
                          .isDescriptionExpanded.value = false,
                      child: const Text(
                        "Show Less",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: AppColor.introBtnClr,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget _learnCard() {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.boxShadowClr.withOpacity(0.15),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Obx(
          () => Column(
            children: List.generate(
              myDetailCourseCont
                      .coursesDetail.value.courseDetails?.modules?.length ??
                  0,
              (index) {
                bool isLastIndex = index ==
                    (myDetailCourseCont.coursesDetail.value.courseDetails
                                ?.modules?.length ??
                            0) -
                        1;
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      leading: const Icon(Icons.check_circle,
                          color: Color(0xFF2CBA4B), size: 24.0),
                      title: Text(
                        myDetailCourseCont.coursesDetail.value.courseDetails
                                ?.modules?[index].moduleTitle ??
                            "",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (!isLastIndex)
                      const Divider(color: AppColor.dividerClr, thickness: 0.5),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _courseContent() {
    return Obx(() => ListView.builder(
          controller: ScrollController(),
          padding: const EdgeInsets.all(0.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: myDetailCourseCont
                  .coursesDetail.value.courseDetails?.modules?.length ??
              0,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                child: Obx(() => GestureDetector(
                      onTap: !myDetailCourseCont.isEnrolled.value
                          ? null
                          : () {
                              myDetailCourseCont.selectCurrentIndex.value =
                                  index;
                              myDetailCourseCont.toggleSelection(index);
                            },
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.boxShadowClr.withOpacity(0.15),
                              blurRadius: 8.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              leading: CircleAvatar(
                                radius: 24.0,
                                backgroundColor: Colors.white,
                                child: Obx(() => ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: CachedNetworkImage(
                                        imageUrl: myDetailCourseCont
                                                .coursesDetail
                                                .value
                                                .courseDetails
                                                ?.courseImage ??
                                            "",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const SizedBox(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    )),
                              ),
                              title: Text(
                                myDetailCourseCont
                                        .coursesDetail
                                        .value
                                        .courseDetails
                                        ?.modules?[index]
                                        .moduleTitle ??
                                    "",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  color: AppColor.textClr,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: (myDetailCourseCont
                                          .coursesDetail
                                          .value
                                          .courseDetails
                                          ?.modules?[index]
                                          .moduleDescription
                                          ?.isNotEmpty ==
                                      true)
                                  ? Text(
                                      myDetailCourseCont
                                              .coursesDetail
                                              .value
                                              .courseDetails
                                              ?.modules?[index]
                                              .moduleDescription ??
                                          "",
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: AppColor.lightTextClr,
                                        fontWeight: FontWeight.w400,
                                        height: 1.5,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : null,
                              trailing: myDetailCourseCont.isEnrolled.value
                                  ? (myDetailCourseCont
                                              .coursesDetail
                                              .value
                                              .courseDetails
                                              ?.modules?[index]
                                              .lectures
                                              ?.isNotEmpty ==
                                          true)
                                      ? myDetailCourseCont.courseSelectedIndex
                                              .contains(index)
                                          ? const Icon(
                                              Icons.keyboard_arrow_down,
                                              size: 28.0)
                                          : const Icon(Icons.keyboard_arrow_up,
                                              size: 28.0)
                                      : const SizedBox.shrink()
                                  : const SizedBox.shrink(),
                            ),
                            if (myDetailCourseCont.courseSelectedIndex
                                .contains(index)) ...[
                              const SizedBox(height: 12.0),
                              Obx(
                                () => Column(
                                  children: List.generate(
                                    myDetailCourseCont
                                            .coursesDetail
                                            .value
                                            .courseDetails
                                            ?.modules?[index]
                                            .lectures
                                            ?.length ??
                                        0,
                                    (innerIndex) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(12.0),
                                          decoration: BoxDecoration(
                                            color: AppColor.scaffold2,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColor.boxShadowClr
                                                    .withOpacity(0.15),
                                                blurRadius: 8.0,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 24.0,
                                                    width: 24.0,
                                                    child: Checkbox(
                                                      value: myDetailCourseCont
                                                              .coursesDetail
                                                              .value
                                                              .courseDetails
                                                              ?.modules?[index]
                                                              .lectures?[
                                                                  innerIndex]
                                                              .isCompleted ??
                                                          false,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      side: const BorderSide(
                                                          color: Colors.black,
                                                          width: 1.0),
                                                      checkColor: Colors.white,
                                                      activeColor:
                                                          AppColor.introBtnClr,
                                                      shape:
                                                          const CircleBorder(),
                                                      onChanged: (value) {
// Update completion status if needed
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Expanded(
                                                    child: Text(
                                                      myDetailCourseCont
                                                              .coursesDetail
                                                              .value
                                                              .courseDetails
                                                              ?.modules?[index]
                                                              .lectures?[
                                                                  innerIndex]
                                                              .title ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 16.0,
                                                        color: AppColor.textClr,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 8.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    myDetailCourseCont
                                                            .coursesDetail
                                                            .value
                                                            .courseDetails
                                                            ?.modules?[index]
                                                            .lectures?[
                                                                innerIndex]
                                                            .duration ??
                                                        "",
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                      color:
                                                          AppColor.lightTextClr,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      getIt.globalVariable
                                                              .studentSelectedCourseId =
                                                          myDetailCourseCont
                                                                  .coursesDetail
                                                                  .value
                                                                  .courseDetails
                                                                  ?.sId ??
                                                              "";
                                                      getIt.globalVariable
                                                              .studentLectureId =
                                                          myDetailCourseCont
                                                                  .coursesDetail
                                                                  .value
                                                                  .courseDetails
                                                                  ?.modules?[
                                                                      index]
                                                                  .lectures?[
                                                                      innerIndex]
                                                                  .sId ??
                                                              "";
                                                      Get.toNamed(RoutesName
                                                          .recordedClassesView);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          AppColor.introBtnClr,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16.0,
                                                          vertical: 8.0),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0)),
                                                      elevation: 0.0,
                                                    ),
                                                    child: const Text(
                                                      'Play',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    )),
              ),
            );
          },
        ));
  }

  Widget _commonSubmitCard({
    required String title,
    required String status,
    required String fileName,
    required String btnName,
    required String dueDate,
    bool isIconShow = true,
    required Function() onTap,
  }) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.boxShadowClr.withOpacity(0.15),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: AppColor.textClr,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "Status: ",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColor.lightTextClr,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      status,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.lightTextClr,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (fileName.isNotEmpty)
                        Text(
                          fileName,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: AppColor.lightTextClr,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (fileName.isNotEmpty) const SizedBox(height: 8.0),
                      Text(
                        "Due: $dueDate",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: AppColor.lightTextClr,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.introBtnClr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 0.0,
                  ),
                  child: Text(
                    btnName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _liveClasses() {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.all(0.0),
        controller: ScrollController(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            myDetailCourseCont.coursesDetail.value.liveClasses?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              child: GestureDetector(
                onTap: () {
                  getIt.globalVariable.liveClassesCourseId = myDetailCourseCont
                          .coursesDetail.value.liveClasses?[index].id ??
                      "";
                  Get.toNamed(RoutesName.liveClassesView);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.boxShadowClr.withOpacity(0.15),
                        blurRadius: 8.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(right: 8.0),
                        leading: CircleAvatar(
                          radius: 24.0,
                          backgroundColor: Colors.white,
                          child: Obx(
                            () => ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: CachedNetworkImage(
                                imageUrl: myDetailCourseCont.coursesDetail.value
                                        .liveClasses?[index].courseImage ??
                                    "",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          myDetailCourseCont.coursesDetail.value
                                  .liveClasses?[index].title ??
                              "",
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: AppColor.textClr,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(
                                color: AppColor.introBtnClr, width: 1.0),
                          ),
                          child: Text(
                            myDetailCourseCont.coursesDetail.value
                                    .liveClasses?[index].liveClassStatus ??
                                "",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColor.introBtnClr,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        "${myDetailCourseCont.coursesDetail.value.liveClasses?[index].startTime ?? ""} - ${myDetailCourseCont.coursesDetail.value.liveClasses?[index].endTime ?? ""}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: AppColor.lightTextClr,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _meetInstructorCard(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.boxShadowClr.withOpacity(0.15),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() => ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 80.0,
                        width: 80.0,
                        imageUrl: myDetailCourseCont.coursesDetail.value
                                .courseDetails?.courseImage ??
                            "",
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade100,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade100,
                          child: const Icon(Icons.person,
                              size: 40.0, color: AppColor.lightTextClr),
                        ),
                      ),
                    )),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                            myDetailCourseCont.coursesDetail.value.courseDetails
                                    ?.instructor?.name ??
                                "",
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: AppColor.textClr,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      const SizedBox(height: 8.0),
                      const Text(
                        "Instructor",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: AppColor.lightTextClr,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFDF00), size: 20.0),
                const SizedBox(width: 4.0),
                Text(
                  myDetailCourseCont.coursesDetail.value.courseDetails
                          ?.instructor?.instructorReviews ??
                      "No reviews",
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: AppColor.lightTextClr,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget commonTextFields({
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.scaffold2,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16.0,
            color: AppColor.lightTextClr,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: prefixIcon,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide:
                const BorderSide(color: AppColor.introBtnClr, width: 1.5),
          ),
        ),
      ),
    );
  }

  void notesBookResourcesBS(CoursesDetailData courseDetail) {
    Get.bottomSheet(
      backgroundColor: AppColor.scaffold2,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Resources',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    courseDetail.studentResources?.resources?.length ?? 0,
                padding: const EdgeInsets.all(0.0),
                itemBuilder: (context, index) {
                  final resources = courseDetail
                          .studentResources?.resources?[index].allResources ??
                      [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        courseDetail.studentResources?.resources?[index]
                                .lectureTitle ??
                            "",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: AppColor.textClr,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: resources.length,
                        itemBuilder: (context, resourceIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Card(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.boxShadowClr
                                          .withOpacity(0.15),
                                      blurRadius: 8.0,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: AppColor.scaffold2,
                                    child: Icon(Icons.description,
                                        color: AppColor.textClr),
                                  ),
                                  title: Text(
                                    resources[resourceIndex].title ?? "",
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textClr,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    courseDetail.studentResources
                                            ?.resources?[index].moduleTitle ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.lightTextClr,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Get.toNamed(RoutesName.pdfViewScreen,
                                          arguments: {
                                            'link':
                                                resources[resourceIndex].url,
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.introBtnClr,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      elevation: 0.0,
                                    ),
                                    child: const Text(
                                      'View',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.introBtnClr,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0.0,
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showConfirmationPaymentDialog() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowClr.withOpacity(0.2),
                blurRadius: 12.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Enrollment Confirmed!",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textClr,
                ),
              ),
              const SizedBox(height: 16.0),
              const Icon(Icons.check_circle,
                  color: Color(0xFF2CBA4B), size: 64.0),
              const SizedBox(height: 16.0),
              const Text(
                "Your course is ready to explore!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColor.lightTextClr,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.introBtnClr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    elevation: 0.0,
                  ),
                  child: const Text(
                    'Start Exploring',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
