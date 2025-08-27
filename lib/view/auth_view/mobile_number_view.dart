import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:online/controllers/auth_controller/auth_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_component/custom_clipper.dart';
import 'package:online/utils/widget_component/common_component/gradient_circle_box.dart';
import 'package:online/utils/widget_component/common_component/intro_btn.dart';

class MobileNumberView extends StatelessWidget {
   MobileNumberView({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (canPop){
        authController.isMobileNumberValid.value = true;
        authController.isKeyBoardAppear.value = false;
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
                      height: Get.height * .83,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.bgColor
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * .25,),
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: GradientCircleBox()),

                          const Spacer(),

                          const Align(
                              alignment: Alignment.centerRight,
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
                    ? MediaQuery.of(context).size.height * .1
                    : MediaQuery.of(context).size.height * .01,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Image.asset(AppVectors.mobileNumberVectorImg, height: MediaQuery.of(context).size.height * .33,),
                ),
              ),

              Obx(()=>
                 AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    bottom: !authController.isKeyBoardAppear.value
                        ? MediaQuery.of(context).size.height * .11
                        : MediaQuery.of(context).size.height * .22,
                    left: 0.0,
                    right: 0.0,
                    child: _internalContent(context)),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _internalContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text('"Enter Your Mobile Number\nto Get Started!"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .025,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: context.screenHeight * .050),

          _textField(context),

          SizedBox(height: context.screenHeight * .029),

          Obx(()=>
             SizedBox(
              child: !authController.isMobileNumberValid.value
                  ? const Text("Please enter valid Mobile Number",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffF44336),
                  fontWeight: FontWeight.w400,
                  height: 0.1
                ),
              )
                 : null
            ),
          ),

          SizedBox(height: context.screenHeight * .029),

          Obx(()=>
             IntroBtn(
                text: 'Next Step',
                isLoading: authController.isVerifyUser.value,
                onTap: (){
                  if(authController.mobileNumberController.text.isNotEmpty && authController.mobileNumberController.text.length==10){
                    authController.isMobileNumberValid.value = true;
                    authController.verifyMobileNumber();
                  }else{
                    authController.isMobileNumberValid.value = false;
                  }
            }),
          ),


        ],
      ),
    );
  }

  Widget _textField(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 69.0,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 2.5,
              spreadRadius: 0.1,
              offset: Offset(0.0,4.0)
          )
        ],
        borderRadius: BorderRadius.circular(50.0),
        border: const GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
            [
              Color(0xff746E89),
              Color(0xff41435E),
            ],
          ),
          width: 1.0,
        ),
        color: const Color(0xff303350),
      ),
      child: TextFormField(
        controller: authController.mobileNumberController,
        maxLength: 10,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onTap: (){
          authController.isMobileNumberValid.value = true;
          authController.isKeyBoardAppear.value = true;
        },
        onEditingComplete: (){
          FocusScope.of(context).unfocus();
          authController.isKeyBoardAppear.value = false;
        },
        onTapOutside: (PointerDownEvent event){
          FocusScope.of(context).unfocus();
          authController.isKeyBoardAppear.value = false;
        },
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          color: Color(0xffB6B8D1),
        ),
        cursorHeight: 30.0,
        cursorWidth: 1.0,
        cursorColor: Colors.white,
        decoration:   const InputDecoration(
          counterText: "",
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('  +91  ',
              style: TextStyle(
                  color: Color(0xffB6B8D1),
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500
                )
              ),
              VerticalDivider(
                color: Color(0xff77738A),
                width: 1.0,
              ),
              SizedBox(width: 20.0,)
            ],
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      )
    );
  }

}