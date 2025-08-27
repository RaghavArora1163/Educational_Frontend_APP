import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/shared_preferences/shared_pref.dart';

class SettingController extends GetxController {
  List<String> settingLabelNames = [
    'Transfer Course',
    'Privacy Policy',
    'Terms of Service',
    'Leave us a Review',
    'Delete Account',
    'Log Out'
  ];

  final ScrollController scrollController = ScrollController();
  RxBool isLoading = false.obs;

  /// LogOut Api
  Future<void> logoutApi() async {
    isLoading.value = true;
    try {
      final response = await ApiController().generalResponse(apiUrl: ApiUrl.logout);
      if (response != null && response.success == true) {
        await SharedPref.logout();
        Get.offAllNamed(RoutesName.mobileNumberView);
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Delete Api
  Future<void> deleteApi() async {
    isLoading.value = true;
    try {
      final response = await ApiController().generalResponse(apiUrl: ApiUrl.delete);
      if (response != null && response.success == true) {
        await SharedPref.logout();
        Get.offAllNamed(RoutesName.mobileNumberView);
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}