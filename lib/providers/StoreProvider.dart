import 'package:flutter/foundation.dart';
import 'package:nutmeup/models/Store/StoreModel.dart';

class StoreProvider extends ChangeNotifier {
  StoreModel? storeModel;

  void updateStoreProvider(StoreModel storeModel) {
    this.storeModel = storeModel;
    notifyListeners();
  }
}
