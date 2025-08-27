import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/search_controller/search_controller.dart' as custom;
import 'package:online/data/app_environment/main.dart';
import 'package:online/models/search_model/search_model.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/utils/extension/global_variable_ext/global_variable_ext.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:online/utils/app_routes/routes.dart';

class SearchViewScreen extends StatelessWidget {
  SearchViewScreen({super.key});

  final TextEditingController _searchController = TextEditingController();
  final custom.SearchController _searchControllerX = Get.put(custom.SearchController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Call performSearch with empty string after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchControllerX.performSearch('');
    });

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
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
              title: 'Search',
              isSearchShow: false,
              isNotificationShow: false,
              onLeadingTap: () => Get.back(),
              clipper: CustomAppBarClipper(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search courses, tests, or books...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Color(0xffE4EDFD)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onSubmitted: (value) {
                      _searchControllerX.performSearch(value);
                    },
                  ),
                  SizedBox(height: Get.height * .027),
                  const Text(
                    'Search Results',
                    style: TextStyle(
                      color: Color(0xff3B4255),
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(height: Get.height * .015),
                  Obx(() {
                    if (_searchControllerX.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (_searchControllerX.isError.value) {
                      return Center(
                        child: Text(
                          _searchControllerX.errorMessage.value,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    }
                    if (_searchControllerX.searchResults.isEmpty) {
                      return Center(
                        child: Text(
                          'Enter a query to search',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.0,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _searchControllerX.searchResults.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height * 0.60),
                      ),
                      itemBuilder: (context, index) {
                        final result = _searchControllerX.searchResults[index];
                        return GestureDetector(
                          onTap: () {
                            if (result.type == 'course') {
                              getIt.globalVariable.courseDetailId = result.id ?? '';
                              Get.toNamed(RoutesName.myCourseDetailView);
                            } else if (result.type == 'testSeries') {
                              getIt.globalVariable.testSeriesDetailId = result.id ?? '';
                              Get.toNamed(RoutesName.testSeriesView);
                            } else if (result.type == 'book') {
                              getIt.globalVariable.bookDetailsId = result.id ?? '';
                              Get.toNamed(RoutesName.bookDetailScreen);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.grey[50]!,
                                      ],
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: result.coverImage ?? '',
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
                                            SizedBox(height: context.screenHeight * .012),
                                            Text(
                                              result.title ?? 'title',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Color(0xff2A3145),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (result.type != null)
                                        Positioned(
                                          top: 8.0,
                                          left: 8.0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 4.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffE45A3B),
                                              borderRadius: BorderRadius.circular(12.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 4.0,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              result.type!.capitalizeFirst!,
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
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}