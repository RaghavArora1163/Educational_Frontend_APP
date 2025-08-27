import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/check_result_controller/check_result_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

class CheckResultView extends StatelessWidget {
   CheckResultView({super.key});

  final checkResultController = Get.find<CheckResultController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
        controller: checkResultController.scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
              pinned: true,
              elevation: 0.0,
              toolbarHeight: Get.height * .200,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonAppbar(
                isSearchShow: false,
                isDrawerShow: false,
                isNotificationShow: false,
                title: 'Result Screen',
                clipper: CustomAppBarClipper(),  // Pass the clipper
              ),
          ),

           SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
              child: Column(
                children: [
                   const Text('48 of 50 correct',
                    style: TextStyle(
                      color: Color(0xff3B4255),
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                    ),
                  ),

                  SizedBox(height: Get.height * .021),

                  _progressIndicator(),

                  SizedBox(height: Get.height * .046),

                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                              color: AppColor.bgColor,
                              borderRadius: BorderRadius.circular(50.0),
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff191C3D),
                                    Color(0xff434BA3),
                                  ]
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xffCBCBCB),
                                  offset: Offset(0.0,4.0),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.0,
                                )
                              ]
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Retake Test',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    height: 1.0
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Icon(Icons.arrow_forward_outlined,color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * .10),
                      const Flexible(
                        child: Text('Back to Progress',
                          style: TextStyle(
                            color: Color(0xff3B4255),
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Get.height * .04),

                  _userResult(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
  Widget _userResult(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19.0,horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1.64,2.19),
            blurRadius: 4.81,
            spreadRadius: 0,
            color: AppColor.boxShadowClr
          ),
        ]
      ),
      child: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: const Color(0xffBEFFB8),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('1.',
                        style: TextStyle(
                          color: Color(0xff3B4255),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(width: Get.width * .10),
                      const Text('A Question here. Lorem Ipsum',
                        style: TextStyle(
                          color: Color(0xff3B4255),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(width: Get.width * .20),
                      const Icon(Icons.keyboard_arrow_down_outlined),
                    ],
                  ),
                  SizedBox(height: Get.height * .025),
                  const Text('Correct answer is A',
                    style: TextStyle(
                      color: Color(0xff3B4255),
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _progressIndicator(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              width: 300,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  // Red section
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFC1C1), // light red
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  // Yellow section
                  Expanded(
                    flex: 3,
                    child: Container(
                      color: const Color(0xFFFFF59D), // light yellow
                    ),
                  ),
                  // Green section
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFB9F6CA), // light green
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Pointer
            Obx(()=>
               Positioned(
                left: 300 * checkResultController.progress.value - 10, // Adjust the triangle position
                child: const Column(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.blueGrey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "Outstanding",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}
