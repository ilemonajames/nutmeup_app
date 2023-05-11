import 'StoreModel.dart';

class ProductModel {
  String? name;
  String? storeId;
  String? reviews;

  String? userId;
  List<Gallery>? gallery;
  Price? price;
  int? condition;
  Location? location;
  String? description;
  String? status;
  String? category;
  List<String>? sold;

  int? sRatting;
  Promotion? promotion;

  ProductModel(
      {this.name,
      this.storeId,
      this.userId,
      this.gallery,
      this.price,
      this.reviews,
      this.condition,
      this.description,
      this.location,
      this.status,
      this.category,
      this.sold,
      this.sRatting,
      this.promotion});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    storeId = json['storeId'];
    userId = json['userId'];
    reviews = json['reviews'];

    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    condition = json['condition'];
    description = json['description'];
    status = json['status'];
    category = json['category'];
    sold = json['sold'].cast<String>();
    sRatting = json['sRatting'];
    promotion = json['promotion'] != null
        ? new Promotion.fromJson(json['promotion'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['storeId'] = this.storeId;
    data['reviews'] = this.reviews;

    data['userId'] = this.userId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['condition'] = this.condition;
    data['description'] = this.description;
    data['status'] = this.status;
    data['category'] = this.category;
    data['sold'] = this.sold;
    data['sRatting'] = this.sRatting;
    if (this.promotion != null) {
      data['promotion'] = this.promotion!.toJson();
    }
    return data;
  }
}

class Gallery {
  String? link;
  String? size;
  String? thumb;
  String? type;
  bool? primary;

  Gallery({this.link, this.size, this.thumb, this.type, this.primary});

  Gallery.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    size = json['size'];
    thumb = json['thumb'];
    type = json['type'];
    primary = json['primary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['size'] = this.size;
    data['thumb'] = this.thumb;
    data['type'] = this.type;
    data['primary'] = this.primary;
    return data;
  }
}

class Price {
  var amount;
  int? discountAmount;

  Price({this.amount, this.discountAmount});

  Price.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    discountAmount = json['discountAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['discountAmount'] = this.discountAmount;
    return data;
  }
}

class Promotion {
  String? promotionId;
  String? subscriptionId;
  String? status;

  Promotion({this.promotionId, this.subscriptionId, this.status});

  Promotion.fromJson(Map<String, dynamic> json) {
    promotionId = json['promotionId'];
    subscriptionId = json['subscriptionId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['promotionId'] = this.promotionId;
    data['subscriptionId'] = this.subscriptionId;
    data['status'] = this.status;
    return data;
  }
}
