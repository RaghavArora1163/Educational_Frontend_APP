import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_component/custom_clipper.dart';
import 'package:online/utils/widget_component/common_component/gradient_circle_box.dart';
import 'package:online/utils/widget_component/common_component/intro_btn.dart';

class IntroViewScreen extends StatelessWidget {
  const IntroViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold1,
      body: SafeArea(
        child: Stack(
          children: [
        
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,20.0),
                child: Image.asset(AppVectors.introVectorImage,height: MediaQuery.of(context).size.height * .35),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRect(
                child: ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                    height:MediaQuery.of(context).size.height * .6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.bgColor
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .15,),
                        const Align(
                            alignment: Alignment.centerRight,
                            child: GradientCircleBox()),

                         const  Spacer(),

                        const Align(
                            alignment: Alignment.centerLeft,
                            child: GradientCircleBox())
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
                bottom: context.screenHeight * .10,
                right: 0.0,
                left: 0.0,
                child: _internalContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _internalContent(BuildContext context){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Text('"Unlock Your Potential"\nKnowledge at Your Fingertips.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * .023,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .03),
         Text("Learn at your own pace, anytime, anywhere.\nFun, easy, and personalized just for you!",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .021,
              color: Color(0xffB6B8D1),
              fontWeight: FontWeight.w400,
              height: 1.6
          ),
        ),

        SizedBox(height: context.screenHeight * .046),

        IntroBtn(
            text: "Let's Start",
            onTap: (){
          Get.toNamed(RoutesName.mobileNumberView);
        }
        ),
      ],
    );
  }

}
