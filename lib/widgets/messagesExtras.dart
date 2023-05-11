import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

ButtonMessage({required String message, onClick}) {
  return GestureDetector(
    onTap: onClick ??
        () {
          print("nothing");
        },
    onTapDown: (details) {},
    onTapUp: ((details) {}),
    child: Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorWhite,
          border: Border.all(color: colorLightBlue, width: 1)),
      child: Text(
        '    $message    ',
        style: TextStyle(color: colorLightBlue),
      ),
    ),
  );
}

EmptyMessage({required String title, required message, onClick}) {
  return Container(
    margin: EdgeInsets.all(20),
    height: 200,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: colorBlue),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          ButtonMessage(message: message, onClick: onClick),
        ]),
  );
}
