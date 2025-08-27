import 'package:get/get.dart';
import 'package:online/controllers/orders_controller/orders_controller.dart';

class OrdersControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(() => OrdersController());
  }
}