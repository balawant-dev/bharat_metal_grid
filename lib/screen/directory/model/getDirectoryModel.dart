class GetDirectoryDetailModel {
  bool? success;
  int? totalResult;
  Data? data;

  GetDirectoryDetailModel({this.success, this.totalResult, this.data});

  GetDirectoryDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResult = json['totalResult'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['totalResult'] = this.totalResult;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? associationName;
  String? city;
  String? state;
  String? presidentOrSecretary;
  String? phoneNumber;
  String? email;
  String? profileImage;
  bool? hasMembership;
  String? membershipExpiryDateIST;
  String? id;
  List<Leadership>? leadership;

  Data(
      {this.sId,
        this.associationName,
        this.city,
        this.state,
        this.presidentOrSecretary,
        this.phoneNumber,
        this.email,
        this.profileImage,
        this.hasMembership,
        this.membershipExpiryDateIST,
        this.id,
        this.leadership});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    associationName = json['associationName'];
    city = json['city'];
    state = json['state'];
    presidentOrSecretary = json['presidentOrSecretary'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    profileImage = json['profileImage'];
    hasMembership = json['hasMembership'];
    membershipExpiryDateIST = json['membershipExpiryDateIST'];
    id = json['id'];
    if (json['leadership'] != null) {
      leadership = <Leadership>[];
      json['leadership'].forEach((v) {
        leadership!.add(new Leadership.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['associationName'] = this.associationName;
    data['city'] = this.city;
    data['state'] = this.state;
    data['presidentOrSecretary'] = this.presidentOrSecretary;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    data['hasMembership'] = this.hasMembership;
    data['membershipExpiryDateIST'] = this.membershipExpiryDateIST;
    data['id'] = this.id;
    if (this.leadership != null) {
      data['leadership'] = this.leadership!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leadership {
  String? sId;
  String? association;
  String? profileImg;
  String? name;
  String? designation;
  String? member;
  String? createdAt;
  int? iV;

  Leadership(
      {this.sId,
        this.association,
        this.profileImg,
        this.name,
        this.designation,
        this.member,
        this.createdAt,
        this.iV});

  Leadership.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    association = json['association'];
    profileImg = json['profileImg'];
    name = json['name'];
    designation = json['designation'];
    member = json['member'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['association'] = this.association;
    data['profileImg'] = this.profileImg;
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['member'] = this.member;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
