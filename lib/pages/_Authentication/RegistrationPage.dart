import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/models/Authentication/UserModel.dart';
import 'package:nutmeup/pages/_Authentication/LoginPage.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/utilities/validate.dart';
import 'package:nutmeup/widgets/Buttons/ImageButton.dart';
import 'package:nutmeup/widgets/Inputes/EditText.dart';

import '../../widgets/Buttons/Button.dart';
import '../../widgets/Inputes/PasswordEditText.dart';
import 'RegistrationCompleted.dart';

class Registration extends StatefulWidget {
  Registration({Key? key, required this.current, this.userId, this.phone})
      : super(key: key);

  SignInMethods current;
  var userId;
  var phone;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var fname = TextEditingController();
  var number = TextEditingController();
  var email = TextEditingController();
  var location = TextEditingController();
  var password = TextEditingController();
  var cpassword = TextEditingController();

  bool isLoading = false;
  late String userId;

  @override
  void initState() {
    super.initState();
    if (widget.phone != null) {
      number.text = widget.phone.toString();
      userId = widget.userId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        elevation: 0.0,
        backgroundColor: Color(0xffFCFCFC),
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
                        "Get Started",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: colorBlue,
                            fontSize: 32),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sign up to book a car service, earn more as a mechanic or to buy and  sell spare parts.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: colorGray,
                            fontSize: 18),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      EditTextField(
                        controller: fname,
                        hint: "Full Name",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      EditTextField(
                        controller: number,
                        editable: (widget.current != SignInMethods.PHONE),
                        hint: "Phone Number",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      EditTextField(
                        controller: email,
                        hint: "Email (optional)",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      EditTextField(
                        controller: location,
                        hint: "Location",
                      ),
                      widget.userId == null
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                PasswordField(
                                    controller: password, hint: "Password"),
                                const SizedBox(
                                  height: 20,
                                ),
                                PasswordField(
                                    controller: cpassword,
                                    hint: "Confirm Password"),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        onClick: () async {
                          var _fname =
                              inputeValidate(context).ValidateField(fname);
                          var _number =
                              inputeValidate(context).ValidateField(number);
                          var _email;

                          if (inputeValidate(context)
                                  .ValidateField(email, isEmailValid: true) !=
                              null) {
                            _email = email.text;
                          } else {
                            return;
                          }

                          var _location =
                              inputeValidate(context).ValidateField(location);

                          var _password = widget.current == SignInMethods.EMAIL
                              ? inputeValidate(context).ValidateField(password)
                              : "__phone__auth__";
                          var _cpassword = widget.current == SignInMethods.EMAIL
                              ? inputeValidate(context).ValidateField(cpassword)
                              : "__phone__auth__";

                          if (widget.current == SignInMethods.EMAIL) {
                            if (_cpassword != _password) {
                              Alart(
                                  message: "Passwords do not match",
                                  isError: true);
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });

                            var createUser = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _email, password: _password);

                            userId = createUser.user!.uid;
                            if (createUser.user != null) {
                            } else {
                              setState(() {
                                isLoading = false;
                                Alart(
                                    message: "Some error occured",
                                    isError: true);
                              });
                              return;
                            }
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                          }

                          UserModel model = UserModel(
                              password: hashPassword(password: _password),
                              createdAt: FieldValue.serverTimestamp(),
                              updatedAt: null,
                              status: USERSTATUS.ACTIVE.name,
                              userId: userId,
                              bioData: BioData(
                                  name: _fname,
                                  email: _email,
                                  phone: _number
                                      .toString()
                                      .replaceFirst("+234", "0")),
                              kycData: KycData(emailStatus: false));

                          FirebaseFirestore.instance
                              .collection(USERS)
                              .doc(model.userId)
                              .set(model.toJson())
                              .then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        const RegCompleted()));
                          }).onError((error, stackTrace) {
                            Alart(message: error.toString(), isError: true);
                            setState(() {
                              isLoading = false;
                            });
                            return null;
                          });
                        },
                        loading: isLoading,
                        text: "Sign Up",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      widget.current == SignInMethods.EMAIL
                          ? CustomImageButton(
                              icon: Icons.phone,
                              onClick: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Login(
                                              current: SignInMethods.PHONE,
                                            ))),
                                    (route) => false);
                              },
                              text: "Login with Phone",
                            )
                          : SizedBox(),
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                              text: 'Already have an account?  ',
                              style: TextStyle(
                                  color: colorGray,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Login here',
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
