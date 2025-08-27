// Custom Popup Menu with Custom Icon
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/utils/app_images/app_icons.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          final RenderBox button = context.findRenderObject() as RenderBox;
          final Offset position = button.localToGlobal(Offset.zero);
          final Size size = button.size;

          showMenu(
            elevation: 0,
            context: context,
            color: Colors.transparent,
            position: RelativeRect.fromLTRB(
              position.dx, position.dy + size.height, position.dx + size.width, position.dy + size.height + 200,
            ),
            items: [
              const PopupMenuItem(enabled: false, child: GlassMenu()), // Glass Effect Menu
            ],
          );
        },
        child: Image.asset(AppIcons.filterIcon,height: 17.0,width: 18.0));
  }
}

// Glass Effect Popup Menu
class GlassMenu extends StatelessWidget {
  const GlassMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          alignment: Alignment.center,
          width: Get.width * .50,
          height: Get.height * .12,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Physical Books",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff353A77),
                  ),
                ),
                Divider(color: Color(0xff353A77),),
                Text(
                  "E-Books",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff353A77),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(String text, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close popup
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("$text selected")));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
      ),
    );
  }
}
