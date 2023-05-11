import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/models/Authentication/UserModel.dart';
import 'package:nutmeup/pages/HomePage.dart';
import 'package:nutmeup/pages/_Authentication/LoginPage.dart';
import 'package:nutmeup/pages/_Authentication/RegistrationPage.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../widgets/Buttons/Button.dart';

class OTP extends StatefulWidget {
  OTP({Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  String verificationId;
  String phoneNumber;

  @override
  State<OTP> createState() => _RegistrationState();
}

class _RegistrationState extends State<OTP> {
  late CountdownTimerController countdownController;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 90;
  var codeController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    countdownController = CountdownTimerController(
        endTime: endTime,
        onEnd: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Login(
                        current: SignInMethods.PHONE,
                      )),
              (route) => false);
        });

    super.initState();
  }

  @override
  void dispose() {
    countdownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        backgroundColor: colorWhite,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomButton(
        loading: isLoading,
        margin: const EdgeInsets.only(left: 20, right: 20),
        onClick: () async {
          var CodeEntered = codeController.text.trim();

          if (CodeEntered.length == 6) {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId, smsCode: CodeEntered);

            setState(() {
              isLoading = true;
            });

            try {
              var auth =
                  await FirebaseAuth.instance.signInWithCredential(credential);

              FirebaseFirestore.instance
                  .collection(USERS)
                  .doc(auth.user!.uid)
                  .get()
                  .then((value) {
                if (value.exists) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Registration(
                                current: SignInMethods.PHONE,
                                phone: widget.phoneNumber,
                                userId: auth.user!.uid,
                              )),
                      (route) => false);
                }
              });
            } catch (e) {
              Alart(message: e.toString(), isError: true);
              setState(() {
                isLoading = false;
              });
            }
          } else {
            Alart(message: "Incomplete code", isError: true);
            return;
          }

          //Navigator.push(context, MaterialPageRoute(builder: (builder)=> RegCompleted() ));
        },
        text: "Submit",
      ),
      backgroundColor: const Color(0xffFCFCFC),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(25),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Enter Code",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: colorBlue,
                            fontSize: 32),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Kindly enter the four digit code sent to you",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: colorGray,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 52,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: TextStyle(
                                color: Colors.green.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              obscureText: true,
                              obscuringCharacter: '*',
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              validator: (v) {},
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 45,
                                borderWidth: 1.5,
                                disabledColor: colorLightGray,
                                inactiveFillColor: colorLightGray,
                                inactiveColor: colorLightGray,
                                selectedFillColor: colorLightGray,
                                errorBorderColor: colorLightGray,
                                selectedColor: colorLightGray,
                                activeColor: colorLightGray,
                                activeFillColor: Colors.white,
                              ),
                              cursorColor: Colors.black,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: false,
                              backgroundColor: colorWhite,
                              controller: codeController,
                              keyboardType: TextInputType.number,
                              boxShadows: const [],
                              onCompleted: (v) {},
                              onChanged: (value) {
                                debugPrint(value);
                                setState(() {});
                              },
                              beforeTextPaste: (text) {
                                return true;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Container(
                            width: 300,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Is this your phone number? ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: colorGray,
                                      fontSize: 17),
                                ),
                                Text(
                                  formatPhoneNumber(
                                      phone: widget.phoneNumber
                                          .replaceFirst("+234", "0")),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: colorBlack,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Resend again in ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: colorGray,
                                          fontSize: 17),
                                    ),
                                    CountdownTimer(
                                      controller: countdownController,
                                      widgetBuilder: (context, var time) {
                                        if (time == null) {
                                          return Text('Game over');
                                        }
                                        return Text(
                                          '0${time.min ?? "0"}:${time.sec! < 10 ? '0${time.sec}' : time.sec}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: colorGray,
                                              fontSize: 17),
                                        );
                                      },
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login(
                                                  current: SignInMethods.PHONE,
                                                )),
                                        (route) => false);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Edit Number",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: colorLightBlue,
                                            fontSize: 17),
                                      ),
                                      Text(
                                        "Resend Code",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: colorLightBlue,
                                            fontSize: 17),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
