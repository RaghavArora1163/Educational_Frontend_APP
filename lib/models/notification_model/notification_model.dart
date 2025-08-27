import 'package:online/models/std_fet_courses_model/std_fet_courses_model.dart';

class NotificationModel {
  bool? success;
  NotificationData? data;
  String? message;

  NotificationModel({this.success, this.data, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class NotificationData {
  List<Notifications>? notifications;
  Pagination? pagination;

  NotificationData({this.notifications, this.pagination});

  NotificationData.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(Notifications.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['notifications'] = notifications!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Notifications {
  String? sId;
  String? user;
  String? title;
  String? message;
  String? type;
  Course? course;
  bool? read;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Notifications({
    this.sId,
    this.user,
    this.title,
    this.message,
    this.type,
    this.course,
    this.read,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
    read = json['read'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['title'] = title;
    data['message'] = message;
    data['type'] = type;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    data['read'] = read;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Course {
  String? courseId;
  String? courseTitle;

  Course({this.courseId, this.courseTitle});

  Course.fromJson(Map<String, dynamic> json) {
    courseId = json['_id'];
    courseTitle = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = courseId;
    data['title'] = courseTitle;
    return data;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;

  Pagination({this.page, this.limit, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total'] = total;
    return data;
  }
}