class LatestNoticesModel {
  bool? success;
  int? totalResult;
  int? totalPage;
  List<Data>? data;

  LatestNoticesModel(
      {this.success, this.totalResult, this.totalPage, this.data});

  LatestNoticesModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? title;
  String? shortDescription;
  String? coverImage;
  String? pdfFile;
  bool? isPopular;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.title,
        this.shortDescription,
        this.coverImage,
        this.pdfFile,
        this.isPopular,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    shortDescription = json['shortDescription'];
    coverImage = json['coverImage'];
    pdfFile = json['pdfFile'];
    isPopular = json['isPopular'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['shortDescription'] = this.shortDescription;
    data['coverImage'] = this.coverImage;
    data['pdfFile'] = this.pdfFile;
    data['isPopular'] = this.isPopular;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
