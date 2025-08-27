import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/widget_component/global_component/custom_bottom_navigation_bar_icon.dart';

class DashBoardController extends GetxController {
  RxInt currentPageIndex = 0.obs;

  RxList<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      activeIcon: activeBottomNavigationBarIcon(
          title: 'Home', mainImageName: AppVectors.homeVectorImg),
      icon: inActiveBottomNavigationBarIcon(
          title: 'Home', mainImageName: AppVectors.homeVectorImg),
      label: '',
    ),
    BottomNavigationBarItem(
      activeIcon: activeBottomNavigationBarIcon(
          title: 'Test', mainImageName: AppVectors.seeAllCoursesVector),
      icon: inActiveBottomNavigationBarIcon(
          title: 'Test', mainImageName: AppVectors.seeAllCoursesVector),
      label: '',
    ),
    BottomNavigationBarItem(
      activeIcon: activeBottomNavigationBarIcon(
          title: 'Shop', mainImageName: AppVectors.shopVectorImg),
      icon: inActiveBottomNavigationBarIcon(
          title: 'Shop', mainImageName: AppVectors.shopVectorImg),
      label: '',
    ),
    BottomNavigationBarItem(
      activeIcon: activeBottomNavigationBarIcon(
          title: 'Profile', mainImageName: AppVectors.profileCourseVectorImg),
      icon: inActiveBottomNavigationBarIcon(
          title: 'Profile', mainImageName: AppVectors.profileCourseVectorImg),
      label: '',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    checkFirebaseToken();
  }


  /// logOut Api
  void logoutApi() {
    ApiController().generalResponse(apiUrl: ApiUrl.logout).then((response){
      if(response != null){
        if(response.success == true){
          Get.offAllNamed(RoutesName.mobileNumberView);
        }else{
        }
      }
    });
  }


  void checkFirebaseToken(){
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.getToken().then((value){
      if(value?.isNotEmpty == true){
        updateFcmTokenApi(value!);
      }
    });
  }

  ///update Fcm Token
  void updateFcmTokenApi(String fcm) {
    Map<String,String> body ={
      "fcmToken":fcm
    };
    ApiController().generalResponse(apiUrl: ApiUrl.fcmUpdate,data: body).then((response){
      if(response != null){
        if(response.success == true){
        }else{
        }
      }
    });
  }

}