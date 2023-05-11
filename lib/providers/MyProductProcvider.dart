import 'package:flutter/foundation.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';
import 'package:nutmeup/models/Store/StoreModel.dart';

class MyProductsProvider extends ChangeNotifier {
  List<ProductModel>? myProducts;

  void updateMyProductsProvider(List<ProductModel> myProducts) {
    this.myProducts = myProducts;
    notifyListeners();
  }
}
