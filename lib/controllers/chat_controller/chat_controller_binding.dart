import 'package:get/get.dart';
import 'package:online/controllers/chat_controller/chat_controller.dart';

class ChatControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(()=> ChatController());
  }

}