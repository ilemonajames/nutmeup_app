import 'package:flutter/material.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import 'PendingDocuments.dart';
import 'VerificationSampleScanPage.dart';

class VerifyHome extends StatefulWidget {
  const VerifyHome({Key? key}) : super(key: key);

  @override
  State<VerifyHome> createState() => _VerifyHomeState();
}

class _VerifyHomeState extends State<VerifyHome> {
  bool isComleted = false;
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
    return !isComleted
        ? Scaffold(
            appBar: AppBars(context).BackAppBar(color: colorWhite),
            body: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Identity Verification",
                    style: TextStyle(
                        color: colorBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You’re almost set up, now let’s get you verified! NutMeUp would like to confirm your identity. Before you proceed:",
                    style: TextStyle(
                        color: colorGray,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  SingleBulletPoint(
                      text:
                          "Ensure you have a national identification\nnumber (NIN)"),
                  SingleBulletPoint(
                      text:
                          " Be prepared to take a selfie and photos of\nyour valid government identity document"),
                  SingleBulletPoint(
                      text:
                          "Make sure your device camera is working\nan can take clear, readable photos"),
                  const SizedBox(
                    height: 100,
                  ),
                  SingleQuestion(text: "What identity document can I use?"),
                  SingleQuestion(
                      text: "Why do I need to provide my identity\ndocument?"),
                  const SizedBox(
                    height: 70,
                  ),
                  CustomButton(
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const VerificationPages()));
                      },
                      text: "Start Verification")
                ],
              ),
            )),
          )
        : const IdentityDocuments();
  }
}
