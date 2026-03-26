class MembershipAssignmentModel {
  var success;
  List<Data>? data;

  MembershipAssignmentModel({this.success, this.data});

  MembershipAssignmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  var sId;
  AssignedBy? assignedBy;
  var association;
  MembershipPlan? membershipPlan;
  var paymentStatus;
  var assigned;
  var createdAt;
  var iV;

  Data(
      {this.sId,
        this.assignedBy,
        this.association,
        this.membershipPlan,
        this.paymentStatus,
        this.assigned,
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
    assigned = json['assigned'];
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
    data['assigned'] = this.assigned;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class AssignedBy {
  var sId;
  var email;

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
  var sId;
  var type;
  var amount;
  var expiryInDays;
  var description;
  var createdAt;
  var iV;

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
