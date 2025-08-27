import 'package:get/get.dart';
import 'package:online/controllers/test_series_controller/test_series_controller.dart';

class TestSeriesBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TestSeriesController>(()=>TestSeriesController());
  }

}