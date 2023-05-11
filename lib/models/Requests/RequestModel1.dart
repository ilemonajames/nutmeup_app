import '../Mechanic/MechanicModel.dart';
import '../Store/OrdersModel.dart';
import '../Vehicle/VehicleModel.dart';

class RequestItem {
  String? deliveryId;
  String? clientId;
  String? workerId;

  Location? location;
  VehicleModel? car;
  String? carFault;
  MechanicModel? mechanic;
  Payment? payment;
  String? status;
  String? intent;
  List<String>? updates;
  String? requestType;
  Delivery? delivery;

  RequestItem(
      {this.deliveryId,
      this.location,
      this.car,
      this.carFault,
      this.mechanic,
      this.payment,
      this.intent,
      this.status,
      this.updates,
      this.workerId,
      this.requestType,
      this.delivery});

  RequestItem.fromJson(Map<String, dynamic> json) {
    deliveryId = json['deliveryId'];
    intent = json['intent'];
    workerId = json['workerId'];
    clientId = json['clientId'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    car = json['vehicle'] != null
        ? new VehicleModel.fromJson(json['vehicle'])
        : null;
    carFault = json['carFault'];
    mechanic = json['mechanic'] != null
        ? MechanicModel.fromJson(json['mechanic'])
        : null;
    payment =
        json['payment'] != null ? new Payment.fromJson(json['payment']) : null;
    status = json['status'];
    updates = json['updates'].cast<String>();
    requestType = json['requestType'];
    delivery = json['delivery'] != null
        ? new Delivery.fromJson(json['delivery'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deliveryId'] = this.deliveryId;
    data['intent'] = this.intent;
    data['clientId'] = this.clientId;
    data['workerId'] = this.workerId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    data['carFault'] = this.carFault;
    if (this.mechanic != null) {
      data['mechanic'] = this.mechanic!.toJson();
    }
    if (this.payment != null) {
      data['payment'] = this.payment!.toJson();
    }
    data['status'] = this.status;
    data['updates'] = this.updates;
    data['requestType'] = this.requestType;
    if (this.delivery != null) {
      data['delivery'] = this.delivery!.toJson();
    }
    return data;
  }
}

class Delivery {
  String? lastLocation;
  String? destinationLocation;
  int? timeInTransit;
  String? status;

  Delivery(
      {this.lastLocation,
      this.destinationLocation,
      this.timeInTransit,
      this.status});

  Delivery.fromJson(Map<String, dynamic> json) {
    lastLocation = json['lastLocation'];
    destinationLocation = json['destinationLocation'];
    timeInTransit = json['timeInTransit'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastLocation'] = this.lastLocation;
    data['destinationLocation'] = this.destinationLocation;
    data['timeInTransit'] = this.timeInTransit;
    data['status'] = this.status;
    return data;
  }
}
