class VehicleBrandModel {
  String? brand;
  List<String>? models;

  VehicleBrandModel({this.brand, this.models});

  VehicleBrandModel.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    models = json['models'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['models'] = this.models;
    return data;
  }
}
