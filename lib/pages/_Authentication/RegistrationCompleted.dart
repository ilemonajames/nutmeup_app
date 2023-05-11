import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

import '../HomePage.dart';

class RegCompleted extends StatelessWidget {
  const RegCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(toolbarHeight: 0 , backgroundColor: colorWhite, elevation: 0,),
      backgroundColor: colorOffWhite,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const HomePage()));
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: colorLightBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(100))),
                child: Icon(
                  Icons.check,
                  size: 50,
                  color: colorWhite,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Registration Complete",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: colorBlack, fontSize: 20),
            )
          ],
        )),
      ),
    );
  }
}
