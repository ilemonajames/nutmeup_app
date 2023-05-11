class repairModel {
  String? repairId;
  String? clientId;
  String? mechanicId;
  var createdAt;
  var updatedAt;
  String? invoiceId;
  var location;
  String? status;
  String? repairClass;
  String? repairDesc;

  repairModel(
      {this.repairId,
      this.clientId,
      this.mechanicId,
      this.createdAt,
      this.updatedAt,
      this.invoiceId,
      this.location,
      this.status,
      this.repairClass,
      this.repairDesc});

  repairModel.fromJson(Map<String, dynamic> json) {
    repairId = json['repairId'];
    clientId = json['clientId'];
    mechanicId = json['mechanicId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    invoiceId = json['invoiceId'];
    location = json['location'];
    status = json['status'];
    repairClass = json['repairClass'];
    repairDesc = json['repairDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['repairId'] = this.repairId;
    data['clientId'] = this.clientId;
    data['mechanicId'] = this.mechanicId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['invoiceId'] = this.invoiceId;
    data['location'] = this.location;
    data['status'] = this.status;
    data['repairClass'] = this.repairClass;
    data['repairDesc'] = this.repairDesc;
    return data;
  }
}
