import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';

class ErrorViewScreen extends StatelessWidget {
  const ErrorViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppVectors.errorVector,height: Get.height * .20,fit: BoxFit.cover),
          SizedBox(height: Get.height * .04),
          const Text('INTERNAL_SERVER_ERROR',
            style: TextStyle(
              color: Color(0xff3B4255),
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),

          SizedBox(height: Get.height * .02),

          const Text('An unexpected error occurred.\nPlease try again later.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff3B4255),
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),

          SizedBox(height: Get.height * .05),

          GestureDetector(
            onTap: (){
              if(getIt.globalVariable.callLastApi != null){
                getIt.globalVariable.callLastApi?.call();
              }
            },
            child: Container(
              height: 50.0,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Text('Retry',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
