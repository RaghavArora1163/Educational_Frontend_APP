import 'package:get/get.dart';
import 'package:online/controllers/help_support_controller/help_support_controller.dart';

class HelpSupportBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<HelpSupportController>(()=>HelpSupportController());
  }

}