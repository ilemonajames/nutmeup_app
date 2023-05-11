class VehicleModel {
  String? title;
  String? year;
  String? gear;
  String? manufacturer;
  String? config;
  String? createdBy;
  String? status;
  var createdAt;
  String? vehicleType;
  String? vehicleId;
  String? updatedAt;
  More? more;

  VehicleModel(
      {this.title,
      this.year,
      this.gear,
      this.manufacturer,
      this.config,
      this.createdBy,
      this.status,
      this.createdAt,
      this.vehicleType,
      this.vehicleId,
      this.updatedAt,
      this.more});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    gear = json['gear'];
    manufacturer = json['manufacturer'];
    config = json['config'];
    createdBy = json['createdBy'];
    status = json['status'];
    createdAt = json['createdAt'];
    vehicleType = json['vehicleType'];
    vehicleId = json['vehicleId'];
    updatedAt = json['updatedAt'];
    more = json['more'] != null ? new More.fromJson(json['more']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['year'] = this.year;
    data['gear'] = this.gear;
    data['manufacturer'] = this.manufacturer;
    data['config'] = this.config;
    data['createdBy'] = this.createdBy;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['vehicleType'] = this.vehicleType;
    data['vehicleId'] = this.vehicleId;
    data['updatedAt'] = this.updatedAt;
    if (this.more != null) {
      data['more'] = this.more!.toJson();
    }
    return data;
  }
}

class More {
  String? color;
  String? health;

  More({this.color, this.health});

  More.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    health = json['health'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['health'] = this.health;
    return data;
  }
}
