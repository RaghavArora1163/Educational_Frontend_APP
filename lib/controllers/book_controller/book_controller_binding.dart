import 'package:get/get.dart';
import 'package:online/controllers/book_controller/book_controller.dart';

class BookControllerBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BookController>(()=> BookController());
  }

}