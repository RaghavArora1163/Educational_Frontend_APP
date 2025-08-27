import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online/controllers/notification_controller/notification_controller.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';
import 'package:intl/intl.dart';
import '../../models/notification_model/notification_model.dart';

class NotificationViewScreen extends StatelessWidget {
  NotificationViewScreen({super.key});

  final NotificationController notificationController = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: Obx(() => CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: notificationController.scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            toolbarHeight: Get.height * .200,
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.scaffold2,
            scrolledUnderElevation: 0,
            flexibleSpace: CommonAppbar(
              isDrawerShow: false,
              title: 'Notifications',
              isSearchShow: false,
              isNotificationShow: false,
              onLeadingTap: () {
                Get.back();
              },
              clipper: CustomAppBarClipper(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: notificationController.isApiCall.value
                  ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.textClr,
                      strokeWidth: 3,
                    ),
                  )
                  : notificationController.isApiErrorShow.value
                  ? Center(
                child: ElevatedButton(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    notificationController.fetchNotifications();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.textClr,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNewNotifications(),
                  if (_hasNewNotifications()) ...[
                    const SizedBox(height: 16),
                    const Divider(
                      color: AppColor.dividerClr,
                      thickness: 0.5,
                      height: 1,
                    ),
                    const SizedBox(height: 16),
                  ],
                  _buildSeenNotifications(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  bool _hasNewNotifications() {
    return (notificationController.notificationModel.value.data?.notifications
        ?.where((n) => n.read == false)
        .toList() ??
        [])
        .isNotEmpty;
  }

  Widget _buildNewNotifications() {
    final newNotifications = notificationController
        .notificationModel.value.data?.notifications
        ?.where((n) => n.read == false)
        .toList() ??
        [];

    return newNotifications.isEmpty
        ? const SizedBox.shrink()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'New',
                style: TextStyle(
                  color: AppColor.textClr,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(
                newNotifications.isNotEmpty
                    ? DateFormat('dd MMM yyyy').format(
                  DateTime.parse(newNotifications.first.createdAt ?? ''),
                )
                    : '',
                style: const TextStyle(
                  color: AppColor.lightTextClr,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AnimatedList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          initialItemCount: newNotifications.length,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: _buildNotificationItem(newNotifications[index]),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSeenNotifications() {
    final seenNotifications = notificationController
        .notificationModel.value.data?.notifications
        ?.where((n) => n.read == true)
        .toList() ??
        [];

    return seenNotifications.isEmpty
        ? const SizedBox.shrink()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Earlier',
            style: TextStyle(
              color: AppColor.textClr,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          initialItemCount: seenNotifications.length,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                child: _buildNotificationItem(seenNotifications[index]),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNotificationItem(Notifications notification) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Dismissible(
        key: Key(notification.sId ?? ''),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 16.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          HapticFeedback.heavyImpact();
          // Implement notification deletion logic here
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                AppColor.scaffold2.withOpacity(0.8),
              ],
              stops: const [0.3, 1.0],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.boxShadowClr.withOpacity(0.15),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            leading: _buildNotificationIcon(notification.type),
            title: Text(
              notification.title ?? '',
              style: TextStyle(
                color: AppColor.textClr,
                fontWeight: notification.read == false ? FontWeight.w600 : FontWeight.w500,
                fontSize: 16,
                height: 1.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  notification.course?.courseTitle ?? '',
                  style: const TextStyle(
                    color: AppColor.quizTextClr,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message ?? '',
                  style: const TextStyle(
                    color: AppColor.lightTextClr,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  DateFormat('hh:mm a • dd MMM').format(
                    DateTime.parse(notification.createdAt ?? '').toLocal(),
                  ),
                  style: const TextStyle(
                    color: AppColor.lightTextClr,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            onTap: () {
              HapticFeedback.lightImpact();
              // Implement notification tap action
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String? type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'live-class':
        icon = Icons.videocam;
        color = const Color(0xFF2196F3); // Blue for live classes
        break;
      case 'course-update':
        icon = Icons.update;
        color = const Color(0xFF4CAF50); // Green for updates
        break;
      case 'assignment':
        icon = Icons.assignment;
        color = const Color(0xFFFF9800); // Orange for assignments
        break;
      case 'quiz':
        icon = Icons.quiz;
        color = const Color(0xFF9C27B0); // Purple for quizzes
        break;
      case 'general':
      default:
        icon = Icons.chat_bubble;
        color = AppColor.lightTextClr; // Neutral for general (chat icon for group chat)
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 28,
      ),
    );
  }
}