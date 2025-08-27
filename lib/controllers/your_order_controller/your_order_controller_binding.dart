import 'package:get/get.dart';
import 'your_order_controller.dart';

class YourOrderControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<YourOrderController>(()=>YourOrderController());
  }

}