import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/book_list_model/book_list_model.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';

class ShopController extends GetxController{

  final ScrollController scrollController = ScrollController();
  RxSet<int> favIndex = <int>{}.obs;
  Rx<BookData> bookData = BookData().obs;
  RxBool isSkeletonLoader = false.obs;
  String itemIndexID = "";
  RxBool isApiErrorShow = false.obs;
  bool isWishList = false;
  bool isCart = false;
  @override
  void onInit() {
    super.onInit();
    shopBookListApi();
  }

  void toggleFavItem(int item) {
    if (favIndex.contains(item)) {
      favIndex.remove(item);
    } else {
      favIndex.add(item);
    }
  }

  void shopBookListApi() {
    isSkeletonLoader.value = true;
    isApiErrorShow.value = false;
    getIt.globalVariable.callLastApi = shopBookListApi;
    ApiController().studentBookList(apiUrl: ApiUrl.booksList).then((response){
      Future.delayed(const Duration(seconds: 2),(){
        isSkeletonLoader.value = false;
      });
      if(response != null){
        if(response.success == true){
          getIt.globalVariable.callLastApi = null;
          bookData.value = response.data;
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
      "itemType": "course",
      "isWishlist": isWishList
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
      "itemType": "course",
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