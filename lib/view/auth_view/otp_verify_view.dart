import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/auth_controller/auth_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_component/custom_clipper.dart';
import 'package:online/utils/widget_component/common_component/custom_pin_field.dart';
import 'package:online/utils/widget_component/common_component/gradient_circle_box.dart';
import 'package:online/utils/widget_component/common_component/intro_btn.dart';

class OtpVerifyView extends StatelessWidget {
   OtpVerifyView({super.key});

  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (canPop){
        authController.isKeyBoardAppear.value = true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      height: context.screenHeight * .83,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: AppColor.bgColor
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: context.screenHeight * .25,),

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

              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: !authController.isKeyBoardAppear.value
                    ? MediaQuery.of(context).size.height * .05
                    : MediaQuery.of(context).size.height * .01,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Image.asset(AppVectors.mobileNumberVectorImg,height: MediaQuery.of(context).size.height * .33),
                ),
              ),

              Obx(()=>
                 AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    bottom: !authController.isKeyBoardAppear.value
                        ? context.screenHeight * .1
                        : context.screenHeight * .22,
                        left: 0.0,
                        right: 0.0,
                        child: _internalContent(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

   Widget _internalContent(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            Text('"Enter OTP to Verify Your\nNumber!"',
             textAlign: TextAlign.center,
             style: TextStyle(
               fontSize: MediaQuery.of(context).size.height * .025,
               color: Colors.white,
               fontWeight: FontWeight.w600,
             ),
           ),

           SizedBox(height: context.screenHeight * .050),

           CustomPinField(
             pinController: authController.otpPinController,
             onTap: (){
               authController.isOtpValid.value = true;
               authController.isKeyBoardAppear.value = true;
             },
             onOutSideTap: (){
               FocusScope.of(context).unfocus();
               authController.isKeyBoardAppear.value = false;
             },
           ),

           SizedBox(height: context.screenHeight * .029),

           Obx(()=>
               SizedBox(
                   child: !authController.isOtpValid.value
                       ? const Text("Please enter valid OTP",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                         fontSize: 16.0,
                         color: Color(0xffF44336),
                         fontWeight: FontWeight.w400,
                         height: 0.1
                     ),
                   )
                       : null
               ),
           ),

           SizedBox(height: context.screenHeight * .029),

           IntroBtn(
            text: 'Next Step',
            onTap: (){
              if(authController.otpPinController.text.isNotEmpty && authController.otpPinController.text.length == 6){
                authController.isOtpValid.value = true;
                authController.checkOTPVerify();
              }else{
                authController.isOtpValid.value = false;
              }
            }
           ),

         ],
       ),
     );
   }
}
