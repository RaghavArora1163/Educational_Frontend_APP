import 'package:get/get.dart';
import 'package:online/controllers/profile_controller/profile_controller.dart';

class ProfileControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(()=> ProfileController());
  }

}