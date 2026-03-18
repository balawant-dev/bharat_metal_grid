class SettingResponseModel {
  bool? status;
  String? message;
  Data? data;

  SettingResponseModel({this.status, this.message, this.data});

  SettingResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? brandName;
  String? logo;
  String? email;
  String? mobile;
  String? address;
  String? gst;
  String? googleMapApiKey;
  String? razorpayKeyId;
  String? razorpayKeySecret;
  String? agreement;
  String? termAndConditions;
  String? privacyPolicy;
  String? refundPolicy;
  int? iV;
  String? appColourCode;
  String? extraChargePerPerson;
  List<AppPaymentMethods>? appPaymentMethods;
  String? liveBaseUrl;
  int? agentComission;

  Data(
      {this.sId,
        this.brandName,
        this.logo,
        this.email,
        this.mobile,
        this.address,
        this.gst,
        this.googleMapApiKey,
        this.razorpayKeyId,
        this.razorpayKeySecret,
        this.agreement,
        this.termAndConditions,
        this.privacyPolicy,
        this.refundPolicy,
        this.iV,
        this.appColourCode,
        this.extraChargePerPerson,
        this.appPaymentMethods,
        this.liveBaseUrl,
        this.agentComission});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brandName = json['brandName'];
    logo = json['logo'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    gst = json['gst'];
    googleMapApiKey = json['googleMapApiKey'];
    razorpayKeyId = json['razorpayKeyId'];
    razorpayKeySecret = json['razorpayKeySecret'];
    agreement = json['agreement'];
    termAndConditions = json['termAndConditions'];
    privacyPolicy = json['privacyPolicy'];
    refundPolicy = json['refundPolicy'];
    iV = json['__v'];
    appColourCode = json['appColourCode'];
    extraChargePerPerson = json['extraChargePerPerson'];
    if (json['appPaymentMethods'] != null) {
      appPaymentMethods = <AppPaymentMethods>[];
      json['appPaymentMethods'].forEach((v) {
        appPaymentMethods!.add(new AppPaymentMethods.fromJson(v));
      });
    }
    liveBaseUrl = json['liveBaseUrl'];
    agentComission = json['agentComission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['brandName'] = this.brandName;
    data['logo'] = this.logo;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['gst'] = this.gst;
    data['googleMapApiKey'] = this.googleMapApiKey;
    data['razorpayKeyId'] = this.razorpayKeyId;
    data['razorpayKeySecret'] = this.razorpayKeySecret;
    data['agreement'] = this.agreement;
    data['termAndConditions'] = this.termAndConditions;
    data['privacyPolicy'] = this.privacyPolicy;
    data['refundPolicy'] = this.refundPolicy;
    data['__v'] = this.iV;
    data['appColourCode'] = this.appColourCode;
    data['extraChargePerPerson'] = this.extraChargePerPerson;
    if (this.appPaymentMethods != null) {
      data['appPaymentMethods'] =
          this.appPaymentMethods!.map((v) => v.toJson()).toList();
    }
    data['liveBaseUrl'] = this.liveBaseUrl;
    data['agentComission'] = this.agentComission;
    return data;
  }
}

class AppPaymentMethods {
  String? name;
  String? status;
  String? sId;

  AppPaymentMethods({this.name, this.status, this.sId});

  AppPaymentMethods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}
