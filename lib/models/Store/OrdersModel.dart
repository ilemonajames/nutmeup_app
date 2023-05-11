class OrderModel {
  var createAt;
  String? orderType;
  String? customerId;
  String? itemId;

  String? storeId;
  Payment? payment;
  double? amount;
  double? discount;
  double? charge;
  var updatedAt;
  String? status;

  OrderModel(
      {this.createAt,
      this.orderType,
      this.customerId,
      this.storeId,
      this.itemId,
      this.payment,
      this.amount,
      this.discount,
      this.charge,
      this.updatedAt,
      this.status});

  OrderModel.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    orderType = json['orderType'];
    customerId = json['customerId'];
    itemId = json['itemId'];
    storeId = json['storeId'];
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    amount = json['amount'];
    discount = json['discount'];
    charge = json['charge'];
    updatedAt = json['updatedAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createAt'] = this.createAt;
    data['orderType'] = this.orderType;
    data['customerId'] = this.customerId;
    data['itemId'] = this.itemId;
    data['storeId'] = this.storeId;
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['charge'] = this.charge;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}

class Payment {
  String? paymentId;
  String? paymentType;
  String? paymentStatus;

  Payment({this.paymentId, this.paymentType, this.paymentStatus});

  Payment.fromJson(Map<String, dynamic> json) {
    paymentId = json['paymentId'];
    paymentType = json['paymentType'];
    paymentStatus = json['PaymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentId'] = this.paymentId;
    data['paymentType'] = this.paymentType;
    data['PaymentStatus'] = this.paymentStatus;
    return data;
  }
}
