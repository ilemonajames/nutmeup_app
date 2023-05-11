import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/fragments/AccountFragments/MechanicProfileFragment.dart';
import 'package:nutmeup/fragments/AccountFragments/MyStoreFragment.dart';
import 'package:nutmeup/pages/_Authentication/LoginPage.dart';
import 'package:nutmeup/pages/_Cars/createCar.dart';
import 'package:nutmeup/providers/UsersProvider.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:provider/provider.dart';

import '../../containers/MyProducts.dart';
import '../../pages/_Authentication/_Verification/VerifyHomePage.dart';
import '../../utilities/modal.dart';
import '../AccountFragments/MyVehicleFragment.dart';

class AccountFragment extends StatefulWidget {
  const AccountFragment({Key? key}) : super(key: key);

  @override
  State<AccountFragment> createState() => _AccountFragmentState();
}

class _AccountFragmentState extends State<AccountFragment>
    with TickerProviderStateMixin, Extra {
  var controller = ScrollController();
  var currentTap = 0;

  // var MyVehicle;
  // var MyMechanic;
  // var MyStore;

  final MyVehicle = const MyVehicleFragment();
  final MyMechanic = const MachanicProfileFragment();
  final MyStore = const MyStoreFragment();

  SinglePageAction({
    required Function onClick,
    required String title,
  }) {
    return Expanded(
        child: GestureDetector(
      onTap: () => onClick(),
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: colorWhite,
            border: Border.all(color: Color(0xffDFDFDF), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(7))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(color: colorBlue, fontSize: 15),
              )
            ]),
      ),
    ));
  }

  SinglePageOption({
    required Function onClick,
    required String title,
    required String image,
  }) {
    return Expanded(
        child: GestureDetector(
      onTap: () => onClick(),
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            color: Color(0xffF4F9FF),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: TextStyle(color: colorBlue, fontSize: 15),
              )
            ]),
      ),
    ));
  }

  var tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);

    return SingleChildScrollView(
        controller: controller,
        child: Container(
          color: backgroundGray,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Account",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: colorBlue),
                      ),
                      GestureDetector(
                        onTap: () {
                          showMessageDialog(context,
                              title: "Logout",
                              message:
                                  "You are about to logout are you sure you want to proceed?",
                              onProceed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                                (route) => false);
                          });
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icons/logout.png",
                              height: 14,
                            ),
                            Text(
                              "  logout",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: colorRed),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Stack(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 55,
                                  height: 55,
                                  margin: EdgeInsets.only(left: 5),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: colorGray.withOpacity(.4),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(40)),
                                  ),
                                  child: Image.asset(
                                    "assets/images/icons/big_profile.png",
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${user.userModel!.bioData!.name}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: colorBlue,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      formatPhoneNumber(
                                          phone:
                                              user.userModel!.bioData!.phone!),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: colorGray,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "${user.userModel!.bioData!.email ?? "(Add email)"}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const VerifyHome()));
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffE4F0FF),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: colorLightBlue),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                  ),
                                                  child: Text(
                                                    "     Verify     ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: colorLightBlue,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SinglePageOption(
                                    image:
                                        "assets/images/icons/see_favourites.png",
                                    title: "See Favorites",
                                    onClick: () {}),
                                SizedBox(
                                  width: 10,
                                ),
                                SinglePageOption(
                                    image:
                                        "assets/images/icons/pending_reviews.png",
                                    title: "Pending Reviews",
                                    onClick: () {})
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                SinglePageOption(
                                    image: "assets/images/icons/boost_ads.png",
                                    title: "Boost Adverts",
                                    onClick: () {}),
                                SizedBox(
                                  width: 10,
                                ),
                                SinglePageOption(
                                    image:
                                        "assets/images/icons/authentication.png",
                                    title: "Authentication ",
                                    onClick: () {})
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ]),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/icons/edit.png",
                                width: 20,
                                height: 20,
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: colorGray,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SinglePageAction(
                            title: "Add a Vehicle",
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => CreateNewCar()));
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        SinglePageAction(
                            title: "Sell Spare Parts", onClick: () {})
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        SinglePageAction(
                            title: "I am a Mechanic", onClick: () {}),
                        SizedBox(
                          width: 10,
                        ),
                        SinglePageAction(
                            title: "Delivery Agent", onClick: () {})
                      ],
                    ),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(13))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TabBar(
                          controller: tabController,
                          onTap: (index) {
                            setState(() {
                              currentTap = index;
                            });
                          },
                          indicatorWeight: 4,
                          indicatorColor: colorLightBlue,
                          isScrollable: false,
                          labelStyle: const TextStyle(fontSize: 13),
                          unselectedLabelStyle:
                              const TextStyle(color: Colors.black),
                          enableFeedback: true,
                          unselectedLabelColor: colorBlue,
                          labelColor: colorBlue,
                          tabs: const [
                            Tab(
                              text: "My Vehicle",
                            ),
                            Tab(
                              text: "Mechanic Profile",
                            ),
                            Tab(
                              text: "My Store",
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: colorLightGray,
                        ),
                        Visibility(
                          maintainState: true,
                          child: MyVehicle,
                          visible: (currentTap == 0),
                        ),
                        Visibility(
                          maintainState: true,
                          child: MyMechanic,
                          visible: (currentTap == 1),
                        ),
                        Visibility(
                          maintainState: true,
                          child: MyStore,
                          visible: (currentTap == 2),
                        ),
                      ]),
                ),
                Visibility(
                    visible: (currentTap == 2),
                    maintainState: true,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: const MyProducts(),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ]),
        ));
  }
}
