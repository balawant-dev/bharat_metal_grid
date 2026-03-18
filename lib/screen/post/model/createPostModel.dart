class CreatePostModel {
  var success;
  var totalResult;
  var totalPage;
  List<Data>? data;

  CreatePostModel({this.success, this.totalResult, this.totalPage, this.data});

  CreatePostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResult = json['totalResult'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['totalResult'] = this.totalResult;
    data['totalPage'] = this.totalPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var sId;
  var title;
  List<String>? image;
  var description;
  var like;
  var dislike;
  var createdAt;
  var iV;

  Data(
      {this.sId,
        this.title,
        this.image,
        this.description,
        this.like,
        this.dislike,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    image = json['image'].cast<String>();
    description = json['description'];
    like = json['like'];
    dislike = json['dislike'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
