import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/profile_controller/profile_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:online/utils/widget_component/common_component/common_drawer_menu.dart';
import 'package:online/data/app_environment/main.dart';
import 'package:online/utils/app_routes/routes.dart';

class ProfileViewScreen extends StatelessWidget {
  ProfileViewScreen({super.key});

  final profileController = Get.find<ProfileController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Define a primary color that complements AppColor palette
  static const Color primaryColor = Color(0xff1E88E5); // Vibrant blue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:  CommonDrawerMenu(),
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: profileController.scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0.0,
              toolbarHeight: Get.height * .200,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonAppbar(
                title: 'Profile',
                onLeadingTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                clipper: CustomAppBarClipper(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Profile",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColor.textClr,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _userProfile(context),
                    const SizedBox(height: 24.0),
                    _tabs(context),
                    const SizedBox(height: 24.0),
                    _currentTabCard(context),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _userProfile(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      padding: const EdgeInsets.all(24.0),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 12.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allow overflow for the edit button
        children: [
          Column(
            children: [
              // Avatar with modern styling
              Obx(
                    () => Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 64.0,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: profileController.profileData.value.generalDetails?.avatarUrl?.isNotEmpty == true
                            ? NetworkImage(profileController.profileData.value.generalDetails!.avatarUrl!)
                            : null,
                        child: profileController.profileData.value.generalDetails?.avatarUrl?.isEmpty != false
                            ? const Icon(
                          Icons.person,
                          size: 64.0,
                          color: AppColor.lightTextClr,
                        )
                            : null,
                      ),
                    ),
                    // Edit button positioned on the avatar
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesName.profileEditView);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              // Full Name
              Obx(() => Text(
                  profileController.profileData.value.generalDetails?.fullName ?? "User Name",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.textClr,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              // Phone Number
              Obx(() => Text(
                  profileController.profileData.value.generalDetails?.phoneNumber ?? "No Phone",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColor.lightTextClr.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Biography
              Obx(() => profileController.profileData.value.generalDetails?.biography?.isNotEmpty == true
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    profileController.profileData.value.generalDetails?.biography ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColor.lightTextClr.withOpacity(0.8),
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _tabs(BuildContext context) {
    return Obx(
          () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            profileController.profileData.value.tabs?.length ?? 0,
                (index) {
              final tabName = profileController.profileData.value.tabs?[index].tabName ?? "";
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    profileController.currentTabSelected.value = index;
                    profileController.currentTabName.value = tabName;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: profileController.currentTabSelected.value == index
                          ? primaryColor.withOpacity(0.1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: profileController.currentTabSelected.value == index
                            ? primaryColor
                            : AppColor.dividerClr.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      tabName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: profileController.currentTabSelected.value == index
                            ? primaryColor
                            : AppColor.textClr,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _currentTabCard(BuildContext context) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profileController.currentTabName.value == "Progress") ...[
            Text(
              'Progress Report',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            profileController.profileData.value.tabs?[profileController.currentTabSelected.value].courseProgress?.courseProgressData?.isEmpty == true
                ? _emptyState(context, "No progress data available")
                : ListView.builder(
              itemCount: profileController.profileData.value.tabs?[profileController.currentTabSelected.value].courseProgress?.courseProgressData?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final courseProgressData = profileController.profileData.value.tabs?[profileController.currentTabSelected.value].courseProgress?.courseProgressData?[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.boxShadowClr.withOpacity(0.2),
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              courseProgressData?.courseName ?? "Course",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            '${courseProgressData?.completionRate ?? 0}%',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.textClr,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      LinearProgressIndicator(
                        value: (courseProgressData?.completionRate ?? 0) / 100,
                        backgroundColor: AppColor.dividerClr.withOpacity(0.3),
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8.0),
                        minHeight: 8.0,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          if (profileController.currentTabName.value == "My Courses") ...[
            Text(
              'My Courses',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myCourses?.myCoursesData?.isEmpty == true
                ? _emptyState(context, "No courses enrolled")
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myCourses?.myCoursesData?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final courseData = profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myCourses?.myCoursesData?[index];
                return GestureDetector(
                  onTap: () {
                    getIt.globalVariable.courseDetailId = courseData?.courseIdentifier ?? "0";
                    Get.toNamed(RoutesName.myCourseDetailView);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.boxShadowClr.withOpacity(0.2),
                          blurRadius: 8.0,
                          spreadRadius: 1.0,
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
                            imageUrl: courseData?.courseThumbnail ?? "",
                            height: 120.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: primaryColor)),
                            errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColor.lightTextClr),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            courseData?.courseName ?? "Course",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.textClr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
          if (profileController.currentTabName.value == "Test Series") ...[
            Text(
              'Test Series',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myTestSeries?.myTestSeriesData?.isEmpty == true
                ? _emptyState(context, "No test series enrolled")
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myTestSeries?.myTestSeriesData?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final testSeriesData = profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myTestSeries?.myTestSeriesData?[index];
                return GestureDetector(
                  onTap: () {
                    getIt.globalVariable.testSeriesDetailId = testSeriesData?.testSeriesIdentifier ?? "0";
                    Get.toNamed(RoutesName.testSeriesView);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.boxShadowClr.withOpacity(0.2),
                          blurRadius: 8.0,
                          spreadRadius: 1.0,
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
                            imageUrl: testSeriesData?.testSeriesThumbnail ?? "",
                            height: 120.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: primaryColor)),
                            errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColor.lightTextClr),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            testSeriesData?.testSeriesName ?? "Test Series",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.textClr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
          if (profileController.currentTabName.value == "Wishlist") ...[
            Text(
              "Wishlist",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            _wishlistSection(context, "Courses", profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myWishlist?.myWishlistData?.courses),
            _wishlistSection(context, "Books", profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myWishlist?.myWishlistData?.books),
            _wishlistSection(context, "Test Series", profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myWishlist?.myWishlistData?.testSeries),
          ],
          if (profileController.currentTabName.value == "Cart") ...[
            Text(
              'Cart',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myCartItems?.myCartItemsData?.isEmpty == true
                ? _emptyState(context, "Your cart is empty")
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myCartItems?.myCartItemsData?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final cartItemData = profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myCartItems?.myCartItemsData?[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.boxShadowClr.withOpacity(0.2),
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                            child: CachedNetworkImage(
                              imageUrl: cartItemData?.itemThumbnail ?? "",
                              height: 120.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: primaryColor)),
                              errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColor.lightTextClr),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItemData?.itemName ?? "Item",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.textClr,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Qty: ${cartItemData?.itemQuantity ?? 1}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColor.lightTextClr,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: IconButton(
                          icon: Image.asset(AppIcons.deleteIcon, height: 20.0),
                          onPressed: () {
                            // Implement remove from cart logic
                            // Example: profileController.removeFromCart(cartItemData?.itemIdentifier);
                          },
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        left: 8.0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            cartItemData?.itemCategory ?? "Item",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          if (profileController.currentTabName.value == "Books") ...[
            Text(
              'Books',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myBooks?.myBooksData?.isEmpty == true
                ? _emptyState(context, "No books purchased")
                : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myBooks?.myBooksData?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final bookData = profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myBooks?.myBooksData?[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.boxShadowClr.withOpacity(0.2),
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
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
                          imageUrl: bookData?.bookThumbnail ?? "",
                          height: 120.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: primaryColor)),
                          errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColor.lightTextClr),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          bookData?.bookName ?? "Book",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.textClr,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
          if (profileController.currentTabName.value == "Orders") ...[
            Text(
              'Orders',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColor.textClr,
              ),
            ),
            const SizedBox(height: 16.0),
            profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myOrders?.myOrdersData?.isEmpty == true
                ? _emptyState(context, "No orders placed")
                : ListView.builder(
              itemCount: profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myOrders?.myOrdersData?.length ?? 0,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final orderData = profileController.profileData.value.tabs?[profileController.currentTabSelected.value].myOrders?.myOrdersData?[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.boxShadowClr.withOpacity(0.2),
                        blurRadius: 8.0,
                        spreadRadius: 1.0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${orderData?.orderIdentifier ?? "N/A"}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Total: ${orderData?.orderTotal ?? "N/A"}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.lightTextClr,
                        ),
                      ),
                      Text(
                        'Status: ${orderData?.orderState ?? "N/A"}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.lightTextClr,
                        ),
                      ),
                      Text(
                        'Date: ${orderData?.orderDate ?? "N/A"}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.lightTextClr,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _wishlistSection(BuildContext context, String title, List<dynamic>? items) {
    if (items == null || items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColor.textClr,
          ),
        ),
        const SizedBox(height: 16.0),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.boxShadowClr.withOpacity(0.2),
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                        child: CachedNetworkImage(
                          imageUrl: item.itemThumbnail ?? "",
                          height: 120.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: CircularProgressIndicator(value: downloadProgress.progress, color: primaryColor)),
                          errorWidget: (context, url, error) => const Icon(Icons.error, color: AppColor.lightTextClr),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          item.itemName ?? title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColor.textClr,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: IconButton(
                      icon: Image.asset(AppIcons.deleteIcon, height: 20.0),
                      onPressed: () {
                        // Implement remove from wishlist logic
                        // Example: profileController.removeFromWishlist(item.itemIdentifier);
                      },
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        item.itemCategory ?? title,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }

  Widget _emptyState(BuildContext context, String message) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: AppColor.boxShadowClr.withOpacity(0.2),
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, size: 48.0, color: AppColor.lightTextClr),
          const SizedBox(height: 8.0),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColor.lightTextClr,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}