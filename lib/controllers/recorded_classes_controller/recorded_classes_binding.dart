import 'package:get/get.dart';
import 'package:online/controllers/recorded_classes_controller/recorded_classes_controller.dart';

class RecordedClassesBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<RecordedClassesController>(()=> RecordedClassesController());
  }

}