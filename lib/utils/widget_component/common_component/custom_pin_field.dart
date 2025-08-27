import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pinput/pinput.dart';

class CustomPinField extends StatelessWidget {
  TextEditingController pinController;
  Function() onOutSideTap;
  Function() onTap;

  CustomPinField({required this.pinController,required this.onOutSideTap, required this.onTap, super.key});



  @override
  Widget build(BuildContext context) {
    return buildPinPut();
  }

  Widget buildPinPut() {
    final defaultPinTheme = PinTheme(
      width: Get.width * .3,
      height: Get.height * .07,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color(0xffB6B8D1),
          fontWeight: FontWeight.w500
      ),
      decoration: const BoxDecoration(
        color: Color(0xff303350),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 2.5,
              spreadRadius: 0.1,
              offset: Offset(0.0,4.0)
          )
        ],
        border: GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors:
            [
              Color(0xff8D859E),
              Color(0xff41435E),
            ],
          ),
          width: 1.0,
        ),
        //borderRadius: BorderRadius.circular(50.0),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: const GradientBoxBorder(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:
          [
            Color(0xff8D859E),
            Color(0xff41435E),
          ],
        ),
        width: 1.0,
      ),
     // borderRadius: BorderRadius.circular(50.0),
    );


    return Pinput(
      controller: pinController,
      onTap: onTap,
      length: 6,
      onTapOutside: (PointerDownEvent e){
        onOutSideTap.call();
      },
      onSubmitted: (value){
        onOutSideTap.call();
      },
      separatorBuilder: (index) => const SizedBox(width: 0),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }

}
