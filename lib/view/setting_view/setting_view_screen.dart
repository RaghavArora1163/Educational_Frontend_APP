import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online/controllers/setting_controller/setting_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/app_routes/routes.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

/// A screen that displays user settings with options like logout, account deletion,
/// privacy policy, and terms of conditions.
class SettingViewScreen extends StatefulWidget {
  const SettingViewScreen({super.key});

  @override
  State<SettingViewScreen> createState() => _SettingViewScreenState();
}

class _SettingViewScreenState extends State<SettingViewScreen> {
  // Controller for managing settings-related logic
  final SettingController _settingController = Get.find<SettingController>();

  // URLs for external links
  static const String _privacyPolicyUrl =
      'https://online-course-client-five.vercel.app/privacy-policy';
  static const String _termsOfConditionsUrl =
      'https://online-course-client-five.vercel.app/terms-of-conditions';

  // App metadata
  static const String _appVersion = '1.0.0';
  static const String _copyrightText = '© 2025 AIIMS Nursing Institute';
  static const String _rightsReservedText = 'All Rights Reserved';

  /// Launches a URL in an external browser and handles errors gracefully.
  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      final bool launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        _showErrorSnackBar('Could not launch $url');
      }
    } catch (e) {
      _showErrorSnackBar('Error launching URL: $e');
    }
  }

  /// Displays a snackbar with an error message.
  void _showErrorSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );
  }

  /// Shows a confirmation dialog for logout action.
  Future<bool> _showLogoutConfirmationDialog() async {
    return await _showConfirmationDialog(
      title: 'Confirm Logout',
      message: 'Are you sure you want to log out of your account?',
      confirmText: 'Log Out',
      confirmColor: Colors.red,
    );
  }

  /// Shows a confirmation dialog for account deletion.
  Future<bool> _showDeleteConfirmationDialog() async {
    return await _showConfirmationDialog(
      title: 'Confirm Delete Account',
      message:
      'Deleting your account is permanent and cannot be undone. Are you sure you want to proceed?',
      confirmText: 'Delete',
      confirmColor: Colors.red,
    );
  }

  /// Generic method to show a confirmation dialog with customizable parameters.
  Future<bool> _showConfirmationDialog({
    required String title,
    required String message,
    required String confirmText,
    required Color confirmColor,
  }) async {
    return await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(
              confirmText,
              style: TextStyle(color: confirmColor, fontSize: 16),
            ),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: _settingController.scrollController,
        slivers: [
          _buildAppBar(),
          _buildContent(),
        ],
      ),
    );
  }

  /// Builds the SliverAppBar with a custom app bar component.
  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      toolbarHeight: Get.height * 0.2,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      flexibleSpace: CommonAppbar(
        isDrawerShow: false,
        title: 'Settings',
        onLeadingTap: () => Get.back(),
        isSearchShow: false,
        isNotificationShow: false,
        clipper: CustomAppBarClipper(),
      ),
    );
  }

  /// Builds the main content with settings list and footer.
  SliverToBoxAdapter _buildContent() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSettingsList(),
          SizedBox(height: Get.height * 0.1),
          _buildFooter(),
          SizedBox(height: Get.height * 0.03),
        ],
      ),
    );
  }

  /// Builds the list of settings options.
  Widget _buildSettingsList() {
    final List<IconData> icons = [
      Icons.swap_horiz,
      Icons.privacy_tip,
      Icons.description,
      Icons.delete,
      Icons.logout,
    ];

    // Filter out "Rate Us" item (assumed at index 3 in original list)
    final filteredIndices = List.generate(
      _settingController.settingLabelNames.length,
          (index) => index,
    ).where((index) => index != 0 && index != 3).toList();

    return Obx(
          () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: filteredIndices.asMap().entries.map((entry) {
            final int filteredIndex = entry.key;
            final int originalIndex = entry.value;
            final bool isLast = filteredIndex == filteredIndices.length - 1;
            final bool isDeleteAccount =
                filteredIndex == filteredIndices.length - 2;
            final bool isPrivacyPolicy = originalIndex == 1;
            final bool isTermsOfConditions = originalIndex == 2;

            return Column(
              children: [
                _buildSettingItem(
                  icon: icons[filteredIndex],
                  title: _settingController.settingLabelNames[originalIndex],
                  isLast: isLast,
                  isDeleteAccount: isDeleteAccount,
                  isLoading: _settingController.isLoading.value &&
                      (isLast || isDeleteAccount),
                  onTap: () => _handleSettingItemTap(
                    originalIndex: originalIndex,
                    isPrivacyPolicy: isPrivacyPolicy,
                    isTermsOfConditions: isTermsOfConditions,
                    isDeleteAccount: isDeleteAccount,
                    isLast: isLast,
                  ),
                ),
                if (!isLast) _buildDivider(),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Builds an individual setting item with tap feedback and loading state.
  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required bool isLast,
    required bool isDeleteAccount,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Icon(
            icon,
            color: isLast || isDeleteAccount ? Colors.red : Colors.grey.shade700,
            size: 24,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isLast || isDeleteAccount ? Colors.red : Colors.grey.shade900,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          trailing: isLoading
              ? const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.red,
            ),
          )
              : null,
        ),
      ),
    );
  }

  /// Builds a divider between setting items.
  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey.shade200,
      indent: 16,
      endIndent: 16,
    );
  }

  /// Handles tap events for setting items.
  Future<void> _handleSettingItemTap({
    required int originalIndex,
    required bool isPrivacyPolicy,
    required bool isTermsOfConditions,
    required bool isDeleteAccount,
    required bool isLast,
  }) async {
    if (originalIndex == 0) {
      Get.toNamed(RoutesName.transferCourseView);
    } else if (isPrivacyPolicy) {
      await _launchUrl(_privacyPolicyUrl);
    } else if (isTermsOfConditions) {
      await _launchUrl(_termsOfConditionsUrl);
    } else if (isDeleteAccount) {
      final bool confirmed = await _showDeleteConfirmationDialog();
      if (confirmed) {
        await _settingController.deleteApi();
      }
    } else if (isLast) {
      final bool confirmed = await _showLogoutConfirmationDialog();
      if (confirmed) {
        await _settingController.logoutApi();
      }
    }
  }

  /// Builds the footer with copyright and app version information.
  Widget _buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _copyrightText,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        Text(
          _rightsReservedText,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
        SizedBox(height: Get.height * 0.03),
        Text(
          'App Version $_appVersion',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}