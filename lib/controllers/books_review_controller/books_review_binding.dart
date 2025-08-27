import 'package:get/get.dart';
import 'package:online/controllers/books_review_controller/books_review_controller.dart';

class BooksReviewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BooksReviewController>(()=>BooksReviewController());
  }

}