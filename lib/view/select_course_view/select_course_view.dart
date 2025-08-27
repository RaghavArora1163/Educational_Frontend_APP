import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:online/controllers/select_course_controller/select_course_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/widget_component/common_component/custom_clipper.dart';
import 'package:online/utils/widget_component/common_component/gradient_circle_box.dart';
import 'package:online/utils/widget_component/common_component/intro_btn.dart';

class SelectCourseView extends StatelessWidget {
  SelectCourseView({super.key});

  final selectCourseController = Get.find<SelectCourseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _customizeBtn(),
      backgroundColor: AppColor.scaffold1,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRect(
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height: Get.height * .90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.bgColor
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * .25,),
                        const Align(
                            alignment: Alignment.topCenter,
                            child: GradientCircleBox()),

                        const Spacer(),

                        const Align(
                            alignment: Alignment.bottomCenter,
                            child: GradientCircleBox())
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 32.0, 20.0, 20.0),
              child: Image.asset(AppVectors.selectCourseVectorImg),
            ),

            Positioned(
                top:Get.height * .3,
                left: 0.0,
                right: 0.0,
                child: _internalContent(context)),

          ],
        ),
      ),
    );
  }

  Widget _internalContent(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .01,),
           Text('"Select Your Course and\nBegin Your Journey!"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .027,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: Get.height * .05),

          _courseList(),

        ],
      ),
    );
  }

  Widget _courseList(){
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),
      physics: const ClampingScrollPhysics(),
      itemCount: 5,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Color(0xff3B3E5A),
        );
      }, itemBuilder: (BuildContext context, int index) {
      return InkWell(
        onTap: (){
          selectCourseController.index.value = index;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Course $index',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color(0xffB6B8D1),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Obx(()=>
                  SizedBox(
                    child: selectCourseController.index.value == index
                        ? const Icon(Icons.check_circle_outline_rounded,color: Color(0xffB6B8D1))
                        : const SizedBox.shrink(),
                  ),
              )

            ],
          ),
        ),
      );
    },
    );
  }

  Widget _customizeBtn(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: IntroBtn(
          isTrailingShow: false,
          bgClr: const Color(0xff3E4370),
          text: 'Customize',
          onTap: (){
          if(selectCourseController.index.value == 100){
            Fluttertoast.showToast(msg: 'Please Select Your Course',
                backgroundColor: Colors.white,
                textColor: Colors.black,
                gravity: ToastGravity.BOTTOM,
            );
          }else{
              Get.offAllNamed(RoutesName.dashBoardPageView);
          }
      }
      ),
    );
  }
}
