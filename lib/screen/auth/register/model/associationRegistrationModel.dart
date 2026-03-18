class AssociationRegistrationModel {
  bool? success;
  String? message;
  String? token;
  String? userType;

  AssociationRegistrationModel(
      {this.success, this.message, this.token, this.userType});

  AssociationRegistrationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    data['userType'] = this.userType;
    return data;
  }
}
