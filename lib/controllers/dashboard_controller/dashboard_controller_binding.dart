import 'package:get/get.dart';
import 'package:online/controllers/dashboard_controller/dashboard_controller.dart';

class DashBoardControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(()=> DashBoardController());
  }

}