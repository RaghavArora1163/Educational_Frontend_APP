import 'package:get/get.dart';
import 'package:online/controllers/transfer_controller/transfer_controller.dart';

class TransferControllerBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut<TransferController>(()=> TransferController());
  }

}