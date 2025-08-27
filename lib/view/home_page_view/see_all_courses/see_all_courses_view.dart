import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/home_controller/home_controller.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/app_mixin/global_mixin.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:online/view/error_view/error_view_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SeeAllCoursesView extends StatelessWidget with GlobalMixin {
  SeeAllCoursesView({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: homeController.scrollController,
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
              title: 'Courses',
              onLeadingTap: () {
                Get.back();
              },
              clipper: CustomAppBarClipper(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
              child: _allCourses(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _allCourses(BuildContext context) {
    return Obx(() => (homeController.isApiErrorShow.value)
        ? const ErrorViewScreen()
        : Skeletonizer(
      enabled: homeController.isApiCall.value,
      child: GridView.builder(
        padding: const EdgeInsets.all(0.0),
        controller: ScrollController(),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: (homeController.featuresCoursesModel.value.courses?.length ?? 5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height * 0.60),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              getIt.globalVariable.courseDetailId =
                  homeController.featuresCoursesModel.value.courses?[index].sId ?? "0";
              Get.toNamed(RoutesName.myCourseDetailView);
            },
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                imageUrl: homeController.featuresCoursesModel.value
                                    .courses?[index].courseImage ??
                                    "",
                                placeholder: (context, url) => Container(
                                  color: Colors.grey[200],
                                ),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error_outline,
                                  color: AppColor.bgColor,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 6.0,
                            right: 6.0,
                            child: GestureDetector(
                              onTap: () {
                                homeController.itemIndexID = homeController
                                    .featuresCoursesModel.value.courses?[index].sId ??
                                    "";
                                var currentCourse = homeController
                                    .featuresCoursesModel.value.courses?[index];
                                if (currentCourse != null) {
                                  currentCourse.isInWishlist =
                                  !(currentCourse.isInWishlist ?? false);
                                  homeController.isWishList =
                                      currentCourse.isInWishlist ?? false;
                                  homeController.featuresCoursesModel.update((val) {
                                    val?.courses?[index] = currentCourse;
                                  });
                                  showSnackBar(
                                    title: homeController.isWishList ? "Added" : "Remove",
                                    message:
                                    "Your ${homeController.featuresCoursesModel.value.courses?[index].title} course successfully ${homeController.isWishList ? "added" : "remove"} to wishlist.",
                                  );
                                  homeController.wishListApi();
                                  print("Wishlist updated: ${currentCourse.isInWishlist}");
                                }
                              },
                              child: Obx(() => Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  homeController.featuresCoursesModel.value
                                      .courses?[index].isInWishlist ==
                                      true
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: homeController.featuresCoursesModel.value
                                      .courses?[index].isInWishlist ==
                                      true
                                      ? Colors.red
                                      : const Color(0xff3B4255),
                                  size: 20.0,
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.screenHeight * .008),
                      Text(
                        homeController.featuresCoursesModel.value.courses?[index].title ??
                            "title",
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
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
                            homeController.featuresCoursesModel.value.courses?[index]
                                .courseType ==
                                "free"
                                ? "Free"
                                : "₹${homeController.featuresCoursesModel.value.courses?[index].coursePrice ?? 0}",
                            style: const TextStyle(
                              color: Color(0xff2CBA4B),
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                            ),
                          ),
                          Obx(() => GestureDetector(
                            onTap: () {
                              homeController.itemIndexID = homeController
                                  .featuresCoursesModel.value.courses?[index].sId ??
                                  "";
                              var currentCourse = homeController
                                  .featuresCoursesModel.value.courses?[index];
                              if (currentCourse != null) {
                                currentCourse.inCart =
                                !(currentCourse.inCart ?? false);
                                homeController.isCart = currentCourse.inCart ?? false;
                                homeController.featuresCoursesModel.update((val) {
                                  val?.courses?[index] = currentCourse;
                                });
                                showSnackBar(
                                  title: homeController.isCart ? "Added" : "Remove",
                                  message:
                                  "Your ${homeController.featuresCoursesModel.value.courses?[index].title} course successfully ${homeController.isCart ? "added" : "remove"} to cart.",
                                );
                                homeController.addToCartApi();
                                print("inCart updated: ${currentCourse.inCart}");
                              }
                            },
                            child: homeController.featuresCoursesModel.value
                                .courses?[index].inCart ==
                                true
                                ? const Icon(
                              Icons.remove_shopping_cart,
                              size: 18.0,
                              color: AppColor.textClr,
                            )
                                : Image.asset(
                              AppIcons.cartIcon,
                              fit: BoxFit.cover,
                              height: context.screenHeight * 0.018,
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}