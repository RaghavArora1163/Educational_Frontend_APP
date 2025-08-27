import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:online/utils/app_colors/app_color.dart';

mixin  GlobalMixin {

  void showSnackBar({required String title, required String message}){
    Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: AppColor.scaffold2,
          titleText: Row(
            children: [
              const Icon(Icons.check_circle_outline_rounded,color: Colors.green),
              const SizedBox(width: 10.0),
              Text(title,
                softWrap: true,
                style: TextStyle(
                    color: AppColor.textClr,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    height: 1.0
                ),
              ),
            ],
          ),
          messageText: Text(message,
            softWrap: true,
            style: TextStyle(
                color: AppColor.textClr,
                fontWeight: FontWeight.w400,
                fontSize: 16.0,
                height: 1.0
            ),
          ),
        )
    );
  }

  void showLoader(){
    const Center(
      child: SpinKitDoubleBounce(
        color: Colors.blue,
        size: 50.0,
      ),
    );
  }

}