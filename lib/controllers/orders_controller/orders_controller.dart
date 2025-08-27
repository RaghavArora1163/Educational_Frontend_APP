import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/orders_model/orders_model.dart';
import 'package:online/utils/app_mixin/global_mixin.dart';

class OrdersController extends GetxController with GlobalMixin {
  ScrollController scrollController = ScrollController();
  RxBool isApiCall = false.obs;
  RxBool isApiErrorShow = false.obs;
  Rx<OrdersModel> ordersModel = OrdersModel().obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  void fetchOrders() {
    isApiCall.value = true;
    isApiErrorShow.value = false;
    ApiController().getAllOrders(apiUrl: ApiUrl.getAllOrders).then((response) {
      Future.delayed(const Duration(seconds: 2), () {
        isApiCall.value = false;
      });
      if (response != null) {
        if (response.success == true) {
          ordersModel.value = response;
        } else {
          isApiErrorShow.value = true;
        }
      } else {
        isApiErrorShow.value = true;
      }
    });
  }
}