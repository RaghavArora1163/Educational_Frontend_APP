import 'package:flutter/material.dart';

class ChatModel {
  String? id;
  String? type;
  String? name;
  List<User>? participants;
  Course? course;
  ChatMessageModel? lastMessage;
  List<String>? mutedBy;
  List<String>? blockedBy;
  List<PinnedMessage>? pinnedMessages;

  ChatModel({
    this.id,
    this.type,
    this.name,
    this.participants,
    this.course,
    this.lastMessage,
    this.mutedBy,
    this.blockedBy,
    this.pinnedMessages,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    name = json['name'];
    participants = json['participants'] != null
        ? (json['participants'] as List).map((i) => User.fromJson(i)).toList()
        : null;
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
    lastMessage = json['lastMessage'] != null
        ? ChatMessageModel.fromJson(json['lastMessage'])
        : null;
    mutedBy = json['mutedBy'] != null ? List<String>.from(json['mutedBy']) : null;
    blockedBy =
    json['blockedBy'] != null ? List<String>.from(json['blockedBy']) : null;
    pinnedMessages = json['pinnedMessages'] != null
        ? (json['pinnedMessages'] as List)
        .map((i) => PinnedMessage.fromJson(i))
        .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['type'] = type;
    data['name'] = name;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    if (course != null) {
      data['course'] = course!.toJson();
    }
    if (lastMessage != null) {
      data['lastMessage'] = lastMessage!.toJson();
    }
    data['mutedBy'] = mutedBy;
    data['blockedBy'] = blockedBy;
    if (pinnedMessages != null) {
      data['pinnedMessages'] = pinnedMessages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatMessageModel {
  String? id;
  String? chat;
  User? sender;
  String? content;
  bool? isTeacherResponse;
  bool? isRead;
  String? timestamp;

  ChatMessageModel({
    this.id,
    this.chat,
    this.sender,
    this.content,
    this.isTeacherResponse,
    this.isRead,
    this.timestamp,
  });

  ChatMessageModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    chat = json['chat'];
    sender = json['sender'] != null ? User.fromJson(json['sender']) : null;
    content = json['content'];
    isTeacherResponse = json['isTeacherResponse'];
    isRead = json['isRead'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['chat'] = chat;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    data['content'] = content;
    data['isTeacherResponse'] = isTeacherResponse;
    data['isRead'] = isRead;
    data['timestamp'] = timestamp;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? role;
  String? avatar;

  User({this.id, this.name, this.email, this.role, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['role'] = role;
    data['avatar'] = avatar;
    return data;
  }
}

class Course {
  String? id;
  String? title;
  User? instructor;

  Course({this.id, this.title, this.instructor});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    instructor =
    json['instructor'] != null ? User.fromJson(json['instructor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = id;
    data['title'] = title;
    if (instructor != null) {
      data['instructor'] = instructor!.toJson();
    }
    return data;
  }
}

class PinnedMessage {
  String? messageId;
  String? pinnedBy;
  String? pinnedAt;

  PinnedMessage({this.messageId, this.pinnedBy, this.pinnedAt});

  PinnedMessage.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    pinnedBy = json['pinnedBy'];
    pinnedAt = json['pinnedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['messageId'] = messageId;
    data['pinnedBy'] = pinnedBy;
    data['pinnedAt'] = pinnedAt;
    return data;
  }
}