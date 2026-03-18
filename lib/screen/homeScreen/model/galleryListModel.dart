class GalleryListModel {
  bool? success;
  int? totalResult;
  int? totalPage;
  List<GalleryData>? data;

  GalleryListModel({this.success, this.totalResult, this.totalPage, this.data});

  GalleryListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResult = json['totalResult'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = <GalleryData>[];
      json['data'].forEach((v) {
        data!.add(new GalleryData.fromJson(v));
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

class GalleryData {
  String? sId;
  String? title;
  List<String>? images;
  bool? isActive;
  String? createdAt;
  int? iV;

  GalleryData(
      {this.sId,
        this.title,
        this.images,
        this.isActive,
        this.createdAt,
        this.iV});

  GalleryData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    images = json['images'].cast<String>();
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['images'] = this.images;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
