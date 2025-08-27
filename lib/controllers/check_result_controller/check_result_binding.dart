import 'package:get/get.dart';
import 'package:online/controllers/check_result_controller/check_result_controller.dart';

class CheckResultBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<CheckResultController>(()=> CheckResultController());
  }

}