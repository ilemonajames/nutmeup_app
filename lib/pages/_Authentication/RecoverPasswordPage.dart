import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/pages/_Authentication/LoginPage.dart';
import 'package:nutmeup/pages/_Authentication/RegistrationPage.dart';
import 'package:nutmeup/utilities/validate.dart';
import 'package:nutmeup/widgets/Buttons/ImageButton.dart';
import 'package:nutmeup/widgets/Inputes/EditText.dart';

import '../../utilities/utilities.dart';
import '../../widgets/Buttons/Button.dart';
import '../../widgets/Inputes/PasswordEditText.dart';
import '../HomePage.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({Key? key}) : super(key: key);

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isLoading = false;

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
                      Text(
                        "Email, Phone or User Name",
                        style: TextStyle(fontSize: 12, color: colorGray),
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
                        style: TextStyle(fontSize: 12, color: colorGray),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      PasswordField(
                          controller: passwordController, hint: "Password"),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        loading: isLoading,
                        onClick: () async {
                          String email = inputeValidate(context).ValidateField(
                              emailController,
                              isEmailValid: true);

                          String password = inputeValidate(context)
                              .ValidateField(passwordController);

                          Alart(message: "got here", isError: false);
                          try {
                            var signInUser = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                          } catch (e) {
                            Alart(message: e.toString(), isError: true);
                          }
                          //  Navigator.push(context, MaterialPageRoute(builder: (builder)=> HomePage()));
                        },
                        text: "Recover Password",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 40,
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
                                                      current:
                                                          SignInMethods.EMAIL,
                                                    )));
                                      }),
                                TextSpan(
                                  text: ' Or ',
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600,
                                      color: colorGray,
                                      fontSize: 14),
                                ),
                                TextSpan(
                                    text: 'Login',
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
                                                builder: (builder) => Login()));
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
