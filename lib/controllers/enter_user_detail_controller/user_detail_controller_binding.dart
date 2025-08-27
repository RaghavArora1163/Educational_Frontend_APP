import 'package:get/get.dart';
import 'package:online/controllers/enter_user_detail_controller/user_detail_controller.dart';

class UserDetailControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UserDetailController>(()=>UserDetailController());
  }

}