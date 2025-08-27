import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/home_controller/home_controller.dart';
import 'package:online/controllers/test_controller/test_controller.dart';
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
import 'package:online/view/error_view/error_view_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePageViewScreen extends StatelessWidget with GlobalMixin {
  HomePageViewScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final homeController = Get.find<HomeController>();
  final testController = Get.find<TestController>();
  final shopController = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CommonDrawerMenu(),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFF8F9FA),
              Color(0xFFF1F3F6),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: GetBuilder<HomeController>(
          init: homeController,
          builder: (_) {
            final bool isScrolled = homeController.scrollController.hasClients &&
                homeController.scrollController.offset > 50;

            return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                homeController.update(); // triggers rebuild
              }
              return false;
            },
            child: CustomScrollView(
            controller: homeController.scrollController,
            slivers: [
            SliverToBoxAdapter(
            child: CommonAppbar(
            title: 'Home',
            isScrolled: isScrolled,
            isDrawerShow: true,
            isSearchShow: false,
            onLeadingTap: () {
            _scaffoldKey.currentState?.openDrawer();
            },
            ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                child: Obx(() => (homeController.isApiErrorShow.value)
                    ? const ErrorViewScreen()
                    : Skeletonizer(
                  enabled: homeController.isApiCall.value ||
                      testController.isSkeletonLoader.value ||
                      shopController.isSkeletonLoader.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Featured Courses for you!',
                        style: TextStyle(
                          color: Color(0xff3B4255),
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: Get.height * .015),
                      _featureCourses(context),
                      SizedBox(height: Get.height * .022),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesName.seeAllCoursesView);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'See all',
                              style: TextStyle(
                                color: Color(0xff7E8099),
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Color(0xff7E8099),
                              size: 20.0,
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Color(0xffB4B4B4)),
                      SizedBox(height: Get.height * .027),
                      const Text(
                        'Latest YouTube Classes',
                        style: TextStyle(
                          color: Color(0xff3B4255),
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),

                      SizedBox(height: Get.height * .015),
                      _youtubeCard(context),
                      SizedBox(height: Get.height * .025),
                      const Divider(color: Color(0xffB4B4B4)),
                      SizedBox(height: Get.height * .027),
                      const Text(
                        'Recommended Test Series',
                        style: TextStyle(
                          color: Color(0xff3B4255),
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: Get.height * .015),
                      _testSeriesList(context),
                      SizedBox(height: Get.height * .025),
                      const Divider(color: Color(0xffB4B4B4)),
                      SizedBox(height: Get.height * .027),
                      const Text(
                        'Shop Your Resources!',
                        style: TextStyle(
                          color: Color(0xff3B4255),
                          fontWeight: FontWeight.w600,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: Get.height * .015),
                      _resourcesBook(context),
                      SizedBox(height: Get.height * .025),
                    ],
                  ),
                )),
              ),
            ),
          ],
        ));
      }),
      ),
    );
  }


  Widget _youtubeCard(BuildContext context) {
    return Obx(() => CarouselSlider.builder(
      itemCount: homeController.youTubeData.length ?? 0,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            homeController.launchYouTubeVideo(homeController.youTubeData[itemIndex].url ?? "");
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: homeController.youTubeData[itemIndex].thumbnail ?? "",
              width: double.infinity,
              fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[200],
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error_outline,
                  color: AppColor.bgColor,
                )
            ),
          ),
        ),
      ),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * .220,
      viewportFraction: 1,
      enableInfiniteScroll: true,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      enlargeCenterPage: false,
      scrollDirection: Axis.horizontal,
      onPageChanged: (value, pageReason) {
        homeController.currentIndex.value = value;
      },
    ),
    ));
  }

  Widget _featureCourses(BuildContext context) {
    return Obx(() => GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: (homeController.featuresCoursesModel.value.courses?.length ?? 0) >= 6
          ? 6
          : (homeController.featuresCoursesModel.value.courses?.length ?? 0),
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
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Color(0xFFE8ECF4).withOpacity(0.8), 
                width: 1.5
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF8B9DC3).withOpacity(0.15),
                  blurRadius: 12.0,
                  spreadRadius: 0,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 8.0,
                  spreadRadius: -2,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.0),
                            child: CachedNetworkImage(
                              imageUrl: homeController
                                  .featuresCoursesModel.value.courses?[index].courseImage ??
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
                              homeController.itemIndexID =
                                  homeController.featuresCoursesModel.value.courses?[index].sId ?? "";
                              var currentCourse =
                              homeController.featuresCoursesModel.value.courses?[index];
                              if (currentCourse != null) {
                                currentCourse.isInWishlist = !(currentCourse.isInWishlist ?? false);
                                homeController.isWishList = currentCourse.isInWishlist ?? false;
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
                                homeController.featuresCoursesModel.value.courses?[index]
                                    .isInWishlist ==
                                    true
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: homeController.featuresCoursesModel.value.courses?[index]
                                    .isInWishlist ==
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
                      homeController.featuresCoursesModel.value.courses?[index].title ?? "title",
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
                          homeController.featuresCoursesModel.value.courses?[index].courseType == "free"
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
                            var currentCourse =
                            homeController.featuresCoursesModel.value.courses?[index];
                            if (currentCourse != null) {
                              currentCourse.inCart = !(currentCourse.inCart ?? false);
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
                          child: homeController
                              .featuresCoursesModel.value.courses?[index].inCart ==
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
        );
      },
    ));
  }

  Widget _testSeriesList(BuildContext context) {
    return Obx(() => GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: testController.testSeriesData.length > 6 ? 6 : testController.testSeriesData.length,
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
            getIt.globalVariable.testSeriesDetailId = testController.testSeriesData[index].sId ?? "";
            Get.toNamed(RoutesName.testSeriesView);
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
                      imageUrl: testController.testSeriesData[index].coverImage ?? "",
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
                      testController.itemIndexID = testController.testSeriesData[index].sId ?? "";
                      testController.testSeriesData[index].isInWishlist =
                      !(testController.testSeriesData[index].isInWishlist ?? false);
                      testController.isWishList.value = testController.testSeriesData[index].isInWishlist ?? false;
                      testController.testSeriesData.refresh();
                      showSnackBar(
                        title: testController.isWishList.value ? "Added" : "Remove",
                        message:
                        "Your ${testController.testSeriesData[index].title} test series successfully ${testController.isWishList.value ? "added" : "remove"} to wishlist.",
                      );
                      testController.wishListApi();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        testController.testSeriesData[index].isInWishlist == true
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: testController.testSeriesData[index].isInWishlist == true
                            ? Colors.red
                            : const Color(0xff3B4255),
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
                ],
              ),
              SizedBox(height: context.screenHeight * .008),
                    Text(
                      testController.testSeriesData[index].title ?? "title",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xff3B4255), // Corrected the hex and removed 'listen: true'
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
                      testController.testSeriesData[index].price ?? "Free",
                      style: const TextStyle(
                        color: Color(0xff2CBA4B),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        testController.itemIndexID = testController.testSeriesData[index].sId ?? "";
                        testController.testSeriesData[index].inCart =
                        !(testController.testSeriesData[index].inCart ?? false);
                        testController.isCart = testController.testSeriesData[index].inCart ?? false;
                        testController.testSeriesData.refresh();
                        showSnackBar(
                          title: testController.isCart ? "Added" : "Remove",
                          message:
                          "Your ${testController.testSeriesData[index].title} test series successfully ${testController.isCart ? "added" : "remove"} to cart.",
                        );
                        testController.addToCartApi();
                      },
                      child: testController.testSeriesData[index].inCart == true
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
                    ),
                  ],
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


  Widget _resourcesBook(BuildContext context) {
    return Obx(() => GridView.builder(
      padding: const EdgeInsets.all(0),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: (shopController.bookData.value.books?.length ?? 0) > 6
          ? 6
          : (shopController.bookData.value.books?.length ?? 0),
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
            getIt.globalVariable.bookDetailsId = shopController.bookData.value.books?[index].sId ?? "";
            Get.toNamed(RoutesName.bookDetailScreen);
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
                              errorWidget: (context, url, error) => const Icon(
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
        );
      },
    ));
  }
  Widget commonDropDownBtn({required String hintTitle, required RxString selectedValue, required List<String> chooseValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: DropdownButtonHideUnderline(
          child: Obx(() => DropdownButton<String>(
            value: selectedValue.value.isEmpty ? null : selectedValue.value,
            hint: Text(
              hintTitle,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                color: Color(0xffBFBFCC),
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onChanged: (newValue) {
              if (newValue != null) {
                selectedValue.value = newValue;
              }
            },
            items: chooseValue.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              );
            }).toList(),
          )),
        ),
      ),
    );
  }
}