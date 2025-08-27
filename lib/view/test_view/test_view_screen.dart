import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/test_controller/test_controller.dart';
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


class TestViewScreen extends StatelessWidget with GlobalMixin{
   TestViewScreen({super.key});

   final testController = Get.find<TestController>();
   final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:  CommonDrawerMenu(),
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
        controller: testController.scrollController,
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
              title: 'Test Series',
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
                  enabled: testController.isSkeletonLoader.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Recommended Test Series',
                        style:  TextStyle(
                            color: Color(0xff3B4255),
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            height: 1.0
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      _testSeriesList(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

   Widget _testSeriesList(BuildContext context) {
     return Obx(() => GridView.builder(
       padding: const EdgeInsets.all(0),
       physics: const ClampingScrollPhysics(),
       shrinkWrap: true,
       itemCount: testController.testSeriesData.length,
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
}
