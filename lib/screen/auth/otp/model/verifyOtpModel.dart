class VerifyOtpModel {
  bool? success;
  String? message;
  String? token;
  Data? data;

  VerifyOtpModel({this.success, this.message, this.token,this.data});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
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
  String? userType;
  String? createdAt;
  int? iV;

  Data({this.sId, this.phoneNumber, this.createdAt, this.userType,this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phoneNumber'] = this.phoneNumber;
    data['userType'] = this.userType;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
