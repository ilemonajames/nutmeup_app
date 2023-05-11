import 'package:flutter/foundation.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:nutmeup/models/Mechanic/MechanicModel.dart';
import 'package:nutmeup/models/Store/StoreModel.dart';

class MyLocationProvider extends ChangeNotifier {
  GeoFirePoint? geoFirePoint;

  void updateMyLocation(GeoFirePoint geoFirePoint) {
    this.geoFirePoint = geoFirePoint;
    notifyListeners();
  }
}
