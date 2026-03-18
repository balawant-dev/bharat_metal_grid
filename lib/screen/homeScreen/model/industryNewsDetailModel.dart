class IndustryNewsDetailModel {
  bool? success;
  Data? data;

  IndustryNewsDetailModel({this.success, this.data});

  IndustryNewsDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? shortDescription;
  String? content;
  String? coverImage;
  String? readTime;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.title,
        this.shortDescription,
        this.content,
        this.coverImage,
        this.readTime,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    content = json['content'];
    coverImage = json['coverImage'];
    readTime = json['readTime'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['shortDescription'] = this.shortDescription;
    data['content'] = this.content;
    data['coverImage'] = this.coverImage;
    data['readTime'] = this.readTime;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
