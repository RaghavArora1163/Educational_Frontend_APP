import 'package:get/get.dart';
import 'package:online/controllers/select_course_controller/select_course_controller.dart';

class SelectCourseBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SelectCourseController>(()=> SelectCourseController());
  }
}