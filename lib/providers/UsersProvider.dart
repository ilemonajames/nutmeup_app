
import 'package:flutter/foundation.dart';
import 'package:nutmeup/models/Authentication/UserModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userModel;


  void updateUserProvider(UserModel userModel) {
    this.userModel = userModel;
    notifyListeners();
  }
}
