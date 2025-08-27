import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/models/SocketModel/live_stream_chat.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:online/controllers/live_classes_controller/live_classes_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LiveClassesView extends StatelessWidget {
  LiveClassesView({super.key});

  final liveClassController = Get.find<LiveClassesController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffold2,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0.0,
              toolbarHeight: Get.height * .200,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonAppbar(
                title: 'Live Class',
                isDrawerShow: false,
                isNotificationShow: false,
                onLeadingTap: () => Get.back(),
                clipper: CustomAppBarClipper(),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(() {
                final chewieCtrl = liveClassController.chewieController.value;
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(() => Skeletonizer(
                    enabled: liveClassController.isSkeletonLoader.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (chewieCtrl == null || !liveClassController.isInitialized.value)
                            ? const Center(child: CircularProgressIndicator())
                            : AspectRatio(
                          aspectRatio: liveClassController.videoPlayerController.value?.value.aspectRatio ?? 16 / 9,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Chewie(controller: chewieCtrl)),
                        ),
                        SizedBox(height: Get.height * .015),
                        Obx(() => Text(
                          liveClassController.liveLectureData.value.title ?? "",
                          style: TextStyle(
                              fontSize: 20.0, color: AppColor.textClr, fontWeight: FontWeight.w500
                          ),
                        )),
                        SizedBox(height: Get.height * .015),
                        if(liveClassController.liveLectureData.value.description?.isNotEmpty == true)...[
                          Obx(() => Text(
                            liveClassController.liveLectureData.value.description ?? "",
                            style: TextStyle(
                                fontSize: 20.0, color: AppColor.textClr, fontWeight: FontWeight.w500
                            ),
                          )),
                        ],
                        Divider(color: AppColor.dividerClr, thickness: 1.0),
                        SizedBox(height: Get.height * .01),
                        Text(
                          "Live Chats",
                          style: TextStyle(fontSize: 20.0, color: AppColor.textClr, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: Get.height * .02),
                        _liveChatScreen()
                      ],
                    ),
                  )),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
  Widget _liveChatScreen() {
    return Container(
      height: Get.height * .400,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, -1),
            color: AppColor.boxShadowClr,
            blurRadius: 4.81,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Live Chat Messages
          Obx(() {
            if (liveClassController.comments.isEmpty) {
              return const Text('No comments yet');
            }

            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                shrinkWrap: true,
                reverse: true,
                physics: const BouncingScrollPhysics(),
                itemCount: liveClassController.comments.length,
                itemBuilder: (context, index) {
                  var comment = liveClassController.comments[index];
                  print("comments $comment");
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.supervised_user_circle_rounded, color: Colors.white),
                        ),
                        SizedBox(width: Get.width * .03),
                        Expanded(
                          child: Text(
                            comment,  // Directly display the string comment
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16.0, color: AppColor.textClr, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(width: Get.width * .05),
                        Text(
                          '05:01 PM', // Static time for now
                          style: TextStyle(fontSize: 11.0, color: AppColor.textClr, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }),
          SizedBox(height: Get.height * .02),
          // TextField for sending messages
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.64, 2.19),
                  color: AppColor.boxShadowClr,
                  blurRadius: 4.81,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: TextFormField(
              controller: liveClassController.liveChatController.value,
              decoration: InputDecoration(
                fillColor: const Color(0xffDDF1FF),
                filled: true,
                hintText: 'Type a Message',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    liveClassController.addCommentAndFetch();
                  },
                ),
                hintStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
