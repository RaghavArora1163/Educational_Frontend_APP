class YouTubeUrlModel {
  bool? success;
  List<YouTubeData>? data;
  String? message;

  YouTubeUrlModel({this.success, this.data, this.message});

  YouTubeUrlModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <YouTubeData>[];
      json['data'].forEach((v) {
        data!.add(new YouTubeData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class YouTubeData {
  String? sId;
  String? thumbnail;
  String? url;

  YouTubeData({this.sId, this.thumbnail, this.url});

  YouTubeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    thumbnail = json['thumbnail'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['thumbnail'] = this.thumbnail;
    data['url'] = this.url;
    return data;
  }
}
