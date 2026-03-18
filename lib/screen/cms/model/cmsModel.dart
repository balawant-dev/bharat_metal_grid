class CMSModel {
  bool? success;
  Data? data;

  CMSModel({this.success, this.data});

  CMSModel.fromJson(Map<String, dynamic> json) {
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
  Payload? payload;
  String? createdAt;
  int? iV;

  Data({this.sId, this.payload, this.createdAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    payload =
    json['payload'] != null ? new Payload.fromJson(json['payload']) : null;
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Payload {
  String? brandName;
  String? googleMapApiKey;
  String? razorpayKeyId;
  String? razorpayKeySecret;
  String? agreement;
  String? termAndConditions;
  String? privacyPolicy;
  String? refundPolicy;
  String? primaryColor;
  String? secondryColor;
  String? baseUrl;

  Payload(
      {this.brandName,
        this.googleMapApiKey,
        this.razorpayKeyId,
        this.razorpayKeySecret,
        this.agreement,
        this.termAndConditions,
        this.privacyPolicy,
        this.refundPolicy,
        this.primaryColor,
        this.secondryColor,
        this.baseUrl});

  Payload.fromJson(Map<String, dynamic> json) {
    brandName = json['brandName'];
    googleMapApiKey = json['googleMapApiKey'];
    razorpayKeyId = json['razorpayKeyId'];
    razorpayKeySecret = json['razorpayKeySecret'];
    agreement = json['agreement'];
    termAndConditions = json['termAndConditions'];
    privacyPolicy = json['privacyPolicy'];
    refundPolicy = json['refundPolicy'];
    primaryColor = json['primaryColor'];
    secondryColor = json['secondryColor'];
    baseUrl = json['baseUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandName'] = this.brandName;
    data['googleMapApiKey'] = this.googleMapApiKey;
    data['razorpayKeyId'] = this.razorpayKeyId;
    data['razorpayKeySecret'] = this.razorpayKeySecret;
    data['agreement'] = this.agreement;
    data['termAndConditions'] = this.termAndConditions;
    data['privacyPolicy'] = this.privacyPolicy;
    data['refundPolicy'] = this.refundPolicy;
    data['primaryColor'] = this.primaryColor;
    data['secondryColor'] = this.secondryColor;
    data['baseUrl'] = this.baseUrl;
    return data;
  }
}
