class GetProfileAssociationModel {
  bool? success;
  String? message;
  Data? data;

  GetProfileAssociationModel({
    this.success,
    this.message,
    this.data,
  });

  GetProfileAssociationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = json['data'] != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson(); // safe because of the if check
    }
    return map;
  }
}

class Data {
  String? id;                           // renamed from sId – more conventional
  String? associationName;
  String? governmentRegistrationNumber;
  String? yearOfFormation;
  String? profileImage;
  String? fullAddress;
  String? city;
  String? state;
  String? pinCode;
  String? presidentOrSecretary;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? registrationCertificateType;
  List<String>? registrationDocument;
  String? verifiedBy;
  String? verifiedAt;                   // consider DateTime? if you parse it later
  String? verificationStatus;
  bool? isActive;
  String? createdAt;                    // consider DateTime?
  int? v;                               // renamed from iV
  int? profileCompletionPercentage;

  Data({
    this.id,
    this.associationName,
    this.governmentRegistrationNumber,
    this.yearOfFormation,
    this.profileImage,
    this.fullAddress,
    this.city,
    this.state,
    this.pinCode,
    this.presidentOrSecretary,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.registrationCertificateType,
    this.registrationDocument,
    this.verifiedBy,
    this.verifiedAt,
    this.verificationStatus,
    this.isActive,
    this.createdAt,
    this.v,
    this.profileCompletionPercentage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String?;
    associationName = json['associationName'] as String?;
    governmentRegistrationNumber = json['governmentRegistrationNumber']?.toString();
    yearOfFormation = json['yearOfFormation']?.toString();
    profileImage = json['profileImage'] as String?;
    fullAddress = json['fullAddress'] as String?;
    city = json['city'] as String?;
    state = json['state'] as String?;
    pinCode = json['pinCode']?.toString();
    presidentOrSecretary = json['presidentOrSecretary'] as String?;
    countryCode = json['countryCode'] as String?;
    phoneNumber = json['phoneNumber']?.toString();
    email = json['email'] as String?;
    registrationCertificateType = json['registrationCertificateType'] as String?;

    // Safest list parsing
    registrationDocument = [];
    if (json['registrationDocument'] is List) {
      registrationDocument = List<String>.from(
        (json['registrationDocument'] as List).map((e) => e?.toString() ?? ''),
      );
    }

    verifiedBy = json['verifiedBy'] as String?;
    verifiedAt = json['verifiedAt'] as String?;
    verificationStatus = json['verificationStatus'] as String?;
    isActive = json['isActive'] as bool?;
    createdAt = json['createdAt'] as String?;
    v = json['__v'] as int?;
    profileCompletionPercentage = json['profileCompletionPercentage'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['_id'] = id;
    map['associationName'] = associationName;
    map['governmentRegistrationNumber'] = governmentRegistrationNumber;
    map['yearOfFormation'] = yearOfFormation;
    map['profileImage'] = profileImage;
    map['fullAddress'] = fullAddress;
    map['city'] = city;
    map['state'] = state;
    map['pinCode'] = pinCode;
    map['presidentOrSecretary'] = presidentOrSecretary;
    map['countryCode'] = countryCode;
    map['phoneNumber'] = phoneNumber;
    map['email'] = email;
    map['registrationCertificateType'] = registrationCertificateType;
    map['registrationDocument'] = registrationDocument;
    map['verifiedBy'] = verifiedBy;
    map['verifiedAt'] = verifiedAt;
    map['verificationStatus'] = verificationStatus;
    map['isActive'] = isActive;
    map['createdAt'] = createdAt;
    map['__v'] = v;
    map['profileCompletionPercentage'] = profileCompletionPercentage;
    return map;
  }
}