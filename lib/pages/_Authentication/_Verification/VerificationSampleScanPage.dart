import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '../../../containers/CameraContainer.dart';
import 'PendingDocuments.dart';

class VerificationPages extends StatefulWidget {
  const VerificationPages({Key? key}) : super(key: key);

  @override
  State<VerificationPages> createState() => _VerificationPagesState();
}

class _VerificationPagesState extends State<VerificationPages> {
  bool isCompleted = true;
  Widget SingleBulletPoint({required String text}) {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.circle,
                size: 10,
                color: colorBlue,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            )
          ]),
    );
  }

  Widget SingleQuestion({required String text}) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Icon(
                Icons.question_mark,
                size: 20,
                color: colorLightBlue,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlue,
      appBar: AppBars(context).BackAppBar(color: colorBlue),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: ClipRRect(
                  child: Image.asset("assets/images/icons/card_template.png")),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "TAKE A PICTURE OF THE FRONT OF\nYOUR IDENTITY DOCUMENT",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: colorWhite, fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 100,
            ),
            const SizedBox(
              height: 70,
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CameraContainer()));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Tap to continue",
                    style: TextStyle(color: colorWhite, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/icons/img_1.png",
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(color: colorWhite, fontSize: 13),
                            )
                          ],
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(color: colorBlue, width: 4)),
                          ),
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "assets/images/icons/img_2.png",
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Webcam",
                              style: TextStyle(color: colorWhite, fontSize: 13),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}

class CamCameraContainerer {}
