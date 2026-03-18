class GetProfileMemberModel {
  bool? success;
  String? message;
  Data? data;

  GetProfileMemberModel({this.success, this.message, this.data});

  GetProfileMemberModel.fromJson(Map<String, dynamic> json) {
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
  Organization? organization;
  String? sId;
  String? fullName;
  String? gender;
  String? designation;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? state;
  String? preferredLanguage;
  String? profileImage;
  bool? isActive;
  String? createdAt;
  int? iV;

  Data(
      {this.organization,
        this.sId,
        this.fullName,
        this.gender,
        this.designation,
        this.countryCode,
        this.phoneNumber,
        this.email,
        this.state,
        this.preferredLanguage,
        this.profileImage,
        this.isActive,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    organization = json['organization'] != null
        ? new Organization.fromJson(json['organization'])
        : null;
    sId = json['_id'];
    fullName = json['fullName'];
    gender = json['gender'];
    designation = json['designation'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    state = json['state'];
    preferredLanguage = json['preferredLanguage'];
    profileImage = json['profileImage'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.organization != null) {
      data['organization'] = this.organization!.toJson();
    }
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['designation'] = this.designation;
    data['countryCode'] = this.countryCode;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['state'] = this.state;
    data['preferredLanguage'] = this.preferredLanguage;
    data['profileImage'] = this.profileImage;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Organization {
  String? type;
  String? name;
  String? parentOrganizationName;
  String? postalAddress;
  String? dateOfIncorporation;
  String? emailId;
  String? natureOfOrganization;
  String? panNumber;
  String? gstNumber;
  List<String>? selectedAssociations;

  Organization(
      {this.type,
        this.name,
        this.parentOrganizationName,
        this.postalAddress,
        this.dateOfIncorporation,
        this.emailId,
        this.natureOfOrganization,
        this.panNumber,
        this.gstNumber,
        this.selectedAssociations});

  Organization.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    parentOrganizationName = json['parentOrganizationName'];
    postalAddress = json['postalAddress'];
    dateOfIncorporation = json['dateOfIncorporation'];
    emailId = json['emailId'];
    natureOfOrganization = json['natureOfOrganization'];
    panNumber = json['panNumber'];
    gstNumber = json['gstNumber'];
    selectedAssociations = json['selectedAssociations'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['name'] = this.name;
    data['parentOrganizationName'] = this.parentOrganizationName;
    data['postalAddress'] = this.postalAddress;
    data['dateOfIncorporation'] = this.dateOfIncorporation;
    data['emailId'] = this.emailId;
    data['natureOfOrganization'] = this.natureOfOrganization;
    data['panNumber'] = this.panNumber;
    data['gstNumber'] = this.gstNumber;
    data['selectedAssociations'] = this.selectedAssociations;
    return data;
  }
}
