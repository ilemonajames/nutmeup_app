import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '../../../widgets/Buttons/Button.dart';

class IdentityDocuments extends StatelessWidget {
  const IdentityDocuments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(toolbarHeight: 0 , backgroundColor: colorWhite, elevation: 0,),
      backgroundColor: colorOffWhite,
      appBar: AppBars(context).BackAppBar(color: colorWhite),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              "Identity Documents\nSucessfully Submitted ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: colorBlue, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (builder) => const HomePage()));
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
            Expanded(child: Container()),
            CustomButton(
              onClick: () {
                Navigator.pop(context);
              },
              text: "Finish",
              margin: const EdgeInsets.only(left: 20, right: 20),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        )),
      ),
    );
  }
}
