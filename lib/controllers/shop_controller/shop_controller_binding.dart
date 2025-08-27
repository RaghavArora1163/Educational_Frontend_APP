import 'package:get/get.dart';
import 'package:online/controllers/shop_controller/shop_controller.dart';

class ShopControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(()=> ShopController());
  }

}