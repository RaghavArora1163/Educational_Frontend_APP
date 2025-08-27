import 'package:get/get.dart';
import 'package:online/controllers/quiz_controller/quiz_controller.dart';

class QuizControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(()=>QuizController());
  }

}