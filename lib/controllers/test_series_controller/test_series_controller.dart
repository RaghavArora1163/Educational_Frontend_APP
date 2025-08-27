import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/test_series_detail_model/test_series_detail_model.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';

class TestSeriesController extends GetxController{

  ScrollController scrollController = ScrollController();
  RxBool isTestDetailArrow = false.obs;
  RxInt testDetailTapCurrentIdx = 0.obs;
  TextEditingController userNameTxFCont = TextEditingController();
  TextEditingController userMobileTxFCont = TextEditingController();
  Rx<TestSeriesDetailData> testSeriesDetailData = TestSeriesDetailData().obs;
  RxBool isSkeletonizerLoader = false.obs;
  RxBool isEnrolled = false.obs;


  @override
  void onInit() {
    super.onInit();
    isSkeletonizerLoader.value = true;
    testSeriesDetailApi();
  }

  void testSeriesDetailApi() {
    Map<String,dynamic> data = {
      "id" : getIt.globalVariable.testSeriesDetailId
    };
    ApiController().studentTestSeriesDetail(apiUrl: ApiUrl.testSeriesDetail,data: data).then((response){
      Future.delayed(const Duration(seconds: 2),(){
        isSkeletonizerLoader.value = false;
      });
      if(response != null){
        if(response.success == true){
          testSeriesDetailData.value = response.data;
          isEnrolled.value = testSeriesDetailData.value.isEnrolled ?? false;
        }else{
        }
      }

    });
  }

}