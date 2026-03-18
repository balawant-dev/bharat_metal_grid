class OrganizationDetailsModel {
  final bool status;
  final String message;
  final MemberData? data;

  OrganizationDetailsModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory OrganizationDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrganizationDetailsModel(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? MemberData.fromJson(json['data'])
          : null,
    );
  }
}
class MemberData {
  final String memberId;
  final String name;
  final String mobile;
  final String email;
  final String role;
  final bool isActive;
  final String createdAt;

  MemberData({
    required this.memberId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.role,
    required this.isActive,
    required this.createdAt,
  });

  factory MemberData.fromJson(Map<String, dynamic> json) {
    return MemberData(
      memberId: json['memberId'] ?? '',
      name: json['name'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] ?? '',
    );
  }
}
