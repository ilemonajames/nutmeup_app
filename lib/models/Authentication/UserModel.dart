import 'package:nutmeup/models/Mechanic/MechanicModel.dart';

class UserModel {
  String? password;
  var createdAt;
  var updatedAt;
  String? status;
  String? userId;
  List<DeviceToken>? deviceToken;
  BioData? bioData;
  Location? location;
  KycData? kycData;

  UserModel(
      {this.password,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.userId,
      this.deviceToken,
      this.bioData,
      this.location,
      this.kycData});

  UserModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    status = json['status'];
    userId = json['userId'];
    if (json['deviceToken'] != null) {
      deviceToken = <DeviceToken>[];
      json['deviceToken'].forEach((v) {
        deviceToken!.add(DeviceToken.fromJson(v));
      });
    }
    bioData =
        json['bioData'] != null ? BioData.fromJson(json['bioData']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    kycData =
        json['kycData'] != null ? KycData.fromJson(json['kycData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    data['userId'] = this.userId;
    if (this.deviceToken != null) {
      data['deviceToken'] = this.deviceToken!.map((v) => v.toJson()).toList();
    }
    if (this.bioData != null) {
      data['bioData'] = this.bioData!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.kycData != null) {
      data['kycData'] = this.kycData!.toJson();
    }
    return data;
  }
}

class DeviceToken {
  String? device;
  String? token;

  DeviceToken({this.device, this.token});

  DeviceToken.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device'] = this.device;
    data['token'] = this.token;
    return data;
  }
}

class BioData {
  String? name;
  String? email;
  String? profilePhoto;
  String? dateOfBirth;
  String? phone;

  BioData(
      {this.name, this.email, this.phone, this.profilePhoto, this.dateOfBirth});

  BioData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];

    profilePhoto = json['profilePhoto'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;

    data['profilePhoto'] = this.profilePhoto;
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}

class KycData {
  bool? emailStatus;
  String? phoneStatus;
  String? documentStatus;
  String? documentLink;
  String? uploadedAt;
  String? verifiedAt;
  String? documentType;
  String? message;

  KycData(
      {this.emailStatus,
      this.phoneStatus,
      this.documentStatus,
      this.documentLink,
      this.uploadedAt,
      this.verifiedAt,
      this.documentType,
      this.message});

  KycData.fromJson(Map<String, dynamic> json) {
    emailStatus = json['emailStatus'];
    phoneStatus = json['phoneStatus'];
    documentStatus = json['documentStatus'];
    documentLink = json['documentLink'];
    uploadedAt = json['uploadedAt'];
    verifiedAt = json['verifiedAt'];
    documentType = json['documentType'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emailStatus'] = this.emailStatus;
    data['phoneStatus'] = this.phoneStatus;
    data['documentStatus'] = this.documentStatus;
    data['documentLink'] = this.documentLink;
    data['uploadedAt'] = this.uploadedAt;
    data['verifiedAt'] = this.verifiedAt;
    data['documentType'] = this.documentType;
    data['message'] = this.message;
    return data;
  }
}
