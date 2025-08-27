import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/help_support_controller/help_support_controller.dart';
import 'package:online/data/api_controller/api_controller.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_images/app_icons.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

import '../../utils/app_routes/routes.dart';

class HelpSupportViewScreen extends StatefulWidget {
  const HelpSupportViewScreen({super.key});

  @override
  _HelpSupportViewScreenState createState() => _HelpSupportViewScreenState();
}

class _HelpSupportViewScreenState extends State<HelpSupportViewScreen> {
  final HelpSupportController helpSupportController = Get.find<HelpSupportController>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxBool isSubmitting = false.obs;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    addressController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.scaffold2,
        body: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          controller: helpSupportController.scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 0.0,
              toolbarHeight: Get.height * 0.18,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0.0,
              flexibleSpace: CommonAppbar(
                isDrawerShow: false,
                title: 'Help & Support',
                onLeadingTap: () => Get.back(),
                clipper: CustomAppBarClipper(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildQueryCard(),
                    const SizedBox(height: 32.0),
                    const Divider(color: Color(0xFFE0E0E0), thickness: 1.0),
                    const SizedBox(height: 24.0),
                    _buildFAQSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueryCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2, // Adjust flex to control space distribution
              child: _buildQueryContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueryContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Need Assistance?',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Reach out to us, and we’ll resolve your queries quickly!',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF666666),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: showSupportQueryBottomSheet,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF191C3D),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Get Help',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(Icons.arrow_forward, color: Colors.white, size: 20.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16.0),
        Column(
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildFAQTile(
                title: 'How to Access Course after Purchase?',
                description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildFAQTile({required String title, required String description}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        iconColor: const Color(0xFF191C3D),
        collapsedIconColor: const Color(0xFF666666),
        children: [
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  void showSupportQueryBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColor.scaffold2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Submit a Support Query',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.close, color: Color(0xFF666666)),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.01),
                const Text(
                  'Fill in the details below to submit your query.',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF666666),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                _buildTextField(
                  controller: nameController,
                  hintText: 'Name',
                  prefixIcon: AppIcons.userHelpSupportIcon,
                  validator: (value) => value!.isEmpty ? 'Name is required' : null,
                ),
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email',
                  prefixIcon: AppIcons.emailHelpSupportIcon,
                  validator: (value) =>
                  value!.isEmpty ? 'Email is required' : null,
                ),
                _buildTextField(
                  controller: mobileController,
                  hintText: 'Mobile Number',
                  prefixIcon: AppIcons.phoneHelpSupportIcon,
                  validator: (value) =>
                  value!.isEmpty ? 'Mobile number is required' : null,
                ),
                _buildTextField(
                  controller: addressController,
                  hintText: 'Address',
                  prefixIcon: AppIcons.districtHelpSupportIcon,
                  validator: (value) => value!.isEmpty ? 'Address is required' : null,
                ),
                Obx(() => _buildDropdown(
                  value: helpSupportController.selectedState.value,
                  hintText: 'State',
                  icon: AppIcons.districtHelpSupportIcon,
                  items: helpSupportController.states,
                  onChanged: (value) {
                    helpSupportController.selectedState.value = value;
                    helpSupportController.selectedDistrict.value = null;
                  },
                  validator: (value) => value == null ? 'State is required' : null,
                )),
                Obx(() => _buildDropdown(
                  value: helpSupportController.selectedDistrict.value,
                  hintText: 'District',
                  icon: AppIcons.districtHelpSupportIcon,
                  items: helpSupportController.districts,
                  onChanged: (value) =>
                  helpSupportController.selectedDistrict.value = value,
                  validator: (value) => value == null ? 'District is required' : null,
                )),
                _buildTextField(
                  controller: subjectController,
                  hintText: 'Subject',
                  prefixIcon: AppIcons.districtHelpSupportIcon,
                  validator: (value) => value!.isEmpty ? 'Subject is required' : null,
                ),
                _buildTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  prefixIcon: AppIcons.districtHelpSupportIcon,
                  maxLines: 4,
                  validator: (value) =>
                  value!.isEmpty ? 'Description is required' : null,
                ),
                SizedBox(height: Get.height * 0.03),
                Center(
                  child: Obx(
                        () => SizedBox(
                      width: Get.width * 0.6,
                      child: ElevatedButton(
                        onPressed: isSubmitting.value ? null : _submitQuery,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF191C3D),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          elevation: 0,
                        ),
                        child: isSubmitting.value
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                            : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit Query',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.arrow_forward,
                                color: Colors.white, size: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitQuery() async {
    if (formKey.currentState!.validate() &&
        helpSupportController.selectedState.value != null &&
        helpSupportController.selectedDistrict.value != null) {
      isSubmitting.value = true;
      try {
        final data = {
          "name": nameController.text,
          "email": emailController.text,
          "mobileNumber": mobileController.text,
          "address": addressController.text,
          "city": helpSupportController.selectedDistrict.value,
          "state": helpSupportController.selectedState.value,
          "subject": subjectController.text,
          "description": descriptionController.text,
        };

        final response = await ApiController().submitSupportQuery(
          apiUrl: ApiUrl.submitSupportQuery,
          data: data,
        );

        if (response != null && response.success == true) {
          Get.snackbar(
            'Success',
            'Support query submitted successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            borderRadius: 12.0,
            margin: const EdgeInsets.all(16.0),
          );
          await Future.delayed(Duration(seconds: 2));
          Get.toNamed(RoutesName.helpSupportView);
          nameController.clear();
          emailController.clear();
          mobileController.clear();
          addressController.clear();
          subjectController.clear();
          descriptionController.clear();
          helpSupportController.selectedState.value = null;
          helpSupportController.selectedDistrict.value = null;
        } else {
          Get.snackbar(
            'Error',
            'Failed to submit query. Please try again.',
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            borderRadius: 12.0,
            margin: const EdgeInsets.all(16.0),
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'An error occurred. Please try again.',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 12.0,
          margin: const EdgeInsets.all(16.0),
        );
      } finally {
        isSubmitting.value = false;
      }
    } else {
      Get.snackbar(
        'Error',
        'Please fill all required fields.',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        borderRadius: 12.0,
        margin: const EdgeInsets.all(16.0),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String prefixIcon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF999999),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(prefixIcon, width: 20.0, height: 20.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF191C3D), width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1A1A1A),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hintText,
    required String icon,
    required List<String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF999999),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(icon, width: 20.0, height: 20.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF191C3D), width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
        dropdownColor: Colors.white,
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF666666)),
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: Color(0xFF1A1A1A),
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        validator: validator,
      ),
    );
  }
}