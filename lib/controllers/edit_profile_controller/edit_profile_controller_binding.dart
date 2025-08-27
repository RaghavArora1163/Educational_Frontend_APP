import 'package:get/get.dart';
import 'package:online/controllers/edit_profile_controller/edit_profile_controller.dart';

class EditProfileControllerBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<EditProfileController>(()=> EditProfileController());
  }

}