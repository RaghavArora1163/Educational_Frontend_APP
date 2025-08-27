import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:online/utils/app_images/app_vectors.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/shared_preferences/shared_pref.dart';

class SplashViewScreen extends StatefulWidget {
  const SplashViewScreen({super.key});

  @override
  State<SplashViewScreen> createState() => _SplashViewScreenState();
}

class _SplashViewScreenState extends State<SplashViewScreen> {


  @override
  void initState() {
    super.initState();
    changeCurrentRoutesNav();
  }

  void changeCurrentRoutesNav() async{
    var isLogin = await SharedPref.getUserIsLogin();
    Future.delayed(const Duration(seconds: 2),(){
      if(isLogin ?? false){
        Get.offAllNamed(RoutesName.dashBoardPageView);
      }else{
        Get.offAllNamed(RoutesName.introViewScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Image.asset(AppVectors.appLogoVector,
            height: MediaQuery.of(context).size.height * .2,
            fit: BoxFit.contain,
          ).animate()
              .fadeIn() // uses `Animate.defaultDuration`
              .scale() // inherits duration from fadeIn
              .move(delay: 300.ms, duration: 600.ms) // runs after the above w/new duration
        ),
      ),
    );
  }
}
