import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/book_controller/book_controller.dart';
import 'package:online/controllers/payment_controller/payment_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookDetailViewScreen extends StatelessWidget {
  BookDetailViewScreen({super.key});

  final BookController bookController = Get.find<BookController>();
  final PaymentController paymentController = Get.put(PaymentController());
  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              title: 'Book Details',
              onLeadingTap: () => Get.back(),
              clipper: CustomAppBarClipper(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Obx(
                    () => Skeletonizer(
                  enabled: bookController.isSkeletonLoader.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buyBookCard(context),
                      const SizedBox(height: 32.0),
                      Divider(color: AppColor.dividerClr, thickness: 0.5),
                      const SizedBox(height: 32.0),
                      const Text(
                        "Reviews",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _reviewCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buyBookCard(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: AppColor.boxShadowClr.withOpacity(0.2),
              blurRadius: 12.0,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.white, AppColor.scaffold2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Obx(
                        () => CachedNetworkImage(
                      imageUrl: bookController.bookDetailData.value.coverImage ?? "",
                      height: context.screenHeight * 0.14,
                      width: context.screenWidth * 0.28,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade100,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.error, size: 40, color: AppColor.lightTextClr),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                            () => Text(
                          bookController.bookDetailData.value.title ?? "",
                          style: const TextStyle(
                            fontSize: 22.0,
                            color: AppColor.textClr,
                            fontWeight: FontWeight.w600,
                          ),
                          semanticsLabel: 'Book title: ${bookController.bookDetailData.value.title ?? ""}',
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Obx(
                            () => Text(
                          bookController.bookDetailData.value.author ?? "",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: AppColor.lightTextClr,
                            fontWeight: FontWeight.w400,
                          ),
                          semanticsLabel: 'Author: ${bookController.bookDetailData.value.author ?? ""}',
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Obx(
                            () => Text(
                          bookController.bookDetailData.value.description ?? "",
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: AppColor.lightTextClr,
                            height: 1.6,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          semanticsLabel:
                          'Description: ${bookController.bookDetailData.value.description ?? ""}',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                          () => Text(
                        bookController.bookDetailData.value.price ?? "",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF2CBA4B),
                          fontWeight: FontWeight.w600,
                        ),
                        semanticsLabel: 'Price: ${bookController.bookDetailData.value.price ?? ""}',
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      "₹3399 (75% off)",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: AppColor.lightTextClr,
                        decoration: TextDecoration.lineThrough,
                      ),
                      semanticsLabel: 'Original price: ₹3399, 75% off',
                    ),
                  ],
                ),
                Obx(
                      () => Text(
                    "Category: ${bookController.bookDetailData.value.bookType ?? ""}",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColor.lightTextClr,
                      fontWeight: FontWeight.w400,
                    ),
                    semanticsLabel: 'Category: ${bookController.bookDetailData.value.bookType ?? ""}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Obx(
                  () => bookController.bookDetailData.value.isPurchased == true
                  ? bookController.bookDetailData.value.bookType?.toLowerCase() == 'ebook'
                  ? _buildDownloadButton(context)
                  : Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2CBA4B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Text(
                    'Already Purchased',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2CBA4B),
                    ),
                    semanticsLabel: 'Book already purchased',
                  ),
                ),
              )
                  : _buildPurchaseButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isLoading.value
              ? null
              : () {
            // Implement download functionality here
            Get.snackbar(
              'Download',
              'Initiating download for ${bookController.bookDetailData.value.title}',
              backgroundColor: Colors.green,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.introBtnClr,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            elevation: 0.0,
          ),
          child: isLoading.value
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : const Text(
            'Download eBook',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            semanticsLabel: 'Download eBook button',
          ),
        ),
      ),
    );
  }

  Widget _buildPurchaseButtons(BuildContext context) {
    final bookType = bookController.bookDetailData.value.bookType?.toLowerCase();
    final bool showDigital = bookType == 'ebook' || bookType == 'both';
    final bool showPhysical = bookType == 'physical' || bookType == 'both';

    return Column(
      children: [
        if (showDigital)
          Obx(
                () => SizedBox(
              width: double.infinity,
              child: Tooltip(
                message: 'Purchase a digital copy to read instantly',
                child: ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : () async {
                    isLoading.value = true;
                    try {
                      final price = int.parse(
                        bookController.bookDetailData.value.price?.replaceAll(RegExp(r'[^0-9]'), '') ?? "0",
                      );
                      await paymentController
                        ..id = bookController.bookDetailData.value.sId ?? ""
                        ..type = "book"
                        ..onPaymentSuccessCallback = () {
                          bookController.bookDetailsApi();
                          showConfirmationPaymentDialog(context);
                        }
                        ..pay(
                          amount: price,
                          name: bookController.bookDetailData.value.title ?? "Book",
                          description: bookController.bookDetailData.value.description ?? "",
                          contact: '9672606380',
                          email: 'usertest@gmail.com',
                        );
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        'Failed to process payment. Please try again.',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                      );
                    } finally {
                      isLoading.value = false;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.introBtnClr,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    elevation: 0.0,
                  ),
                  child: isLoading.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Buy Digital Copy',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    semanticsLabel: 'Buy digital copy button',
                  ),
                ),
              ),
            ),
          ),
        if (showDigital && showPhysical) const SizedBox(height: 12.0),
        if (showPhysical)
          Obx(
                () => SizedBox(
              width: double.infinity,
              child: Tooltip(
                message: 'Order a physical book delivered to your address',
                child: OutlinedButton(
                  onPressed: isLoading.value ? null : () => _showAddressBottomSheet(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColor.introBtnClr),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  ),
                  child: isLoading.value
                      ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColor.introBtnClr,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    'Order Physical Book',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColor.introBtnClr,
                    ),
                    semanticsLabel: 'Order physical book button',
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 8.0),
        if (showDigital || showPhysical)
          const Text(
            'Choose your preferred format: Digital for instant access or Physical for delivery.',
            style: TextStyle(
              fontSize: 12.0,
              color: AppColor.lightTextClr,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
            semanticsLabel: 'Choose digital for instant access or physical for delivery',
          ),
      ],
    );
  }

  Widget _reviewCard() {
    return Obx(
          () => ListView.builder(
        padding: const EdgeInsets.all(0),
        controller: ScrollController(),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: bookController.bookDetailData.value.reviews?.length ?? 0,
        itemBuilder: (context, index) {
          final review = bookController.bookDetailData.value.reviews![index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Card(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          review.user?.name ?? "Anonymous",
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: AppColor.textClr,
                            fontWeight: FontWeight.w600,
                          ),
                          semanticsLabel: 'Reviewer: ${review.user?.name ?? "Anonymous"}',
                        ),
                        const SizedBox(width: 12.0),
                        Text(
                          "${review.rating ?? 0}",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: AppColor.lightTextClr,
                            fontWeight: FontWeight.w400,
                          ),
                          semanticsLabel: 'Rating: ${review.rating ?? 0}',
                        ),
                        const SizedBox(width: 4.0),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFDF00),
                          size: 16.0,
                          semanticLabel: 'Star rating',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      review.comment ?? "No comment provided.",
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: AppColor.lightTextClr,
                        height: 1.6,
                      ),
                      semanticsLabel: 'Comment: ${review.comment ?? "No comment provided"}',
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final addressLine1Controller = TextEditingController();
    final addressLine2Controller = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final postalCodeController = TextEditingController();
    final countryController = TextEditingController(text: "India");

    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.scaffold2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Enter Shipping Address',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff3B4255),
                      ),
                      semanticsLabel: 'Enter shipping address',
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xff3B4255)),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                const Text(
                  'Please provide your address for delivery. All fields marked * are required.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff7E8099),
                  ),
                  semanticsLabel: 'Provide address for delivery. All fields marked with asterisk are required.',
                ),
                SizedBox(height: Get.height * 0.02),
                _commonTextField(
                  controller: addressLine1Controller,
                  hintText: "Address Line 1 *",
                  prefixIcon: const Icon(Icons.location_on, color: Color(0xffBFBFCC), size: 20.0),
                  validator: (value) => value!.isEmpty ? 'Address Line 1 is required' : null,
                ),
                _commonTextField(
                  controller: addressLine2Controller,
                  hintText: "Address Line 2",
                  prefixIcon: const Icon(Icons.location_on, color: Color(0xffBFBFCC), size: 20.0),
                ),
                _commonTextField(
                  controller: cityController,
                  hintText: "City *",
                  prefixIcon: const Icon(Icons.location_city, color: Color(0xffBFBFCC), size: 20.0),
                  validator: (value) => value!.isEmpty ? 'City is required' : null,
                ),
                _commonTextField(
                  controller: stateController,
                  hintText: "State *",
                  prefixIcon: const Icon(Icons.map, color: Color(0xffBFBFCC), size: 20.0),
                  validator: (value) => value!.isEmpty ? 'State is required' : null,
                ),
                _commonTextField(
                  controller: postalCodeController,
                  hintText: "Postal Code *",
                  prefixIcon: const Icon(Icons.local_post_office, color: Color(0xffBFBFCC), size: 20.0),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value!.isEmpty ? 'Postal Code is required' : (value.length < 5 ? 'Invalid Postal Code' : null),
                ),
                _commonTextField(
                  controller: countryController,
                  hintText: "Country *",
                  prefixIcon: const Icon(Icons.flag, color: Color(0xffBFBFCC), size: 20.0),
                  validator: (value) => value!.isEmpty ? 'Country is required' : null,
                ),
                SizedBox(height: Get.height * 0.02),
                Center(
                  child: Obx(
                        () => ElevatedButton(
                      onPressed: isLoading.value
                          ? null
                          : () async {
                        if (formKey.currentState!.validate()) {
                          isLoading.value = true;
                          final address = {
                            "addressLine1": addressLine1Controller.text,
                            "addressLine2": addressLine2Controller.text,
                            "city": cityController.text,
                            "state": stateController.text,
                            "postalCode": postalCodeController.text,
                            "country": countryController.text,
                          };

                          try {
                            final price = int.parse(
                              bookController.bookDetailData.value.price?.replaceAll(RegExp(r'[^0-9]'), '') ??
                                  "0",
                            );

                            await paymentController
                              ..id = bookController.bookDetailData.value.sId ?? ""
                              ..type = "physical_book"
                              ..onPaymentSuccessCallback = () {
                                bookController.bookDetailsApi();
                                showConfirmationPaymentDialog(context);
                                Get.toNamed(RoutesName.youOrderView,
                                    arguments: {'orderId': paymentController.id});
                              }
                              ..pay(
                                amount: price,
                                name: bookController.bookDetailData.value.title ?? "Book",
                                description: bookController.bookDetailData.value.description ?? "",
                                contact: '9672606380',
                                email: 'usertest@gmail.com',
                                address: address,
                              );
                            Get.back();
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Failed to process order. Please try again.',
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP,
                            );
                          } finally {
                            isLoading.value = false;
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.introBtnClr,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                        elevation: 0.0,
                      ),
                      child: isLoading.value
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Confirm Delivery Address',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        semanticsLabel: 'Confirm delivery address button',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _commonTextField({
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Stack(
        children: [
          Container(
            transform: Matrix4.translationValues(0, 7, 0),
            height: Get.height * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffC5D3F7),
                  offset: Offset(1.19, 2.19),
                  blurRadius: 4.81,
                  spreadRadius: 0,
                ),
              ],
            ),
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              fillColor: AppColor.scaffold1,
              filled: true,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Color(0xffBFBFCC),
              ),
              prefixIconConstraints: const BoxConstraints(
                minHeight: 20.0,
                maxHeight: 20.0,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: prefixIcon,
                ),
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showConfirmationPaymentDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowClr.withOpacity(0.2),
                blurRadius: 12.0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF2CBA4B),
                size: 64.0,
                semanticLabel: 'Order confirmed icon',
              ),
              const SizedBox(height: 16.0),
              const Center(
                child: Text(
                  "Order Placed Successfully!",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: AppColor.textClr,
                  ),
                  semanticsLabel: 'Order placed successfully',
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                paymentController.type == "physical_book"
                    ? "Your book will be delivered soon. Track your order in the Orders section."
                    : "Your digital book is ready! Start reading now in your library.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColor.lightTextClr,
                  height: 1.5,
                ),
                semanticsLabel: paymentController.type == "physical_book"
                    ? "Your book will be delivered soon. Track your order in the Orders section."
                    : "Your digital book is ready. Start reading now in your library.",
              ),
              const SizedBox(height: 24.0),
              Wrap(
                spacing: 16.0,
                runSpacing: 12.0,
                alignment: WrapAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    ),
                    child: const Text(
                      'Continue Browsing',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColor.introBtnClr,
                        fontWeight: FontWeight.w600,
                      ),
                      semanticsLabel: 'Continue browsing button',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.toNamed(RoutesName.youOrderView,
                          arguments: {'orderId': paymentController.id});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.introBtnClr,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      elevation: 0.0,
                    ),
                    child: const Text(
                      'View Order',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      semanticsLabel: 'View order button',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}