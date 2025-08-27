import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:online/controllers/edit_profile_controller/edit_profile_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/edit_profile_modal/edit_profile_modal.dart';
import '../../utils/app_routes/routes.dart';

class ProfileEditScreen extends StatelessWidget {
  ProfileEditScreen({super.key});

  final editProfileController = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: Obx(() {
        return CustomScrollView(
          physics: const ClampingScrollPhysics(),
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
                title: 'Edit Profile',
                onLeadingTap: () => Get.back(),
                clipper: CustomAppBarClipper(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: editProfileController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: [
                    _profileEditForm(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _commonBtn(
                            title: 'Discard',
                            isGradientShow: false,
                            onTap: () => Get.back()),
                        const SizedBox(width: 20),
                        Obx(()=>
                           _commonBtn(
                            isLoading: editProfileController.isProfileUpdate.value,
                            title: 'Submit',
                            onTap: () {
                             editProfileController.updateProfile();
                             Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
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
            child: Obx(()=>
                GestureDetector(
                  onTap: (){
                    editProfileController.checkPermission();
                  },
                  child: editProfileController.avatarFile.value != null
                      ? CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Colors.grey.shade200,
                      child:  ClipOval(
                        child: Image.file(
                          File(editProfileController.avatarFile.value?.path ?? ""),
                          width: 128, // same as diameter of CircleAvatar (2 * radius)
                          height: 128,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                      : CircleAvatar(
                      radius: 64.0,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: NetworkImage(editProfileController.avatarUrl.value),
                      child: editProfileController.avatarUrl.value.isEmpty == true
                          ? const Icon(
                        Icons.person,
                        size: 64.0,
                        color: Colors.white,
                      )
                          : null,
                      ),
                ),
            ),
          ),
          const SizedBox(height: 16),
          _labeledTextField("Name", editProfileController.nameController,"Name"),
          _labeledTextField("Email", editProfileController.emailController,"Email"),
          _labeledTextField("Contact Number", editProfileController.contactController,"Contact Number"),
          _labeledTextField("Biography", editProfileController.biographyController, "Biography"),
          _labeledTextField("Street", editProfileController.streetController, "Street"),
          _labeledTextField("City", editProfileController.cityController, "City"),
          _labeledTextField("State", editProfileController.stateController, "State"),
          _labeledTextField("Postal Code", editProfileController.postalCodeController, "Postal Code"),
          _labeledTextField("Country", editProfileController.countryController, "Country"),
          _languageDropdown(),
          Obx(() => SwitchListTile(
            title: const Text("Enable Notifications"),
            value: editProfileController.notificationEnabled.value,
            onChanged: (value) => editProfileController.notificationEnabled.value = value,
          )),
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

  Widget _languageDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Obx(()=>
         DropdownButtonFormField<String>(
          value: editProfileController.languageController.value.text.isNotEmpty ? editProfileController.languageController.value.text : null,
          items: editProfileController.languages.map((lang) {
            return DropdownMenuItem(
                value: lang,
                child: Text(lang)
            );
          }).toList(),
          onChanged: (value) => editProfileController.languageController.value.text = value ?? '',
          decoration: InputDecoration(
            hintText: "Preferred Language",
            hintStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: AppColor.textClr),
            fillColor: const Color(0xffDDF1FF),
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          ),
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