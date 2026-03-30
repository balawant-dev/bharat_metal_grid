class ComplaintResponseModel {
  final bool success;
  final String message;
  final ComplaintData data;

  ComplaintResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ComplaintResponseModel.fromJson(Map<String, dynamic> json) {
    return ComplaintResponseModel(
      success: json['success'],
      message: json['message'],
      data: ComplaintData.fromJson(json['data']),
    );
  }
}

class ComplaintData {
  final String complaintId;
  final String email;
  final String mobileNumber;
  final String remark;
  final String status;

  ComplaintData({
    required this.complaintId,
    required this.email,
    required this.mobileNumber,
    required this.remark,
    required this.status,
  });

  factory ComplaintData.fromJson(Map<String, dynamic> json) {
    return ComplaintData(
      complaintId: json['complaintId'] ?? "",
      email: json['email'] ?? "",
      mobileNumber: json['mobileNumber'] ?? "",
      remark: json['remark'] ?? "",
      status: json['status'] ?? "",
    );
  }
}