class StudentLecturesModel {
  bool? success;
  LecturesData? data;
  String? message;

  StudentLecturesModel({this.success, this.data, this.message});

  StudentLecturesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? LecturesData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class LecturesData {
  Lecture? lecture;
  List<NextLectures>? nextLectures;
  Course? course;

  LecturesData({this.lecture, this.nextLectures, this.course});

  LecturesData.fromJson(Map<String, dynamic> json) {
    lecture = json['lecture'] != null ? Lecture.fromJson(json['lecture']) : null;
    if (json['nextLectures'] != null) {
      nextLectures = <NextLectures>[];
      json['nextLectures'].forEach((v) {
        nextLectures!.add(NextLectures.fromJson(v));
      });
    }
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (lecture != null) {
      data['lecture'] = lecture!.toJson();
    }
    if (nextLectures != null) {
      data['nextLectures'] = nextLectures!.map((v) => v.toJson()).toList();
    }
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class Lecture {
  String? sId;
  String? title;
  String? videoUrl;
  String? duration;
  List<Resource>? resources; // Updated to List<Resource>
  bool? isCompleted;
  String? moduleTitle;
  String? moduleId;
  String? courseImage;
  String? creatorName;
  String? image;
  String? description;
  List<String>? sharedWith;

  Lecture({
    this.sId,
    this.title,
    this.videoUrl,
    this.duration,
    this.resources,
    this.isCompleted,
    this.moduleTitle,
    this.moduleId,
    this.courseImage,
    this.creatorName,
    this.image,
    this.description,
    this.sharedWith,
  });

  Lecture.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    duration = json['duration'];
    if (json['resources'] != null) {
      resources = <Resource>[];
      json['resources'].forEach((v) {
        resources!.add(Resource.fromJson(v));
      });
    }
    isCompleted = json['isCompleted'];
    moduleTitle = json['moduleTitle'];
    moduleId = json['moduleId'];
    courseImage = json['courseImage'];
    creatorName = json['creatorName'];
    image = json['image'];
    description = json['description'];
    sharedWith = json['sharedWith']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['videoUrl'] = videoUrl;
    data['duration'] = duration;
    if (resources != null) {
      data['resources'] = resources!.map((v) => v.toJson()).toList();
    }
    data['isCompleted'] = isCompleted;
    data['moduleTitle'] = moduleTitle;
    data['moduleId'] = moduleId;
    data['courseImage'] = courseImage;
    data['creatorName'] = creatorName;
    data['image'] = image;
    data['description'] = description;
    data['sharedWith'] = sharedWith;
    return data;
  }
}

class Resource {
  String? url;
  String? title;
  String? description;
  String? sId;

  Resource({this.url, this.title, this.description, this.sId});

  Resource.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    description = json['description'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['title'] = title;
    data['description'] = description;
    data['_id'] = sId;
    return data;
  }
}

class NextLectures {
  String? sId;
  String? nextUrl;
  String? title;
  String? duration;
  String? moduleTitle;
  String? courseImage;
  String? creatorName;
  bool? isCompleted;
  String? nextLecutureModuleId;
  String? image;
  String? description;
  List<String>? sharedWith;

  NextLectures({
    this.sId,
    this.nextUrl,
    this.title,
    this.duration,
    this.moduleTitle,
    this.courseImage,
    this.creatorName,
    this.isCompleted,
    this.nextLecutureModuleId,
    this.image,
    this.description,
    this.sharedWith,
  });

  NextLectures.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    nextUrl = json['videoUrl'];
    title = json['title'];
    duration = json['duration'];
    moduleTitle = json['moduleTitle'];
    courseImage = json['courseImage'];
    creatorName = json['creatorName'];
    isCompleted = json['isCompleted'];
    nextLecutureModuleId = json['nextLecutureModuleId'];
    image = json['image'];
    description = json['description'];
    sharedWith = json['sharedWith']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['videoUrl'] = nextUrl;
    data['title'] = title;
    data['duration'] = duration;
    data['moduleTitle'] = moduleTitle;
    data['courseImage'] = courseImage;
    data['creatorName'] = creatorName;
    data['isCompleted'] = isCompleted;
    data['nextLecutureModuleId'] = nextLecutureModuleId;
    data['image'] = image;
    data['description'] = description;
    data['sharedWith'] = sharedWith;
    return data;
  }
}

class Course {
  String? id;
  String? subscriptionDuration;

  Course({this.id, this.subscriptionDuration});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionDuration = json['subscriptionDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['subscriptionDuration'] = subscriptionDuration;
    return data;
  }
}