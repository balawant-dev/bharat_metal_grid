class GetAllAssociationModel {
  bool? success;
  int? totalResult;
  List<Data>? data;

  GetAllAssociationModel({this.success, this.totalResult, this.data});

  GetAllAssociationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalResult = json['totalResult'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? associationName;
  String? presidentOrSecretary;
  String? phoneNumber;
  String? email;
  String? profileImage;

  Data(
      {this.sId,
        this.associationName,
        this.presidentOrSecretary,
        this.phoneNumber,
        this.email,
        this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    associationName = json['associationName'];
    presidentOrSecretary = json['presidentOrSecretary'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['associationName'] = this.associationName;
    data['presidentOrSecretary'] = this.presidentOrSecretary;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
