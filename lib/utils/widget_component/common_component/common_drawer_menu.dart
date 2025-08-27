import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/app_routes/routes.dart';

class CommonDrawerMenu extends StatelessWidget {
   CommonDrawerMenu({super.key});

  final dashBoardController = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return menuBar(context);
  }

  Widget menuBar(BuildContext context){
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(50.0),  // Rounded top-right corner
        bottomRight: Radius.circular(50.0), // Rounded bottom-right corner
      ),
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * .07),
            InkWell(
                onTap: (){
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_ios_new_outlined,color: AppColor.drawerTxtClr)),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              buildDrawerItem(AppIcons.chatsDrawerIcon, "Chats", () => {
                Get.back(),
                Get.toNamed(RoutesName.chatScreenView),
              }),
              buildDrawerItem(AppIcons.orderDrawerIcon, "Orders", () => {
                Get.back(),
                Get.toNamed(RoutesName.youOrderView),
              }),
              buildDrawerItem(AppIcons.helpSupportDrawerIcon, "Help & Support", () => {
                Get.back(),
                Get.toNamed(RoutesName.helpSupportView),
              }),
              buildDrawerItem(AppIcons.settingDrawerIcon, "Settings", () => {
                Get.back(),
                Get.toNamed(RoutesName.settingView),
              }),
              buildDrawerItem(AppIcons.logoutDrawerIcon, "Log Out", () => {
                dashBoardController.logoutApi(),
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDrawerItem(String icon, String title, Function()? onTap) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          contentPadding: const EdgeInsets.only(left: 0.0),
          dense: true,
          visualDensity: const VisualDensity(vertical: 0,horizontal: 0),
          leading: Image.asset(icon,height: 21.0,width: 20.0,),
          title:  Text(title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 16.0,
              color: Color(0xff7E8099),
              fontWeight: FontWeight.w400,
            ),
          ),
          onTap: onTap,
        ),
        const Divider(
          color: Color(0xffD9D9D9),
        )
      ],
    );
  }

}
