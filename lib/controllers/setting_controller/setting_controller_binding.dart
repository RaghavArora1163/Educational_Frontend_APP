import 'package:get/get.dart';
import 'package:online/controllers/setting_controller/setting_controller.dart';

class SettingControllerBinding extends Bindings{
  @override

  void dependencies() {
   Get.lazyPut<SettingController>(()=> SettingController());
  }

}