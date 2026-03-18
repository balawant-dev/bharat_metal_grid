class GetBannerModel {
  bool? success;
  String? message;
  Data? data;

  GetBannerModel({this.success, this.message, this.data});

  GetBannerModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  List<String>? banners;
  String? createdAt;
  int? iV;

  Data({this.sId, this.banners, this.createdAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    banners = json['banners'].cast<String>();
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['banners'] = this.banners;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
