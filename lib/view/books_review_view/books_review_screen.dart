import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/book_controller/book_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../data/api_controller/api_controller.dart';
import '../../data/api_url/api_url.dart';
import '../../utils/app_routes/routes.dart';

class BooksReviewScreen extends StatelessWidget {
  BooksReviewScreen({super.key});

  final BookController bookController = Get.find<BookController>();
  final TextEditingController reviewController = TextEditingController();
  final RxDouble rating = 0.0.obs;
  final RxBool isSubmitting = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.scaffold2,
        body: CustomScrollView(
          controller: bookController.scrollController,
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0.0,
              toolbarHeight: context.screenHeight * 0.22,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonAppbar(
                isDrawerShow: false,
                isSearchShow: false,
                isNotificationShow: false,
                title: 'Write a Review',
                onLeadingTap: () => Get.back(),
                clipper: CustomAppBarClipper(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Obx(() => _buildReviewForm(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewForm(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBookInfoCard(context),
          const SizedBox(height: 24.0),
          const Text(
            'Your Rating',
            style: TextStyle(
              fontSize: 18.0,
              color: AppColor.textClr,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          Obx(
                () => RatingBar.builder(
              initialRating: rating.value,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 32.0,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Color(0xFFFFDF00),
              ),
              onRatingUpdate: (value) => rating.value = value,
              updateOnDrag: true,
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Your Review',
            style: TextStyle(
              fontSize: 18.0,
              color: AppColor.textClr,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12.0),
          TextFormField(
            controller: reviewController,
            maxLines: 5,
            decoration: InputDecoration(
              fillColor: const Color(0xffDDF1FF),
              filled: true,
              hintText: 'Write your review here...',
              hintStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Color(0xff8484844d),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
            validator: (value) => value!.isEmpty ? 'Review cannot be empty' : null,
          ),
          const SizedBox(height: 24.0),
          Center(
            child: Obx(
                  () => SizedBox(
                width: context.screenWidth * 0.5,
                child: ElevatedButton(
                  onPressed: isSubmitting.value
                      ? null
                      : () => _submitReview(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.introBtnClr,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    elevation: 0.0,
                  ),
                  child: isSubmitting.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Submit Review',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookInfoCard(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.boxShadowClr.withOpacity(0.15),
              blurRadius: 8.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: bookController.bookDetailData.value.coverImage ?? "",
                height: context.screenHeight * 0.14,
                width: context.screenWidth * 0.25,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade100,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade100,
                  child: const Icon(Icons.error,
                      size: 40, color: AppColor.lightTextClr),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookController.bookDetailData.value.title ?? "",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: AppColor.textClr,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    bookController.bookDetailData.value.author ?? "",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColor.lightTextClr,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Type: ${bookController.bookDetailData.value.bookType ?? ""}",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColor.lightTextClr,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReview(BuildContext context) async {
    if (formKey.currentState!.validate() && rating.value > 0) {
      isSubmitting.value = true;
      try {
        final data = {
          "bookId":  bookController.bookDetailData.value.sId,
          "rating": rating.value.toInt(),
          "comment": reviewController.text,
        };

        final response = await ApiController()
            .submitReview(apiUrl: ApiUrl.submitReview, data: data);
print("Response aa raha hau");
print(response != null && response.success == true);
        if (response != null && response.success == true) {
          print("Success aa raha hau");
          Get.snackbar(
            'Success',
            'Review submitted successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          await Future.delayed(Duration(seconds: 2));
          print("yaha aa gya hua");
          bookController.bookDetailsApi();
          Get.toNamed(RoutesName.bookDetailScreen);
        } else {
          Get.snackbar(
            'Error',
            'Failed to submit review. Please try again.',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An error occurred. Please try again.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      } finally {
        isSubmitting.value = false;
      }
    } else if (rating.value == 0) {
      Get.snackbar(
        'Error',
        'Please select a rating',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}