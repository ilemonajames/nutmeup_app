import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

class AppBars {
  BuildContext context;
  AppBars(this.context);

  AppBar BackAppBarWithTitle({color, required String title, whiteText}) {
    bool isTextWhite = whiteText ?? false;
    return AppBar(
        backgroundColor: color ?? colorLightBlue,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "back",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 20),
            child: Text(
              title,
              style: TextStyle(fontSize: 15, color: colorWhite),
            ),
          )
        ]);
  }

  AppBar BackAppBar({required color}) {
    return AppBar(
      backgroundColor: color,
      elevation: 0,
      centerTitle: false,
      title: Text(
        "Back",
        style: TextStyle(color: colorBlack, fontSize: 13),
      ),
      leading: GestureDetector(
        child: Container(
            child: Icon(
          Icons.arrow_back,
          color: colorBlack,
        )),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
