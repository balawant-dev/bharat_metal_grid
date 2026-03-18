class MembershipAssignmentModel {
  bool? success;
  Data? data;

  MembershipAssignmentModel({this.success, this.data});

  MembershipAssignmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  AssignedBy? assignedBy;
  String? association;
  MembershipPlan? membershipPlan;
  String? paymentStatus;
  String? createdAt;
  int? iV;

  Data(
      {this.sId,
        this.assignedBy,
        this.association,
        this.membershipPlan,
        this.paymentStatus,
        this.createdAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    assignedBy = json['assignedBy'] != null
        ? new AssignedBy.fromJson(json['assignedBy'])
        : null;
    association = json['association'];
    membershipPlan = json['membershipPlan'] != null
        ? new MembershipPlan.fromJson(json['membershipPlan'])
        : null;
    paymentStatus = json['paymentStatus'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.assignedBy != null) {
      data['assignedBy'] = this.assignedBy!.toJson();
    }
    data['association'] = this.association;
    if (this.membershipPlan != null) {
      data['membershipPlan'] = this.membershipPlan!.toJson();
    }
    data['paymentStatus'] = this.paymentStatus;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class AssignedBy {
  String? sId;
  String? email;

  AssignedBy({this.sId, this.email});

  AssignedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    return data;
  }
}

class MembershipPlan {
  String? sId;
  String? type;
  String? amount;
  int? expiryInDays;
  String? description;
  String? createdAt;
  int? iV;

  MembershipPlan(
      {this.sId,
        this.type,
        this.amount,
        this.expiryInDays,
        this.description,
        this.createdAt,
        this.iV});

  MembershipPlan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    amount = json['amount'];
    expiryInDays = json['expiryInDays'];
    description = json['description'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['expiryInDays'] = this.expiryInDays;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
