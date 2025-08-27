import 'package:flutter/material.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_vectors.dart';

Widget activeBottomNavigationBarIcon({
  required String title,
  required String mainImageName,
}) {
  return Container(
    width: 45,
    height: 35,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.2),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          mainImageName,
          height: 18,
          width: 18,
          fit: BoxFit.contain,
          color: Colors.white,
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}


Widget inActiveBottomNavigationBarIcon({
  required String title,
  required String mainImageName,
}) {
  return Container(
    width: 45,
    height: 35,
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          mainImageName,
          height: 18,
          width: 18,
          fit: BoxFit.contain,
          color: Colors.white.withOpacity(0.6),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.w400,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    ),
  );
}
