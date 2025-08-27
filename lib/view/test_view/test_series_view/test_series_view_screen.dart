import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/payment_controller/payment_controller.dart';
import 'package:online/controllers/test_series_controller/test_series_controller.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TestSeriesViewScreen extends StatelessWidget {
  TestSeriesViewScreen({super.key});

  final testSeriesController = Get.find<TestSeriesController>();
  final PaymentController paymentController = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
        controller: testSeriesController.scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0.0,
            toolbarHeight: context.screenHeight * 0.22,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            flexibleSpace: CommonAppbar(
              title: 'Test Series',
              isDrawerShow: false,
              isNotificationShow: false,
              onLeadingTap: () => Get.back(),
              clipper: CustomAppBarClipper(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical:0),
              child: Obx(
                    () => Skeletonizer(
                  enabled: testSeriesController.isSkeletonizerLoader.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Title
                      // Text(
                      //   testSeriesController.testSeriesDetailData.value.categories?.name ?? "Course",
                      //   style: const TextStyle(
                      //     fontSize: 28.0,
                      //     color: AppColor.textClr,
                      //     fontWeight: FontWeight.w600,
                      //   ),
                      // ),
                      // const SizedBox(height: 24.0),
                      _buildHeaderCard(context),
                      const SizedBox(height: 32.0),
                      Divider(color: AppColor.dividerClr, thickness: 0.5),
                      const SizedBox(height: 32.0),
                      // Tests Section
                      Text(
                        "Available Tests",
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildTestList(),
                      const SizedBox(height: 32.0),
                      Divider(color: AppColor.dividerClr, thickness: 0.5),
                      const SizedBox(height: 32.0),
                      // Similar Test Series
                      Text(
                        "Explore Similar Test Series",
                        style: const TextStyle(
                          fontSize: 22.0,
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      _buildSimilarTestSeries(context),
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

  Widget _buildHeaderCard(BuildContext context) {
    return Obx(
          () => Card(
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
                    child: CachedNetworkImage(
                      height: context.screenHeight * 0.14,
                      width: context.screenWidth * 0.28,
                      imageUrl: testSeriesController.testSeriesDetailData.value.coverImage ?? "",
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
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          testSeriesController.testSeriesDetailData.value.title ?? "",
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textClr,
                          ),
                        ),
                        if (testSeriesController.testSeriesDetailData.value.creator?.name?.isNotEmpty ?? false) ...[
                          const SizedBox(height: 8.0),
                          Text(
                            "By ${testSeriesController.testSeriesDetailData.value.creator?.name ?? ""}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: AppColor.lightTextClr,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                testSeriesController.testSeriesDetailData.value.description ?? "",
                style: const TextStyle(
                  fontSize: 15.0,
                  color: AppColor.lightTextClr,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testSeriesController.testSeriesDetailData.value.price ?? "",
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFF2CBA4B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "₹1299 (75% off)",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: AppColor.lightTextClr,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Duration: ${testSeriesController.testSeriesDetailData.value.totalDuration ?? ""}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: AppColor.textClr,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              if (!testSeriesController.isEnrolled.value)
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final price = int.parse(
                          testSeriesController.testSeriesDetailData.value.price
                              ?.replaceAll(RegExp(r'[^0-9]'), '') ??
                              "0",
                        );
                        paymentController
                          ..id = testSeriesController.testSeriesDetailData.value.sId ?? ""
                          ..type = "testSeries"
                          ..onPaymentSuccessCallback = testSeriesController.testSeriesDetailApi
                          ..pay(
                            amount: price,
                            name: "AIIMS Nursing Institute",
                            description: testSeriesController.testSeriesDetailData.value.description ?? "",
                            contact: '9672606380',
                            email: 'usertest@gmail.com',
                          );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.introBtnClr,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                        elevation: 0.0,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Buy Now',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              else
                Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2CBA4B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
    child: const Center(
                    child: const Text(
                      'Enrolled',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2CBA4B),
                      ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestList() {
    return Obx(
          () => ListView.builder(
        controller: ScrollController(),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: testSeriesController.testSeriesDetailData.value.tests?.length ?? 0,
        itemBuilder: (context, index) {
          final test = testSeriesController.testSeriesDetailData.value.tests![index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              child: Container(
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
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  leading: CircleAvatar(
                    backgroundColor: AppColor.quizOptionCardClr,
                    child: const Icon(Icons.access_time, color: AppColor.quizTextClr),
                  ),
                  title: Text(
                    test.testTitle ?? "",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textClr,
                    ),
                  ),
                  subtitle: Text(
                    "By ${test.creator ?? ""}",
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: AppColor.lightTextClr,
                    ),
                  ),
                  trailing: testSeriesController.isEnrolled.value
                      ? const Icon(Icons.arrow_forward_ios, size: 16.0, color: AppColor.textClr)
                      : const Icon(Icons.lock, color: AppColor.lightTextClr),
                  onTap: testSeriesController.isEnrolled.value
                      ? () {
                    getIt.globalVariable.takeTestSeriesId =
                        testSeriesController.testSeriesDetailData.value.sId ?? "";
                    getIt.globalVariable.takeTestId = test.sId ?? "";
                    Get.toNamed(RoutesName.quizViewScreen);
                  }
                      : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSimilarTestSeries(BuildContext context) {
    return Obx(
          () => GridView.builder(
        controller: ScrollController(),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: testSeriesController.testSeriesDetailData.value.similarTestSeries?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final series = testSeriesController.testSeriesDetailData.value.similarTestSeries![index];
          return Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            child: Container(
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
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                    child: CachedNetworkImage(
                      imageUrl: series.coverImage ?? "",
                      height: context.screenHeight * 0.14,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade100,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade100,
                        child: const Icon(Icons.error, color: AppColor.lightTextClr),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          series.title ?? "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textClr,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          series.price ?? "",
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xFF2CBA4B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showConfirmationPaymentDialog() {
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
            children: [
              Text(
                "Order Confirmed!",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textClr,
                ),
              ),
              const SizedBox(height: 16.0),
              const Icon(Icons.check_circle, color: Color(0xFF2CBA4B), size: 64.0),
              const SizedBox(height: 16.0),
              Text(
                "Your test series is ready to explore!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColor.lightTextClr,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.introBtnClr,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    elevation: 0.0,
                  ),
                  child: const Text(
                    'Start Exploring',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget commonTextFields({
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.scaffold2,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16.0,
            color: AppColor.lightTextClr,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: prefixIcon,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: AppColor.introBtnClr, width: 1.5),
          ),
        ),
      ),
    );
  }
}