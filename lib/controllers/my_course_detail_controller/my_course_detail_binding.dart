import 'package:get/get.dart';
import 'package:online/controllers/my_course_detail_controller/my_course_detail_controller.dart';

class MyCourseDetailBinding extends Bindings{
  @override
  void dependencies() {
   Get.lazyPut<MyCourseDetailController>(()=> MyCourseDetailController());
  }

}