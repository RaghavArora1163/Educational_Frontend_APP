import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/profile_model/profile_model.dart';

class ProfileController extends GetxController {
  final ScrollController scrollController = ScrollController();

  RxInt currentTabSelected = 0.obs;
  Rx<ProfileModelData> profileData = ProfileModelData().obs;
  RxBool isSkeletonLoader = false.obs;
  RxString currentTabName = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    isSkeletonLoader.value = true;
    try {
      final response = await ApiController().studentProfileDetail(apiUrl: ApiUrl.studentProfile);
      if (response != null && response.success == true) {
        profileData.value = response.data;
        currentTabName.value = profileData.value.tabs?.first.tabName ?? "";
      } else {
        Get.snackbar('Error', 'Failed to load profile data', backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e', backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      isSkeletonLoader.value = false;
    }
  }
}