class ServiceModel {
  String? serviceId;
  String? title;
  bool? isNegotiable;
  int? amount;

  ServiceModel({
    this.serviceId,
    this.title,
    this.isNegotiable,
    this.amount,
  });

  ServiceModel.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    title = json['title'];
    isNegotiable = json['isNegotiable'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['title'] = this.title;
    data['isNegotiable'] = this.isNegotiable;
    data['amount'] = this.amount;
    return data;
  }
}
