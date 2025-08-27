class CoursesDetailModel {
  bool? success;
  CoursesDetailData? data;
  String? message;

  CoursesDetailModel({this.success, this.data, this.message});

  CoursesDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? CoursesDetailData.fromJson(json['data']) : null;
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

class CoursesDetailData {
  CourseDetails? courseDetails;
  StudentResources? studentResources;
  List<Assignments>? assignments;
  List<Quizzes>? quizzes;
  List<LiveClasses>? liveClasses;

  CoursesDetailData({
    this.courseDetails,
    this.studentResources,
    this.assignments,
    this.quizzes,
    this.liveClasses,
  });

  CoursesDetailData.fromJson(Map<String, dynamic> json) {
    courseDetails = json['courseDetails'] != null
        ? CourseDetails.fromJson(json['courseDetails'])
        : null;
    studentResources = json['studentResources'] != null
        ? StudentResources.fromJson(json['studentResources'])
        : null;
    if (json['assignments'] != null) {
      assignments = <Assignments>[];
      json['assignments'].forEach((v) {
        assignments!.add(Assignments.fromJson(v));
      });
    }
    if (json['quizzes'] != null) {
      quizzes = <Quizzes>[];
      json['quizzes'].forEach((v) {
        quizzes!.add(Quizzes.fromJson(v));
      });
    }
    if (json['liveClasses'] != null) {
      liveClasses = <LiveClasses>[];
      json['liveClasses'].forEach((v) {
        liveClasses!.add(LiveClasses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courseDetails != null) {
      data['courseDetails'] = courseDetails!.toJson();
    }
    if (studentResources != null) {
      data['studentResources'] = studentResources!.toJson();
    }
    if (assignments != null) {
      data['assignments'] = assignments!.map((v) => v.toJson()).toList();
    }
    if (quizzes != null) {
      data['quizzes'] = quizzes!.map((v) => v.toJson()).toList();
    }
    if (liveClasses != null) {
      data['liveClasses'] = liveClasses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseDetails {
  String? sId;
  String? title;
  String? description;
  String? courseImage;
  String? introVideo;
  String? courseType;
  String? coursePrice;
  String? difficulty;
  Category? category;
  Instructor? instructor;
  String? prerequisites;
  bool? isEnrolled;
  List<Modules>? modules;
  List<Reviews>? reviews;
  String? session;
  String? createdAt;
  String? updatedAt;
  String? courseDuration;
  Progress? progress;

  CourseDetails({
    this.sId,
    this.title,
    this.description,
    this.courseImage,
    this.introVideo,
    this.courseType,
    this.coursePrice,
    this.difficulty,
    this.category,
    this.instructor,
    this.prerequisites,
    this.isEnrolled,
    this.modules,
    this.reviews,
    this.session,
    this.createdAt,
    this.updatedAt,
    this.courseDuration,
    this.progress,
  });

  CourseDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    courseImage = json['courseImage'];
    introVideo = json['introVideo'];
    courseType = json['courseType'];
    coursePrice = json['coursePrice'];
    difficulty = json['difficulty'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    instructor = json['instructor'] != null ? Instructor.fromJson(json['instructor']) : null;
    prerequisites = json['prerequisites'];
    isEnrolled = json['isEnrolled'];
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    session = json['session'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    courseDuration = json['courseDuration'];
    progress = json['progress'] != null ? Progress.fromJson(json['progress']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['courseImage'] = courseImage;
    data['introVideo'] = introVideo;
    data['courseType'] = courseType;
    data['coursePrice'] = coursePrice;
    data['difficulty'] = difficulty;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (instructor != null) {
      data['instructor'] = instructor!.toJson();
    }
    data['prerequisites'] = prerequisites;
    data['isEnrolled'] = isEnrolled;
    if (modules != null) {
      data['modules'] = modules!.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['session'] = session;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['courseDuration'] = courseDuration;
    if (progress != null) {
      data['progress'] = progress!.toJson();
    }
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Category({
    this.sId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Instructor {
  String? sId;
  String? instructorReviews;
  String? name;
  String? email;

  Instructor({this.sId, this.instructorReviews, this.name, this.email});

  Instructor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    instructorReviews = json['instructorReview'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['instructorReview'] = instructorReviews;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class Modules {
  String? sId;
  String? moduleTitle;
  String? moduleDescription;
  List<Lectures>? lectures;

  Modules({this.sId, this.moduleTitle, this.moduleDescription, this.lectures});

  Modules.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    moduleTitle = json['moduleTitle'];
    moduleDescription = json['moduleDescription'];
    if (json['lectures'] != null) {
      lectures = <Lectures>[];
      json['lectures'].forEach((v) {
        lectures!.add(Lectures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['moduleTitle'] = moduleTitle;
    data['moduleDescription'] = moduleDescription;
    if (lectures != null) {
      data['lectures'] = lectures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lectures {
  String? sId;
  String? title;
  String? duration;
  String? videoUrl;
  List<String>? lectureResources;
  bool? isCompleted;
  String? image;
  String? description;
  List<String>? sharedWith;

  Lectures({
    this.sId,
    this.title,
    this.duration,
    this.videoUrl,
    this.lectureResources,
    this.isCompleted,
    this.image,
    this.description,
    this.sharedWith,
  });

  Lectures.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    duration = json['duration'];
    videoUrl = json['videoUrl'];
    lectureResources = json['lectureResources']?.cast<String>() ?? [];
    isCompleted = json['isCompleted'];
    image = json['image'] ?? '';
    description = json['description'] ?? '';
    sharedWith = json['sharedWith']?.cast<String>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['duration'] = duration;
    data['videoUrl'] = videoUrl;
    data['lectureResources'] = lectureResources;
    data['isCompleted'] = isCompleted;
    data['image'] = image;
    data['description'] = description;
    data['sharedWith'] = sharedWith;
    return data;
  }
}

class Reviews {
  String? sId;
  User? user;
  int? rating;
  String? comment;
  String? reviewType;
  String? createdAt;

  Reviews({
    this.sId,
    this.user,
    this.rating,
    this.comment,
    this.reviewType,
    this.createdAt,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    rating = json['rating'];
    comment = json['comment'];
    reviewType = json['reviewType'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['rating'] = rating;
    data['comment'] = comment;
    data['reviewType'] = reviewType;
    data['createdAt'] = createdAt;
    return data;
  }
}

class User {
  String? sId;
  String? name;

  User({this.sId, this.name});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class Progress {
  QuizzesProgress? quizzesProgress;
  QuizzesProgress? lecturesProgress;
  int? progressPercentage;

  Progress({
    this.quizzesProgress,
    this.lecturesProgress,
    this.progressPercentage,
  });

  Progress.fromJson(Map<String, dynamic> json) {
    quizzesProgress = json['quizzesProgress'] != null
        ? QuizzesProgress.fromJson(json['quizzesProgress'])
        : null;
    lecturesProgress = json['lecturesProgress'] != null
        ? QuizzesProgress.fromJson(json['lecturesProgress'])
        : null;
    progressPercentage = json['progressPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quizzesProgress != null) {
      data['quizzesProgress'] = quizzesProgress!.toJson();
    }
    if (lecturesProgress != null) {
      data['lecturesProgress'] = lecturesProgress!.toJson();
    }
    data['progressPercentage'] = progressPercentage;
    return data;
  }
}

class QuizzesProgress {
  int? completed;
  int? total;
  String? display;

  QuizzesProgress({this.completed, this.total, this.display});

  QuizzesProgress.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    total = json['total'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completed'] = completed;
    data['total'] = total;
    data['display'] = display;
    return data;
  }
}

class StudentResources {
  String? courseTitle;
  int? totalResources;
  List<Resources>? resources;
  String? status;

  StudentResources({
    this.courseTitle,
    this.totalResources,
    this.resources,
    this.status,
  });

  StudentResources.fromJson(Map<String, dynamic> json) {
    courseTitle = json['courseTitle'];
    totalResources = json['totalResources'];
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources!.add(Resources.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['courseTitle'] = courseTitle;
    data['totalResources'] = totalResources;
    if (resources != null) {
      data['resources'] = resources!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class ResourceItem {
  String? url;
  String? title;
  String? description;
  String? sId;

  ResourceItem({this.url, this.title, this.description, this.sId});

  ResourceItem.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    description = json['description'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['title'] = title;
    data['description'] = description;
    data['_id'] = sId;
    return data;
  }
}

class Resources {
  String? moduleTitle;
  String? lectureTitle;
  List<ResourceItem>? allResources;
  int? resourceCount;

  Resources({
    this.moduleTitle,
    this.lectureTitle,
    this.allResources,
    this.resourceCount,
  });

  Resources.fromJson(Map<String, dynamic> json) {
    moduleTitle = json['moduleTitle'];
    lectureTitle = json['lectureTitle'];
    if (json['allResources'] != null) {
      allResources = <ResourceItem>[];
      json['allResources'].forEach((v) {
        allResources!.add(ResourceItem.fromJson(v));
      });
    }
    resourceCount = json['resourceCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['moduleTitle'] = moduleTitle;
    data['lectureTitle'] = lectureTitle;
    if (allResources != null) {
      data['allResources'] = allResources!.map((v) => v.toJson()).toList();
    }
    data['resourceCount'] = resourceCount;
    return data;
  }
}

class Assignments {
  String? title;
  String? description;
  String? dueDate;
  String? status;
  String? id;
  String? submissionStatus;
  int? grade;

  Assignments({
    this.title,
    this.description,
    this.dueDate,
    this.status,
    this.id,
    this.submissionStatus,
    this.grade,
  });

  Assignments.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    dueDate = json['dueDate'];
    status = json['status'];
    id = json['id'];
    submissionStatus = json['submissionStatus'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['dueDate'] = dueDate;
    data['status'] = status;
    data['id'] = id;
    data['submissionStatus'] = submissionStatus;
    data['grade'] = grade;
    return data;
  }
}

class Quizzes {
  String? title;
  String? description;
  String? duration;
  String? status;
  String? id;
  String? score;
  String? quizStatus;

  Quizzes({
    this.title,
    this.description,
    this.duration,
    this.status,
    this.id,
    this.score,
    this.quizStatus,
  });

  Quizzes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    status = json['status'];
    id = json['id'];
    score = json['score'];
    quizStatus = json['quizStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['duration'] = duration;
    data['status'] = status;
    data['id'] = id;
    data['score'] = score;
    data['quizStatus'] = quizStatus;
    return data;
  }
}

class LiveClasses {
  String? id;
  String? liveClassStatus;
  String? title;
  String? description;
  String? startTime;
  String? endTime;
  String? courseImage;

  LiveClasses({
    this.id,
    this.liveClassStatus,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.courseImage,
  });

  LiveClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    liveClassStatus = json['liveClassStatus'];
    title = json['title'];
    description = json['description'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    courseImage = json['courseImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['liveClassStatus'] = liveClassStatus;
    data['title'] = title;
    data['description'] = description;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['courseImage'] = courseImage;
    return data;
  }
}