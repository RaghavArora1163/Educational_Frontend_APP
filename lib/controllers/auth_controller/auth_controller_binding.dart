import 'package:get/get.dart';
import 'package:online/controllers/auth_controller/auth_controller.dart';

class AuthControllerBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<AuthController>(()=> AuthController());
  }

}