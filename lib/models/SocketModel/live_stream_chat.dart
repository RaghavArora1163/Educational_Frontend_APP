class LiveStreamChatModel {
  String? sId;
  String? liveClass;
  User? user;
  String? content;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? iV;

  LiveStreamChatModel(
      {this.sId,
        this.liveClass,
        this.user,
        this.content,
        this.isBlocked,
        this.createdAt,
        this.updatedAt,
        this.iV});

  LiveStreamChatModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    liveClass = json['liveClass'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    content = json['content'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['liveClass'] = this.liveClass;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['content'] = this.content;
    data['isBlocked'] = this.isBlocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;

  User({this.sId, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
