import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutmeup/models/Mechanic/ServiceModel.dart';

class MechanicModel {
  String? name;
  String? phone;
  String? iamge;
  String? coverImage;

  Location? location;
  String? bioData;
  String? address;

  var sRating;
  int? sProducts;
  String? storeId;
  var createdAt;
  String? createdBy;
  bool? physicalStore;
  int? storeType;
  List<String>? specailization;
  List<ServiceModel>? services;

  MechanicModel(
      {this.name,
      this.phone,
      this.address,
      this.iamge,
      this.location,
      this.bioData,
      this.sRating,
      this.sProducts,
      this.storeId,
      this.createdAt,
      this.createdBy,
      this.coverImage,
      this.physicalStore,
      this.storeType,
      this.specailization,
      this.services});

  MechanicModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    iamge = json['iamge'];
    address = json['address'];
    coverImage = json['coverImage'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    bioData = json['bioData'];
    sRating = json['_rating'];
    sProducts = json['_products'];
    storeId = json['storeId'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    physicalStore = json['physicalStore'];
    storeType = json['storeType'];
    specailization = json['specailization'].cast<String>();
    if (json['services'] != null) {
      services = <ServiceModel>[];
      json['services'].forEach((v) {
        services!.add(new ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['iamge'] = this.iamge;
    data['address'] = this.address;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['coverImage'] = this.coverImage;
    data['bioData'] = this.bioData;
    data['_rating'] = this.sRating;
    data['_products'] = this.sProducts;
    data['storeId'] = this.storeId;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['physicalStore'] = this.physicalStore;
    data['storeType'] = this.storeType;
    data['specailization'] = this.specailization;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  GeoPoint? geopoint;
  String? geohash;
  String? name;

  Location({this.geopoint, this.geohash, this.name});

  Location.fromJson(Map<String, dynamic> json) {
    geopoint = json['geopoint'];
    geohash = json['geohash'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geopoint'] = this.geopoint;
    data['geohash'] = this.geohash;
    data['name'] = this.name;
    return data;
  }
}
