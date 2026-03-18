class SelectRoleModel {
  bool? success;
  String? message;
  Data? data;

  SelectRoleModel({this.success, this.message, this.data});

  SelectRoleModel.fromJson(Map<String, dynamic> json) {
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
  String? phoneNumber;
  String? createdAt;
  int? iV;
  String? userType;

  Data({this.sId, this.phoneNumber, this.createdAt, this.iV, this.userType});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    createdAt = json['createdAt'];
    iV = json['__v'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phoneNumber'] = this.phoneNumber;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    data['userType'] = this.userType;
    return data;
  }
}
