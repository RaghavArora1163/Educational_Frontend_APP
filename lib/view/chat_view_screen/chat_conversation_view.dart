import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/controllers/chat_controller/chat_controller.dart';
import 'package:online/models/chat_model/chat_model.dart';
import 'package:online/utils/app_colors/app_color.dart';
import 'package:intl/intl.dart';

class ChatConversationView extends StatelessWidget {
  const ChatConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();

    return Scaffold(
      backgroundColor: AppColor.scaffold2,
      body: Obx(() {
        if (chatController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(AppColor.textClr),
              backgroundColor: AppColor.lightTextClr.withOpacity(0.2),
            ),
          );
        }
        return Stack(
          children: [
            CustomScrollView(
              controller: chatController.conversationScrollController, // Use conversationScrollController
              slivers: [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: AppColor.scaffold2,
                  elevation: 0,
                  title: const Text(
                    'Conversations',
                    style: TextStyle(
                      color: AppColor.textClr,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColor.textClr),
                    onPressed: () {
                      debugPrint('ChatConversationView: Back button pressed');
                      Get.back();
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: chatController.chatList.isEmpty
                      ? const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'No conversations available',
                          style: TextStyle(
                            color: AppColor.lightTextClr,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  )
                      : SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final chat = chatController.chatList[index];
                        return _ChatTile(chat: chat);
                      },
                      childCount: chatController.chatList.length,
                    ),
                  ),
                ),
              ],
            ),
            if (!chatController.isLoading.value && chatController.chatList.isNotEmpty)
              Positioned(
                bottom: 16,
                right: 16,
                child: _ScrollToBottomButton(controller: chatController.conversationScrollController), // Use conversationScrollController
              ),
          ],
        );
      }),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final ChatModel chat;

  const _ChatTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();
    final participant = chat.type == 'personal'
        ? chat.participants?.firstWhere(
          (p) => p.id != chatController.userId,
      orElse: () => User(name: '', id: '', email: '', role: '', avatar: ''),
    ) ??
        User(name: '', id: '', email: '', role: '', avatar: '')
        : null;
    final displayName = chat.type == 'personal'
        ? participant?.name?.isNotEmpty == true
        ? participant!.name!
        : 'Unknown'
        : chat.name ?? chat.course?.title ?? 'Group Chat';
    final isMuted = chat.mutedBy?.contains(chatController.userId) ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          debugPrint('ChatConversationView: Opening chat ${chat.id}');
          chatController.joinChat(chat.id!);
          Get.to(() => ChatDetailView(chat: chat));
        },
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(isMuted ? Icons.volume_up : Icons.volume_off),
                  title: Text(isMuted ? 'Unmute Chat' : 'Mute Chat'),
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: Text(isMuted ? 'Unmute Chat' : 'Mute Chat'),
                        content: Text('Are you sure you want to ${isMuted ? 'unmute' : 'mute'} this chat?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              if (isMuted) {
                                chatController.unmuteChat(chat.id!);
                              } else {
                                chatController.muteChat(chat.id!);
                              }
                              Get.back();
                              Navigator.pop(context);
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 100),
          child: Card(
            elevation: 3,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: AppColor.lightTextClr.withOpacity(0.2), width: 1),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  _buildAvatar(
                    name: chat.type == 'personal' ? participant?.name : chat.name ?? chat.course?.title,
                    avatarUrl: chat.type == 'personal' ? participant?.avatar : null,
                    isGroup: chat.type == 'group',
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              displayName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColor.textClr,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              semanticsLabel: chat.type == 'group' ? 'Group: $displayName' : 'Chat with $displayName',
                            ),
                            if (chat.lastMessage?.timestamp != null)
                              Text(
                                DateFormat('hh:mm a').format(DateTime.parse(chat.lastMessage!.timestamp!)),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColor.lightTextClr,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                chat.lastMessage?.content ?? 'No messages yet',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.lightTextClr,
                                  fontWeight: chat.lastMessage?.isRead == false &&
                                      chat.lastMessage?.sender?.id != chatController.userId
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                            if (isMuted)
                              const Icon(Icons.volume_off, size: 18, color: AppColor.lightTextClr),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar({String? name, String? avatarUrl, required bool isGroup}) {
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
    final backgroundColor = backgroundColors[(initials.hashCode % backgroundColors.length)];

    return Stack(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: backgroundColor,
          child: avatarUrl != null && avatarUrl.isNotEmpty && !isGroup
              ? ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColor.textClr,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColor.textClr,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          )
              : Center(
            child: Text(
              initials,
              style: const TextStyle(
                color: AppColor.textClr,
                fontWeight: FontWeight.w600,
                fontSize: 18,
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
              child: const Icon(
                Icons.group,
                size: 14,
                color: AppColor.textClr,
              ),
            ),
          ),
      ],
    );
  }
}
class ChatDetailView extends StatelessWidget {
  final ChatModel chat;

  const ChatDetailView({super.key, required this.chat});
  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();

    // Schedule scrollToBottom after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatController.scrollToBottom();
    });

    final participant = chat.type == 'personal'
        ? chat.participants?.firstWhere(
          (p) => p.id != chatController.userId,
      orElse: () => User(name: '', id: '', email: '', role: '', avatar: ''),
    ) ??
        User(name: '', id: '', email: '', role: '', avatar: '')
        : null;
    final displayName = chat.type == 'personal'
        ? participant?.name?.isNotEmpty == true
        ? participant!.name!
        : 'Unknown'
        : chat.name ?? chat.course?.title ?? 'Group Chat';

    return WillPopScope(
      onWillPop: () async {
        chatController.clearMessageInput(chat.id!);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffold2,
        appBar: AppBar(
          backgroundColor: AppColor.scaffold2,
          elevation: 0,
          title: Text(
            displayName,
            style: const TextStyle(
              color: AppColor.textClr,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.textClr),
            onPressed: () {
              chatController.clearMessageInput(chat.id!); // Also clear on back button
              Get.back();
            },
          ),
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                debugPrint('ChatDetailView: Menu option $value selected for chat ${chat.id}');
                if (value == 'block' && chat.type == 'personal') {
                  final otherUserId = participant?.id;
                  if (otherUserId != null && otherUserId.isNotEmpty) {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Block User'),
                        content: const Text('Are you sure you want to block this user?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              chatController.blockUser(chat.id!, otherUserId);
                              Get.back();
                            },
                            child: const Text('Block'),
                          ),
                        ],
                      ),
                    );
                  }
                } else if (value == 'mute') {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Mute Chat'),
                      content: const Text('Are you sure you want to mute this chat?'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            chatController.muteChat(chat.id!);
                            Get.back();
                          },
                          child: const Text('Mute'),
                        ),
                      ],
                    ),
                  );
                } else if (value == 'unmute') {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Unmute Chat'),
                      content: const Text('Are you sure you want to unmute this chat?'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            chatController.unmuteChat(chat.id!);
                            Get.back();
                          },
                          child: const Text('Unmute'),
                        ),
                      ],
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                if (chat.type == 'personal') const PopupMenuItem(value: 'block', child: Text('Block')),
                if (chat.mutedBy?.contains(chatController.userId) ?? false)
                  const PopupMenuItem(value: 'unmute', child: Text('Unmute'))
                else
                  const PopupMenuItem(value: 'mute', child: Text('Mute')),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Obx(() {
              if (chatController.pinnedMessages.isEmpty) return const SizedBox.shrink();
              return Dismissible(
                key: Key(chatController.pinnedMessages.first.messageId ?? 'pinned'),
                direction: chatController.userRole == 'Teacher'
                    ? DismissDirection.horizontal
                    : DismissDirection.none,
                onDismissed: (direction) {
                  if (chatController.userRole == 'Teacher') {
                    chatController.unpinMessage(
                        chat.id!, chatController.pinnedMessages.first.messageId!);
                  }
                },
                background: Container(
                  color: Colors.redAccent,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: Container(
                  color: AppColor.quizOptionCardClr.withOpacity(0.5),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.push_pin, size: 20, color: AppColor.textClr),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          chatController.pinnedMessages.first.messageId != null
                              ? chatController.messages
                              .firstWhere(
                                (m) => m.id == chatController.pinnedMessages.first.messageId,
                            orElse: () => ChatMessageModel(content: 'Pinned message'),
                          )
                              .content ??
                              'Pinned message'
                              : 'Pinned message',
                          style: const TextStyle(fontSize: 14, color: AppColor.textClr),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Expanded(
              child: Obx(() {
                if (chatController.messages.isEmpty) {
                  return const Center(
                    child: Text(
                      'No messages yet',
                      style: TextStyle(
                        color: AppColor.lightTextClr,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  controller: chatController.chatDetailScrollController, // Use chatDetailScrollController
                  padding: const EdgeInsets.all(12),
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.messages[index];
                    final isSender = message.sender?.id == chatController.userId;
                    return _MessageBubble(
                      message: message,
                      isSender: isSender,
                      chat: chat,
                    );
                  },
                );
              }),
            ),
            Obx(() {
              if (!chatController.isTyping.value) return const SizedBox.shrink();
              final typingUser = chat.type == 'personal'
                  ? chat.participants
                  ?.firstWhere(
                    (p) => p.id != chatController.userId,
                orElse: () => User(name: 'Someone', id: '', email: '', role: '', avatar: ''),
              )
                  ?.name
                  : 'Someone';
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      '$typingUser is typing',
                      style: const TextStyle(color: AppColor.lightTextClr, fontSize: 14),
                      semanticsLabel: '$typingUser is typing',
                    ),
                    const SizedBox(width: 4),
                    const _TypingIndicator(),
                  ],
                ),
              );
            }),
            _MessageInput(chatId: chat.id!),
          ],
        ),
      ),
    );
  }
}


class _MessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isSender;
  final ChatModel chat;

  const _MessageBubble({
    required this.message,
    required this.isSender,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();
    final sender = message.sender ?? User(name: 'Unknown', id: '', email: '', role: '', avatar: '');
    final isPending = chatController.pendingMessages.any((pm) => pm['messageId'] == message.id);
    final isFailed = false; // Placeholder for failed state tracking

    return GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (chatController.userRole == 'Teacher' && chat.type == 'group')
                ListTile(
                  leading: const Icon(Icons.push_pin),
                  title: const Text('Pin Message'),
                  onTap: () {
                    chatController.pinMessage(chat.id!, message.id!);
                    Navigator.pop(context);
                  },
                ),
              if (chatController.userRole == 'Teacher' || isSender)
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete Message'),
                  onTap: () {
                    chatController.deleteMessage(chat.id!, message.id!);
                    Navigator.pop(context);
                  },
                ),
              if (chat.type == 'group' && !isSender)
                ListTile(
                  leading: const Icon(Icons.report),
                  title: const Text('Report Message'),
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Report Message'),
                        content: const Text('Are you sure you want to report this message?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Placeholder for report functionality
                              Get.snackbar('Info', 'Message reported');
                              Get.back();
                            },
                            child: const Text('Report'),
                          ),
                        ],
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
      onDoubleTap: () {
        if (!isSender && message.isRead == false) {
          chatController.markMessagesAsRead(chat.id!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSender && chat.type == 'group') ...[
              _buildAvatar(
                name: sender.name,
                avatarUrl: sender.avatar,
                isGroup: false,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSender
                          ? isPending
                          ? Colors.blue[50]
                          : Colors.blue[100]
                          : Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.boxShadowClr.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (chat.type == 'group' || !isSender)
                          Text(
                            sender.name ?? 'Unknown',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: isSender ? Colors.blue[800] : Colors.grey[800],
                            ),
                          ),
                        if (chat.type == 'group' || !isSender) const SizedBox(height: 4),
                        Text(
                          message.content ?? '',
                          style: const TextStyle(fontSize: 16),
                          semanticsLabel: isSender
                              ? 'Your message: ${message.content}'
                              : '${sender.name}\'s message: ${message.content}',
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              message.timestamp != null
                                  ? DateFormat('hh:mm a').format(DateTime.parse(message.timestamp!))
                                  : '',
                              style: const TextStyle(fontSize: 12, color: AppColor.lightTextClr),
                            ),
                            if (isSender && message.isRead == true)
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Icon(Icons.done_all, size: 16, color: Colors.blue[600]),
                              ),
                            if (isPending)
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(Icons.access_time, size: 16, color: AppColor.lightTextClr),
                              ),
                            if (isFailed)
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(Icons.error_outline, size: 16, color: Colors.redAccent),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (isFailed)
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: GestureDetector(
                        onTap: () {
                          // Placeholder for retry logic
                          Get.snackbar('Info', 'Retrying message send');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.boxShadowClr.withOpacity(0.2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.refresh, size: 16, color: Colors.redAccent),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar({String? name, String? avatarUrl, required bool isGroup}) {
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
    final backgroundColor = backgroundColors[(initials.hashCode % backgroundColors.length)];

    return Stack(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: backgroundColor,
          child: avatarUrl != null && avatarUrl.isNotEmpty && !isGroup
              ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              height: 32,
              width: 32,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColor.textClr,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: AppColor.textClr,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          )
              : Center(
            child: Text(
              initials,
              style: const TextStyle(
                color: AppColor.textClr,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ),
        if (isGroup)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColor.textClr, width: 1),
              ),
              child: const Icon(
                Icons.group,
                size: 10,
                color: AppColor.textClr,
              ),
            ),
          ),
      ],
    );
  }
}

class _MessageInput extends StatelessWidget {
  final String chatId;

  const _MessageInput({required this.chatId});

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.find<ChatController>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: chatController.messageController.value,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: AppColor.lightTextClr),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColor.quizOptionCardClr.withOpacity(0.5),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onChanged: (value) {
                if (value.isNotEmpty && !chatController.isTyping.value) {
                  chatController.startTyping(chatId);
                } else if (value.isEmpty && chatController.isTyping.value) {
                  chatController.stopTyping(chatId);
                }
              },
            ),
          ),
          const SizedBox(width: 8),
          Obx(
                () => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    chatController.isSending.value
                    ? Colors.grey[400]
                    : Colors.blue[600],
              ),
              child: chatController.isSending.value
                  ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed:
                    chatController.isSending.value
                    ? null
                    : () {
                  print("kuch tho karna padhage");
                  chatController.isSending.value = true;
                  chatController.sendMessage(chatId).then((_) {
                    chatController.isSending.value = false;
                  }).catchError((e) {
                    chatController.isSending.value = false;
                    Get.snackbar('Error', 'Failed to send message');
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  _TypingIndicatorState createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.3, end: 1).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(index * 0.2, (index + 1) * 0.2, curve: Curves.easeInOut),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: AppColor.lightTextClr,
            ),
          ),
        );
      }),
    );
  }
}

class _ScrollToBottomButton extends StatelessWidget {
  final ScrollController controller;

  const _ScrollToBottomButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAtBottom = controller.hasClients &&
          controller.offset >= controller.position.maxScrollExtent - 50;
      return AnimatedOpacity(
        opacity: isAtBottom ? 0 : 1,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          mini: true,
          backgroundColor: Colors.blue[600],
          onPressed: () {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          child: const Icon(Icons.arrow_downward, color: Colors.white),
        ),
      );
    });
  }
}