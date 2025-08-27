import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/shop_controller/shop_controller.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/app_mixin/global_mixin.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:online/utils/widget_component/common_component/common_drawer_menu.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ShopViewScreen extends StatelessWidget with GlobalMixin{
  ShopViewScreen({super.key});

  final shopController = Get.find<ShopController>();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CommonDrawerMenu(),
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
        controller: shopController.scrollController,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0.0,
            toolbarHeight: Get.height * .200,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0.0,
            flexibleSpace: CommonAppbar(
              title: 'Store',
              onLeadingTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              clipper: CustomAppBarClipper(),  // Pass the clipper
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0,0.0,15.0,15.0),
              child: Obx(()=>
                 Skeletonizer(
                  enabled: shopController.isSkeletonLoader.value,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shop Your Resources!',
                            style:  TextStyle(
                                color: Color(0xff3B4255),
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                                height: 1.0
                            ),
                          ),
                     Row(
                       children: [
                         // IconButton(
                         //   icon: Image.asset(
                         //     AppIcons.downloadIcon,
                         //     height: 17.0,
                         //     width: 18.0,
                         //   ),
                         //   onPressed: () {
                         //     // Handle download button press
                         //     print("Download button pressed");
                         //   },
                         // ),
                         IconButton(
                           icon: Image.asset(
                             AppIcons.shoppingBagIcon,
                             height: 17.0,
                             width: 18.0,
                           ),
                           onPressed: () {
                             // Handle shopping bag button press
                             print("Shopping bag button pressed");
                             Get.toNamed(RoutesName.youOrderView);
                           },
                         ),
                       ],
                     ),
                        ],
                      ),

                      const SizedBox(height: 20.0),

                      _resourcesBook(context),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _resourcesBook(BuildContext context) {
    return Obx(() => GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: (shopController.bookData.value.books?.length ?? 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height * 0.60),
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            getIt.globalVariable.bookDetailsId = shopController.bookData.value.books?[index].sId ?? "";
            Get.toNamed(RoutesName.bookDetailScreen);
          },
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xffE4EDFD), width: 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffC5D3F7).withOpacity(0.3),
                      blurRadius: 6.0,
                      spreadRadius: 1.0,
                      offset: const Offset(1.0, 2.0),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: shopController.bookData.value.books?[index].coverImage ?? "",
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[200],
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error_outline,
                                  color: AppColor.bgColor,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: context.screenHeight * .008),
                          Text(
                            shopController.bookData.value.books?[index].title ?? "title",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xff3B4255),
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(height: context.screenHeight * .008),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "₹${shopController.bookData.value.books?[index].price ?? 0}",
                                style: const TextStyle(
                                  color: Color(0xff2CBA4B),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  shopController.itemIndexID = shopController.bookData.value.books?[index].sId ?? "";
                                  shopController.bookData.value.books?[index].inCart =
                                  !(shopController.bookData.value.books?[index].inCart ?? false);
                                  shopController.isCart = shopController.bookData.value.books?[index].inCart ?? false;
                                  shopController.bookData.update((val) {
                                    val?.books?[index].inCart = shopController.bookData.value.books?[index].inCart ?? false;
                                  });
                                  showSnackBar(
                                    title: shopController.isCart ? "Added" : "Remove",
                                    message:
                                    "Your ${shopController.bookData.value.books?[index].title} book successfully ${shopController.isCart ? "added" : "remove"} to cart.",
                                  );
                                  shopController.addToCartApi();
                                },
                                child: shopController.bookData.value.books?[index].inCart == true
                                    ? Icon(
                                  Icons.remove_shopping_cart,
                                  size: 18.0,
                                  color: AppColor.textClr,
                                )
                                    : Image.asset(
                                  AppIcons.cartIcon,
                                  fit: BoxFit.cover,
                                  height: context.screenHeight * 0.018,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      right: 6.0,
                      child: GestureDetector(
                        onTap: () {
                          shopController.itemIndexID = shopController.bookData.value.books?[index].sId ?? "";
                          shopController.bookData.value.books?[index].isInWishlist =
                          !(shopController.bookData.value.books?[index].isInWishlist ?? false);
                          shopController.isWishList = shopController.bookData.value.books?[index].isInWishlist ?? false;
                          shopController.bookData.update((val) {
                            val?.books?[index].isInWishlist = shopController.bookData.value.books?[index].isInWishlist ?? false;
                          });
                          showSnackBar(
                            title: shopController.isWishList ? "Added" : "Remove",
                            message:
                            "Your ${shopController.bookData.value.books?[index].title} book successfully ${shopController.isWishList ? "added" : "remove"} to wishlist.",
                          );
                          shopController.wishListApi();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Icon(
                            shopController.bookData.value.books?[index].isInWishlist == true
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: shopController.bookData.value.books?[index].isInWishlist == true
                                ? Colors.red
                                : const Color(0xff3B4255),
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: Get.height * .013,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: const Color(0xffE45A3B),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          shopController.bookData.value.books?[index].bookType ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ));
  }
}
