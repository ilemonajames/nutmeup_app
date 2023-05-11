import 'dart:convert';

import '../models/Payment/ReferenceModel.dart';
import 'package:http/http.dart' as http;

class PaymentApi {
  String baseUrl = "https://api.paystack.co";
  Future<Map> verifyTransaction(String ref) async {
    try {
      // RemoteConfig remoteConfig = RemoteConfig.instance;
      // await remoteConfig.fetchAndActivate();
      // String secretKey =
      //     remoteConfig.getValue("paystack_test_secret_key").asString();

      String secretKey = "sk_test_a73f6c885f6684ce06141e142aafbf5910f2793f";

      var res = await http.get(Uri.parse('${baseUrl}/transaction/verify/$ref'),
          headers: {'Authorization': 'Bearer $secretKey'});

      if (res.statusCode == 200) {
        return json.decode(res.body);
      } else {
        return {"status": false};
      }
    } catch (ex) {
      return {"status": false};
    }
  }

  Future<References> fetchAccessCodeFrmServer(
      String email, String amount) async {
    try {
      // RemoteConfig remoteConfig = RemoteConfig.instance;
      // await remoteConfig.fetchAndActivate();
      // String secretKey =
      //     remoteConfig.getValue("paystack_test_secret_key").asString();

      String secretKey = "sk_test_a73f6c885f6684ce06141e142aafbf5910f2793f";

      var res = await http.post(
        Uri.parse('https://api.paystack.co/transaction/initialize'),
        headers: {
          "Authorization": "Bearer $secretKey",
        },
        body: {"email": email, "amount": amount},
      );
      Map map = json.decode(res.body)["data"];
      return References.fromJson(map);
    } catch (ex) {
      return References(authorization_url: "", access_code: "", reference: "");
    }
  }
}
