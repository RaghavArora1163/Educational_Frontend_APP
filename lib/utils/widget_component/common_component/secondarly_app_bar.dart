

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/app_routes/routes.dart';

class SecondarlyAppBar extends StatelessWidget{
  final String title;
  final Function()? onLeadingTap;
  final Function()? onNotificationTap;
  final bool isDrawerShow;
  final bool isNotificationShow;
  final bool isSearchShow;
  final CustomClipper<Path>? clipper;  // Add a clipper parameter

  SecondarlyAppBar({
    required this.title,
    this.onLeadingTap,
    this.onNotificationTap,
    this.isDrawerShow = true,
    this.isNotificationShow = true,
    this.isSearchShow = true,
    this.clipper,  // Initialize clipper
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: clipper, // Use the clipper if provided
      child: _appBar(),
    );
  }

   _appBar() {
    return Container(
      height: Get.height * .200,
      width: double.infinity,
      color: AppColor.bgColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: onLeadingTap,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isDrawerShow
                          ? Image.asset(AppIcons.menuDrawerIcon, height: 14.0, width: 18.0)
                          : Image.asset(AppIcons.arrowBackIcon, height: 14.0, width: 18.0),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(isSearchShow)
                      Image.asset(AppIcons.searchIcon, height: 22.0, width: 21.0),
                    if (isNotificationShow)...[
                      const SizedBox(width: 14.0),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RoutesName.notificationView);
                        },
                        child: Image.asset(AppIcons.notificationIcon, height: 22.0, width: 21.0),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
