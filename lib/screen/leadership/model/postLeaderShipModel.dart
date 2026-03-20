class PostLeaderShipModel {
  bool? success;
  String? message;
  Data? data;

  PostLeaderShipModel({this.success, this.message, this.data});

  PostLeaderShipModel.fromJson(Map<String, dynamic> json) {
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
  String? association;
  String? profileImg;
  String? name;
  String? designation;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.association,
        this.profileImg,
        this.name,
        this.designation,
        this.sId,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    association = json['association'];
    profileImg = json['profileImg'];
    name = json['name'];
    designation = json['designation'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['association'] = this.association;
    data['profileImg'] = this.profileImg;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
