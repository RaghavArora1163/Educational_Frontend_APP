import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:online/controllers/enter_user_detail_controller/user_detail_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

class EnterUserDetails extends StatelessWidget {
   EnterUserDetails({super.key});

   final userDetailController = Get.find<UserDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
        controller: userDetailController.scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            scrolledUnderElevation: 0.0,
            toolbarHeight: Get.height * .2,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            flexibleSpace: CommonAppbar(
              isDrawerShow: false,
              isSearchShow: false,
              isNotificationShow: false,
              title: 'User Details',
              onLeadingTap: () => Get.back(),
              clipper: CustomAppBarClipper(),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  _profileEditForm(),
                  const SizedBox(height: 20),
                  _commonBtn(
                    title: 'Submit',
                    onTap: () {
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _profileEditForm() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        boxShadow: const [
          BoxShadow(color: AppColor.boxShadowClr, offset: Offset(1.64, 2.19), blurRadius: 4.81),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),
          _labeledTextField("Name", userDetailController.nameController,"Name"),
          _labeledTextField("Email", userDetailController.emailController,"Email"),
        ],
      ),
    );
  }

  Widget _labeledTextField(String label, TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColor.textClr)),
          const SizedBox(height: 8),
          _commonTextField(controller, hintText),
        ],
      ),
    );
  }

  Widget _commonTextField(TextEditingController controller,String hintText) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: const Color(0xffDDF1FF),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: AppColor.lightTextClr),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _commonBtn({required String title, bool isGradientShow = true, required VoidCallback onTap, bool isLoading = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [Color(0xff616CDD), Color(0xff01579B)]),
            width: 1.0,
          ),
          gradient: isGradientShow ? const LinearGradient(colors: [Color(0xff191C3D), Color(0xff434BA3)]) : null,
        ),
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: isGradientShow ? Colors.white : const Color(0xff01579B),
          ),
        ),
      ),
    );
  }
}
