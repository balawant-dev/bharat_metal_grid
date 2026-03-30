class CreatePostModel {
  bool? success;
  String? message;
  Data? data;

  CreatePostModel({this.success, this.message, this.data});

  CreatePostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? title;
  List<String>? image;
  String? description;
  int? like;
  int? dislike;
  String? postedBy;
  String? userType;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.title,
        this.image,
        this.description,
        this.like,
        this.dislike,
        this.postedBy,
        this.userType,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'].cast<String>();
    description = json['description'];
    like = json['like'];
    dislike = json['dislike'];
    postedBy = json['postedBy'];
    userType = json['userType'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['postedBy'] = this.postedBy;
    data['userType'] = this.userType;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
