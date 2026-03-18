class LatestNoticesDetailModel {
  bool? success;
  Data? data;

  LatestNoticesDetailModel({this.success, this.data});

  LatestNoticesDetailModel.fromJson(Map<String, dynamic> json) {
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
