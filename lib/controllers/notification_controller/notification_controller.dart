import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/notification_model/notification_model.dart';
import 'package:online/utils/app_mixin/global_mixin.dart';

class NotificationController extends GetxController with GlobalMixin {
  ScrollController scrollController = ScrollController();
  RxBool isApiCall = false.obs;
  RxBool isApiErrorShow = false.obs;
  Rx<NotificationModel> notificationModel = NotificationModel().obs;


  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    isApiCall.value = true;
    isApiErrorShow.value = false;
    ApiController().notifications(apiUrl: ApiUrl.notifications).then((response) {
      Future.delayed(const Duration(seconds: 2), () {
        isApiCall.value = false;
      });
      if (response != null) {
        if (response.success == true) {
          notificationModel.value = response;
        } else {
          isApiErrorShow.value = true;
        }
      } else {
        isApiErrorShow.value = true;
      }
    });
  }
}