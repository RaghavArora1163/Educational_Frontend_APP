import 'package:get/get.dart';
import 'package:online/controllers/test_controller/test_controller.dart';

class TestControllerBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<TestController>(()=> TestController());
  }

}