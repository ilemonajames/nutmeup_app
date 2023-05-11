import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

late SharedPreferences prefs;
final oc = NumberFormat("#,##0.00", "en_US");

class emailValidation {
  bool isEmailValid({required String email}) {
    bool isValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return isValid;
  }
}

String formatAmount(number) {
  var formatter = NumberFormat("#,##0", "en_US");
  return '₦ ${formatter.format(number)}';
}

String formatPhoneNumber({required String phone}) {
  String number = "";
  for (int a = 0; a < phone.length; a++) {
    number = number + phone.split("")[a] + '${(a == 3 || a == 6) ? ' ' : ''}';
  }
  return number;
}

String hashPassword({required String password}) {
  var hashed = md5.convert(utf8.encode(password));
  return hashed.toString();
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

Alart({
  required String message,
  required bool isError,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: (isError) ? colorRed : colorBlue,
      textColor: Colors.white,
      fontSize: 13.0);
}

// ignore: non_constant_identifier_names
BottomSheetOptionSelector(BuildContext context,
    {required String title, required List<String> options}) {
  SingleOption({required int index, required String text}) {
    return GestureDetector(
      onTap: (() {
        Navigator.pop(context, index);
      }),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: colorLightGray,
        ),
        child: Text(
          text,
          style: TextStyle(
              color: colorBlue, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 55, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorWhite,
          ),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(children: const [
                    Icon(Icons.arrow_back_ios),
                    Text(
                      "Back",
                      style: TextStyle(fontSize: 13),
                    )
                  ]),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 5, right: 5, top: 20),
              decoration: BoxDecoration(
                  color: colorLightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                title,
                style: TextStyle(
                    color: colorBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: List<Widget>.generate(options.length, (index) {
                return SingleOption(index: index, text: options[index]);
              }).toList(),
            )
          ]),
        );
      });
    },
  );
}
