import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/pages/_Authentication/OTPPage.dart';
import 'package:nutmeup/pages/_Authentication/RegistrationPage.dart';
import 'package:nutmeup/utilities/validate.dart';
import 'package:nutmeup/widgets/Buttons/ImageButton.dart';
import 'package:nutmeup/widgets/Inputes/EditText.dart';

import '../../utilities/utilities.dart';
import '../../widgets/Buttons/Button.dart';
import '../../widgets/Inputes/PasswordEditText.dart';
import '../HomePage.dart';

enum SignInMethods { GOOGLE, PHONE, EMAIL }

class Login extends StatefulWidget {
  Login({Key? key, this.current}) : super(key: key);

  var current;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  SignInMethods currentMethods = SignInMethods.EMAIL;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    currentMethods = widget.current ?? currentMethods;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        backgroundColor: colorWhite,
      ),
      backgroundColor: colorWhite,
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
                        "Welcome back",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: colorBlue,
                            fontSize: 32),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Please enter your details",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: colorBlack,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      currentMethods == SignInMethods.EMAIL
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email address",
                                  style:
                                      TextStyle(fontSize: 12, color: colorGray),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                EditTextField(
                                  controller: emailController,
                                  hint: "Email",
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Password",
                                  style:
                                      TextStyle(fontSize: 12, color: colorGray),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                PasswordField(
                                    controller: passwordController,
                                    hint: "Password"),
                              ],
                            )
                          : Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone Number",
                                      style: TextStyle(
                                          fontSize: 12, color: colorGray),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    EditTextField(
                                      isPhone: true,
                                      controller: emailController,
                                      hint: "070 1234 56789",
                                    )
                                  ]),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        loading: isLoading,
                        onClick: () async {
                          if (currentMethods == SignInMethods.PHONE) {
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => OTP(
                            //               verificationId: "verificationId",
                            //               phoneNumber: "0902345322",
                            //             )));

                            var phone = inputeValidate(context).ValidateField(
                                emailController,
                                isDigit: true,
                                aboveOrBelow: AboveOrBelow.EQUAL,
                                checkCount: 11);

                            if (phone.toString().split("")[0] != "0") {
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });

                            var phone_ =
                                phone.toString().replaceFirst("0", "+234");

                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: phone_,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {
                                setState(() {
                                  isLoading = false;
                                });
                                Alart(
                                    message: e.code.replaceAll("-", " "),
                                    isError: true);
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OTP(
                                              verificationId: verificationId,
                                              phoneNumber: phone_,
                                            )));
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                setState(() {
                                  isLoading = false;
                                  Alart(
                                      message: "Operation timed out",
                                      isError: true);
                                });
                              },
                            );

                            return;
                          }
                          var email = inputeValidate(context).ValidateField(
                              emailController,
                              isEmailValid: true);

                          var password = inputeValidate(context)
                              .ValidateField(passwordController);

                          setState(() {
                            isLoading = true;
                          });
                          try {
                            var signInuser = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                          } catch (e) {
                            Alart(message: e.toString(), isError: true);
                            setState(() {
                              isLoading = false;
                            });
                            return;
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const HomePage()));
                        },
                        text: "Login",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      currentMethods == SignInMethods.EMAIL
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      fontSize: 14, color: colorLightBlue),
                                ),
                              ],
                            )
                          : SizedBox(),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomImageButton(
                        onClick: () {
                          setState(() {
                            if (currentMethods == SignInMethods.EMAIL) {
                              currentMethods = SignInMethods.PHONE;
                            } else {
                              currentMethods = SignInMethods.EMAIL;
                            }
                          });
                        },
                        icon: currentMethods == SignInMethods.EMAIL
                            ? Icons.phone
                            : Icons.email_outlined,
                        text:
                            "Login with ${currentMethods == SignInMethods.EMAIL ? "Phone" : "Email"}",
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account?  ',
                              style: TextStyle(
                                  color: colorGray,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign up here',
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w600,
                                        color: colorLightBlue,
                                        fontSize: 14),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    Registration(
                                                      current: currentMethods,
                                                    )));
                                      })
                              ]),
                        ),
                      )
                    ],
                  ),
                ],
              ))),
    );
  }
}
