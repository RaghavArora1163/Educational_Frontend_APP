import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/book_details_model/book_details_model.dart';
import 'package:online/models/wish_list_model/wish_list_model.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';

class BookController extends GetxController{
  ScrollController scrollController = ScrollController();
  Rx<BookDetailsData> bookDetailData = BookDetailsData().obs;
  Rx<WishListData> wishListData = WishListData().obs;

  RxBool isWishList = false.obs;
  RxBool addToCart = false.obs;
  RxBool isSkeletonLoader = false.obs;

  @override
  void onInit() {
    super.onInit();
    isSkeletonLoader.value = true;
    bookDetailsApi();
  }

  void bookDetailsApi() {
    Map<String,dynamic> data = {
      "id" : getIt.globalVariable.bookDetailsId,
    };
    ApiController().bookDetails(apiUrl: ApiUrl.bookDetails,data: data).then((response){
      Future.delayed(const Duration(seconds: 2),(){
        isSkeletonLoader.value = false;
      });
      if(response != null){
        if(response.success == true){
          bookDetailData.value = response.data;
          isWishList.value = bookDetailData.value.isWishlisted!;
          addToCart.value = bookDetailData.value.isAddedToCart!;
        }else{
        }
      }

    });
  }

  void wishListApi() {
    Map<String,dynamic> data = {
      "itemId" : getIt.globalVariable.bookDetailsId,
      "itemType": "book",
      "isWishlist": isWishList.value
    };
    ApiController().wishListDetail(apiUrl: ApiUrl.wishList,data: data).then((response){
      if(response != null){
        if(response.success == true){
          wishListData.value = response.data;
        }else{
        }
      }

    });
  }

  void addToCartApi() {
    Map<String,dynamic> data = {
      "itemId" : getIt.globalVariable.bookDetailsId,
      "itemType": "book",
      "isCart": addToCart.value
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