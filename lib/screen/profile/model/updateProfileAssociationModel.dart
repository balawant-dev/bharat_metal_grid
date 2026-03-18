class AssociationUpdateModel {
  bool? success;
  String? message;
  String? token;
  String? userType;

  AssociationUpdateModel(
      {this.success, this.message, this.token, this.userType});

  AssociationUpdateModel.fromJson(Map<String, dynamic> json) {
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
