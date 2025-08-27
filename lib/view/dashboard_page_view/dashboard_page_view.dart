import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:online/view/home_page_view/home_page_view_screen.dart';
import 'package:online/view/profile_view/profile_view_screen.dart';
import 'package:online/view/shop_view/shop_view_screen.dart';
import 'package:online/view/test_view/test_view_screen.dart';

class DashBoardPageView extends StatelessWidget {
  DashBoardPageView({super.key});
  final dashBoardController = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            switch (dashBoardController.currentPageIndex.value) {
              case 0: return HomePageViewScreen();
              case 1: return TestViewScreen();
              case 2: return ShopViewScreen();
              case 3: return ProfileViewScreen();
              default: return HomePageViewScreen();
            }
          }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFD32F2F), // Red
                    Color(0xFF1A1A1A), // Black
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Obx(() => BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    currentIndex: dashBoardController.currentPageIndex.value,
                    onTap: (index) {
                      dashBoardController.currentPageIndex.value = index;
                    },
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white70,
                    items: dashBoardController.bottomNavigationBarItems,
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
