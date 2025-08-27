import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online/data/api_url/api_url.dart';
import 'package:online/models/chat_model/chat_model.dart';
import 'package:online/utils/shared_preferences/shared_pref.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final RxString activeChatId = ''.obs;
  final RxList<ChatModel> chatList = <ChatModel>[].obs;
  final RxBool isSending = false.obs;

  final RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  final RxList<PinnedMessage> pinnedMessages = <PinnedMessage>[].obs;
  final Rx<TextEditingController> messageController =
      TextEditingController().obs;
  final RxBool isLoading = false.obs;
  final RxBool isTyping = false.obs;
// Separate ScrollControllers
  final ScrollController conversationScrollController = ScrollController();
  final ScrollController chatDetailScrollController = ScrollController();
  final ScrollController chatScreenScrollController = ScrollController();
  late IO.Socket socket;
  String? userId;
  String? userRole;

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    messageController.value.addListener(() {
      print('Text changed: ${messageController.value.text}');
    });
    await _connectSocket();
    fetchChatList();
  }

  Future<void> _connectSocket() async {
    String token = await SharedPref.getToken() ?? "";
    socket = IO.io(ApiUrl.liveStreamUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket.connect();

    socket.emit('authenticate', token);

    socket.on('authenticated', (data) {
      if (data['success'] == true) {
        userId = data['id'];
        userRole = data['role'];
        print('Successfully authenticated');
      } else {
        print('Authentication failed: ${data['error']}');
        Get.snackbar('Error', 'Authentication failed');
      }
    });

    socket.on('connect', (_) {
      for (var msg in pendingMessages) {
        socket.emit('sendMessage', {
          'chatId': msg['chatId'],
          'content': msg['content'],
          'isTeacherResponse': msg['isTeacherResponse'],
          'messageId': msg['messageId'],
        });
      }
    });

    socket.on('error', (data) {
      Get.snackbar('Error', data['message'] ?? 'An error occurred');
    });

    socket.on('chatList', (data) {
      chatList.assignAll(
          (data as List).map((chat) => ChatModel.fromJson(chat)).toList());
      isLoading.value = false;
    });

    socket.on('messages', (data) {
      messages.assignAll(
          (data as List).map((msg) => ChatMessageModel.fromJson(msg)).toList());
    });

    socket.on('receiveMessage', (data) {
      messages.add(ChatMessageModel.fromJson(data));
      pendingMessages.removeWhere((pm) => pm['messageId'] == data['messageId']);
      scrollToBottom();
    });

    socket.on('sendMessageError', (data) {
      Get.snackbar('Error', data['message'] ?? 'Failed to send message');
    });

    socket.on('messagesRead', (data) {
      messages.where((msg) => msg.chat == data['chatId']).forEach((msg) {
        msg.isRead = true;
      });
      messages.refresh();
    });

    socket.on('messagePinned', (data) {
      pinnedMessages.add(PinnedMessage.fromJson(data));
      pinnedMessages.refresh();
    });

    socket.on('messageUnpinned', (data) {
      pinnedMessages.removeWhere((pin) => pin.messageId == data['messageId']);
      pinnedMessages.refresh();
    });

    socket.on('pinnedMessages', (data) {
      pinnedMessages.assignAll(
          (data as List).map((pin) => PinnedMessage.fromJson(pin)).toList());
    });

    socket.on('userTyping', (data) {
      isTyping.value = true;
    });

    socket.on('userStoppedTyping', (data) {
      isTyping.value = false;
    });

    socket.on('messageDeleted', (data) {
      messages.removeWhere((msg) => msg.id == data['messageId']);
      messages.refresh();
    });
  }

  void fetchChatList() {
    socket.emit('getChatList');
  }

  void joinChat(String chatId) {
    activeChatId.value = chatId;
    socket.emit('joinChat', chatId);
    fetchMessages(chatId);
    fetchPinnedMessages(chatId);
  }

  void fetchMessages(String chatId) {
    socket.emit('getMessages', chatId);
  }

  void fetchPinnedMessages(String chatId) {
    socket.emit('getPinnedMessages', chatId);
  }

  void clearMessageInput(String chatId) {
    messageController.value.clear();
    if (isTyping.value) {
      stopTyping(chatId);
    }
    activeChatId.value = '';
  }

  final RxList<Map<String, dynamic>> pendingMessages =
      <Map<String, dynamic>>[].obs;

  Future<void> sendMessage(String chatId,
      {bool isTeacherResponse = false}) async {
    if (messageController.value.text.isNotEmpty) {
      final messageId = DateTime.now().millisecondsSinceEpoch.toString();
      if (!socket.connected) {
        pendingMessages.add({
          'messageId': messageId,
          'chatId': chatId,
          'content': messageController.value.text,
          'isTeacherResponse': isTeacherResponse,
        });
        // Add the message to the UI as a pending message
        messages.add(ChatMessageModel(
          id: messageId,
          chat: chatId,
          content: messageController.value.text,
          sender:
              User(id: userId, name: 'You'), // Adjust as per your User model
          timestamp: DateTime.now().toIso8601String(),
          isRead: false,
        ));
        messageController.value.clear();
        Get.snackbar('Info', 'Message queued. Will retry when connected.');
        scrollToBottom();
        return;
      }
      pendingMessages.add({
        'messageId': messageId,
        'chatId': chatId,
        'content': messageController.value.text,
        'isTeacherResponse': isTeacherResponse,
      });
      socket.emit('sendMessage', {
        'chatId': chatId,
        'content': messageController.value.text,
        'isTeacherResponse': isTeacherResponse,
        'messageId': messageId,
      });
      messageController.value.clear();
    }
  }

  void markMessagesAsRead(String chatId) {
    socket.emit('markAsRead', {'chatId': chatId});
  }

  void muteChat(String chatId) {
    socket.emit('muteChat', {'chatId': chatId});
  }

  void unmuteChat(String chatId) {
    socket.emit('unmuteChat', {'chatId': chatId});
  }

  void blockUser(String chatId, String blockUserId) {
    socket.emit('blockUser', {
      'chatId': chatId,
      'blockUserId': blockUserId,
    });
  }

  void unblockUser(String chatId, String unblockUserId) {
    socket.emit('unblockUser', {
      'chatId': chatId,
      'unblockUserId': unblockUserId,
    });
  }

  void pinMessage(String chatId, String messageId) {
    if (userRole == 'Teacher') {
      socket.emit('pinMessage', {
        'chatId': chatId,
        'messageId': messageId,
      });
    }
  }

  void unpinMessage(String chatId, String messageId) {
    if (userRole == 'Teacher') {
      socket.emit('unpinMessage', {
        'chatId': chatId,
        'messageId': messageId,
      });
    }
  }

  void deleteMessage(String chatId, String messageId) {
    socket.emit('deleteMessage', {
      'chatId': chatId,
      'messageId': messageId,
    });
  }

  void startTyping(String chatId) {
    socket.emit('typing', {'chatId': chatId});
  }

  void stopTyping(String chatId) {
    socket.emit('stopTyping', {'chatId': chatId});
  }

// Update scrollToBottom to use the chatDetailScrollController
  void scrollToBottom() {
    if (activeChatId.value.isNotEmpty && chatDetailScrollController.hasClients) {
      chatDetailScrollController.animateTo(
        chatDetailScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void onClose() {
    socket.disconnect();
    messageController.value.dispose();
    conversationScrollController.dispose();
    chatDetailScrollController.dispose();
    chatScreenScrollController.dispose(); // Dispose the new controller
    super.onClose();
  }
}
