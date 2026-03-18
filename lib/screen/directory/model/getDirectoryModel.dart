class GetDirectoryModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetDirectoryModel({this.status, this.message, this.data});

  GetDirectoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  String? profileImage;
  String? mobile;
  String? email;

  Data({this.name, this.profileImage, this.mobile, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}
