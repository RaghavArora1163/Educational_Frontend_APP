import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/test_series_model/test_series_model.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';

class TestController extends GetxController{

  final ScrollController scrollController = ScrollController();
  RxSet<int> favIndex = <int>{}.obs;
  RxList<TestSeriesData> testSeriesData = <TestSeriesData>[].obs;
  RxBool isSkeletonLoader = false.obs;

  String itemIndexID = "";
  RxBool isApiErrorShow = false.obs;
  RxBool isWishList = false.obs;
  bool isCart = false;

  @override
  void onInit() {
    super.onInit();
    testSeriesApi();
  }

  void toggleFavItem(int item) {
    if (favIndex.contains(item)) {
      favIndex.remove(item);
    } else {
      favIndex.add(item);
    }
  }

  void testSeriesApi() {
    isSkeletonLoader.value = true;
    isApiErrorShow.value = false;
    getIt.globalVariable.callLastApi = testSeriesApi;
    ApiController().studentTestSeriesList(apiUrl: ApiUrl.testSeries).then((response){
      Future.delayed(const Duration(seconds: 2),(){
        isSkeletonLoader.value = false;
      });
      if(response != null){
        if(response.success == true){
          getIt.globalVariable.callLastApi = null;
          testSeriesData.value = response.data;
        }else{
          isApiErrorShow.value = true;
        }
      }else{
        isApiErrorShow.value = true;
      }

    });
  }

  void wishListApi() {
    Map<String,dynamic> data = {
      "itemId" : itemIndexID,
      "itemType": "testSeries",
      "isWishlist": isWishList.value
    };
    ApiController().wishListDetail(apiUrl: ApiUrl.wishList,data: data).then((response){
      if(response != null){
        if(response.success == true){

        }else{
        }
      }

    });
  }

  void addToCartApi() {
    Map<String,dynamic> data = {
      "itemId" : itemIndexID,
      "itemType": "testSeries",
      "isCart": isCart
    };
    ApiController().wishListDetail(apiUrl: ApiUrl.addToCart,data: data).then((response){
      if(response != null){
        if(response.success == true){

        }else{
        }
      }

    });
  }
}