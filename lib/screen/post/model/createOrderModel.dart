class CreateOrderModel {
  bool? success;
  String? message;
  Data? data;

  CreateOrderModel({this.success, this.message, this.data});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
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
  String? orderId;
  int? amount;
  String? currency;
  String? paymentId;

  Data({this.orderId, this.amount, this.currency, this.paymentId});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    amount = json['amount'];
    currency = json['currency'];
    paymentId = json['paymentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['paymentId'] = this.paymentId;
    return data;
  }
}
