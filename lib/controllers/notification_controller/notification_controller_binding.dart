import 'package:get/get.dart';
import 'package:online/controllers/notification_controller/notification_controller.dart';

class NotificationControllerBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(()=> NotificationController());
  }

}