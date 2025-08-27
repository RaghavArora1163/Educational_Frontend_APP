import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/orders_controller/orders_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/app_environment/main.dart';

class YourOrderScreen extends StatelessWidget {
  YourOrderScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final OrdersController orderController = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: RefreshIndicator(
        onRefresh: () async {
          orderController.fetchOrders();
        },
        child: CustomScrollView(
          controller: orderController.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0.0,
              toolbarHeight: Get.height * .200,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonAppbar(
                isDrawerShow: false,
                isSearchShow: false,
                isNotificationShow: false,
                title: 'Your Orders',
                onLeadingTap: () {
                  Get.back();
                },
                clipper: CustomAppBarClipper(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Orders",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: AppColor.textClr,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: Get.height * .015),
                    Obx(() => _cartItemsCard(context)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cartItemsCard(BuildContext context) {
    if (orderController.isApiCall.value) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff01579B)),
            ),
            const SizedBox(height: 10),
            Text(
              "Loading your orders...",
              style: TextStyle(
                fontSize: 16.0,
                color: AppColor.textClr.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 300.ms);
    }

    if (orderController.isApiErrorShow.value ||
        orderController.ordersModel.value.data?.orders == null ||
        orderController.ordersModel.value.data!.orders!.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppVectors.introVectorImage,
              height: Get.height * .2,
              opacity: const AlwaysStoppedAnimation(0.5),
            ),
            const SizedBox(height: 20),
            Text(
              "No orders found!",
              style: TextStyle(
                fontSize: 18.0,
                color: AppColor.textClr,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Start shopping to see your orders here.",
              style: TextStyle(
                fontSize: 14.0,
                color: AppColor.textClr.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                orderController.fetchOrders();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff01579B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "Retry",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ).animate().scale(duration: 200.ms),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),
      itemCount: orderController.ordersModel.value.data!.orders!.length,
      itemBuilder: (context, index) {
        final order = orderController.ordersModel.value.data!.orders![index];
        final orderItem = order.orderItems!.isNotEmpty ? order.orderItems![0] : null;

        if (orderItem == null) {
          return const SizedBox.shrink();
        }

        final formattedDate = order.createdAt != null
            ? DateFormat('MMM dd, yyyy').format(DateTime.parse(order.createdAt!))
            : 'Unknown Date';

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GestureDetector(
            onTap: () {
              Get.snackbar("Order Details", "Viewing details for ${orderItem.bookName}");
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.boxShadowClr.withOpacity(0.2),
                    blurRadius: 8.0,
                    spreadRadius: 1,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                height: Get.height * .15,
                                width: Get.width * .25,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.boxShadowClr.withOpacity(0.3),
                                      offset: const Offset(-2, 2),
                                      blurRadius: 6,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: orderItem.bookImage != null
                                    ? Image.network(
                                  orderItem.bookImage!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                    AppVectors.introVectorImage,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Image.asset(
                                  AppVectors.introVectorImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: Get.width * .04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderItem.bookName ?? "Unknown Book",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColor.textClr,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: Get.height * .008),
                                  Text(
                                    "By ${orderItem.creatorName ?? 'Unknown Author'}",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: AppColor.textClr.withOpacity(0.7),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * .008),
                                  Row(
                                    children: [
                                      Text(
                                        "Status: ",
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: AppColor.textClr.withOpacity(0.7),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        order.orderStatus?.capitalizeFirst ?? "Unknown",
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Color(0xff2CBA4B),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: Get.height * .008),
                                  Text(
                                    "Ordered on: $formattedDate",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: AppColor.textClr.withOpacity(0.6),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: Get.height * .008),
                                  Text(
                                    "Total: ₹${order.totalAmount?.toStringAsFixed(2) ?? '0.00'}",
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff01579B),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * .015),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  getIt.globalVariable.bookDetailsId = orderItem.bookId!;
                                  Get.toNamed(RoutesName.bookDetailScreen);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2CBA4B).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Order Again",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff2CBA4B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ).animate().scale(duration: 200.ms),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  getIt.globalVariable.bookDetailsId = orderItem.bookId!;
                                  Get.toNamed(RoutesName.booksReviewScreen);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff01579B).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Add Review",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff01579B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ).animate().scale(duration: 200.ms),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 6,
                    left: Get.width * .14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xffE45A3B),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        orderItem.bookType?.capitalizeFirst ?? 'Physical',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 300.ms, delay: (index * 100).ms),
        );
      },
    );
  }
}