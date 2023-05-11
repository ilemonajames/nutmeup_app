import 'package:flutter/foundation.dart';
import 'package:nutmeup/models/Mechanic/MechanicModel.dart';
import 'package:nutmeup/models/Store/StoreModel.dart';

class MechanicProvider extends ChangeNotifier {
  MechanicModel? mechanicModel;

  void updateMechanicrProvider(MechanicModel mechanicModel) {
    this.mechanicModel = mechanicModel;
    notifyListeners();
  }
}
