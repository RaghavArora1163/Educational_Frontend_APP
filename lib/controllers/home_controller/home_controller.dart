import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/std_fet_courses_model/std_fet_courses_model.dart';
import 'package:online/utils/app_mixin/global_mixin.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/you_tube_url_model/you_tube_url_model.dart';

class HomeController extends GetxController with GlobalMixin{

   ScrollController scrollController = ScrollController();
  RxInt currentIndex = 0.obs;
  RxDouble scrollValue = 0.0.obs;
  RxSet<int> favIndex = <int>{}.obs;
  RxString selectAllCategories = ''.obs;
  RxString selectAllLevels = ''.obs;
  RxBool isApiCall = false.obs;
  final List<String> allCategories = ["All Categories","Programming", "Design", "Business"];
  final List<String> allLevels = ["All Levels","Beginner", "Intermediate", "Advanced"];
  Rx<StudentFeaturesData>featuresCoursesModel = StudentFeaturesData().obs;
  RxList<YouTubeData> youTubeData = <YouTubeData>[].obs;

  String itemIndexID = "";
  RxBool isApiErrorShow = false.obs;
  bool isWishList = false;
  bool isCart = false;

  @override
  void onInit() {
    super.onInit();
    featuresCoursesApi();
    youTubeUrlApi();
  }

  void featuresCoursesApi() {
    isApiCall.value = true;
    isApiErrorShow.value = false;
    getIt.globalVariable.callLastApi = featuresCoursesApi;
    ApiController().featureCourses(apiUrl: ApiUrl.studentFeatureCourses,).then((response){
      Future.delayed(const Duration(seconds: 2),(){
        isApiCall.value = false;
      });
      if(response != null){
        if(response.success == true){
          getIt.globalVariable.callLastApi = null;
          featuresCoursesModel.value = response.data;
        }else{
          isApiErrorShow.value = true;
        }
      }else{
        isApiErrorShow.value = true;
      }
    });
  }

   void youTubeUrlApi() {
     ApiController().showYouTubeThumbNail(apiUrl: ApiUrl.youTubeUrl).then((response){
       if(response != null){
         if(response.success == true){
           youTubeData.value = response.data;
         }else{

         }
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
           showSnackBar(title: "Error", message: response.message);
         }
       }else{
         showSnackBar(title: "Error", message: response.message);
       }
     });
   }

   void launchYouTubeVideo(String youTubeUrl) async {
     final url = Uri.parse(youTubeUrl); // Replace with your YouTube link

     if (await canLaunchUrl(url)) {
       await launchUrl(
         url,
         mode: LaunchMode.inAppBrowserView, // Opens in YouTube app or browser
       );
     } else {
       throw 'Could not launch $url';
     }
   }
}