class LeaderShipModel {
  bool? success;
  int? totalResult;
  int? totalPage;
  List<Data>? data;

  LeaderShipModel({this.success, this.totalResult, this.totalPage, this.data});

  LeaderShipModel.fromJson(Map<String, dynamic> json) {
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
  String? profileImg;
  String? name;
  String? designation;
  String? createdAt;

  Data(
      {this.sId, this.profileImg, this.name, this.designation, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImg = json['profileImg'];
    name = json['name'];
    designation = json['designation'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profileImg'] = this.profileImg;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
