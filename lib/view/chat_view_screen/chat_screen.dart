import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/chat_controller/chat_controller.dart';
import 'package:online/models/chat_model/chat_model.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:online/utils/extension/dimmention/dimmention.dart';
import 'package:online/view/chat_view_screen/chat_conversation_view.dart';
import 'package:online/utils/widget_component/common_appbar_component/common_appbar.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: Obx(() => CustomScrollView(
            controller: chatController.chatScreenScrollController,
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                toolbarHeight: Get.height * .200,
                automaticallyImplyLeading: false,
                backgroundColor: AppColor.scaffold2,
                scrolledUnderElevation: 0,
                flexibleSpace: CommonAppbar(
                  onLeadingTap: () => Get.back(),
                  isSearchShow: false,
                  isDrawerShow: false,
                  isNotificationShow: false,
                  title: 'Chats',
                  clipper: CustomAppBarClipper(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: chatController.isLoading.value
                      ? _buildLoadingIndicator()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionHeader('New Messages'),
                            SizedBox(height: Get.height * 0.015),
                            _buildNewMessagesList(),
                            SizedBox(height: Get.height * 0.025),
                            _buildSectionHeader('All Chats'),
                            SizedBox(height: Get.height * 0.015),
                            _buildChatList(),
                          ],
                        ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: Get.height * 0.5,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.textClr),
          backgroundColor: AppColor.lightTextClr.withOpacity(0.2),
          strokeWidth: 5.0,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColor.textClr,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildNewMessagesList() {
    final displayCount =
        chatController.chatList.length > 3 ? 3 : chatController.chatList.length;
    if (displayCount == 0) {
      return _buildEmptyState();
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: displayCount,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          _buildChatItem(chatController.chatList[index]),
    );
  }

  Widget _buildChatList() {
    if (chatController.chatList.isEmpty) {
      return _buildEmptyState();
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chatController.chatList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) =>
          _buildChatItem(chatController.chatList[index]),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
        child: Text(
          'No chats available',
          style: TextStyle(
            color: AppColor.lightTextClr,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildChatItem(ChatModel chat) {
    final isUnread = chat.lastMessage?.isRead == false;
    final participant = chat.type == 'personal'
        ? chat.participants?.firstWhere(
              (p) => p.id != chatController.userId,
              orElse: () =>
                  User(name: '', id: '', email: '', role: '', avatar: ''),
            ) ??
            User(name: '', id: '', email: '', role: '', avatar: '')
        : null;
    final displayName = chat.type == 'personal'
        ? participant?.name?.isNotEmpty == true
            ? participant!.name!
            : 'Unknown Chat'
        : chat.name ?? chat.course?.title ?? 'Group Chat';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          chatController.joinChat(chat.id!);
          Get.to(() => ChatDetailView(chat: chat));
        },
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 100),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.boxShadowClr.withOpacity(0.3),
                  blurRadius: 6.0,
                  spreadRadius: 1.5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  leading: Stack(
                    children: [
                      _buildAvatar(
                        name: chat.type == 'personal'
                            ? participant!.name
                            : chat.name ?? chat.course?.title,
                        avatarUrl: chat.type == 'personal'
                            ? participant!.avatar
                            : null,
                        isGroup: chat.type == 'group',
                      ),
                      if (isUnread)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(
                    displayName,
                    style: TextStyle(
                      color: AppColor.textClr,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      height: 1.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      chat.lastMessage?.content ?? 'No messages yet',
                      style: TextStyle(
                        color: AppColor.lightTextClr,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chat.lastMessage?.timestamp
                                ?.split('T')[1]
                                .substring(0, 5) ??
                            '',
                        style: TextStyle(
                          color: AppColor.lightTextClr,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(
      {String? name, String? avatarUrl, required bool isGroup}) {
    final initials = name?.isNotEmpty == true
        ? name!.split(' ').map((e) => e[0]).take(2).join()
        : isGroup
            ? 'G'
            : 'U';
    final backgroundColors = [
      AppColor.quizOptionCardClr,
      Colors.blue.shade200,
      Colors.green.shade200,
      Colors.purple.shade200,
    ];
    final backgroundColor =
        backgroundColors[(initials.hashCode % backgroundColors.length)];

    return Stack(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: backgroundColor,
          child: avatarUrl != null && avatarUrl.isNotEmpty && !isGroup
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: Text(
                        initials,
                        style: TextStyle(
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text(
                        initials,
                        style: TextStyle(
                          color: AppColor.textClr,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                      color: AppColor.textClr,
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    ),
                  ),
                ),
        ),
        if (isGroup)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.textClr, width: 1),
              ),
              child: Icon(
                Icons.group,
                size: 16,
                color: AppColor.textClr,
              ),
            ),
          ),
      ],
    );
  }
}
