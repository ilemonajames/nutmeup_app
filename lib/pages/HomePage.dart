import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Authentication/UserModel.dart';
import 'package:nutmeup/providers/MyLocationProvider.dart';
import 'package:nutmeup/providers/UsersProvider.dart';
import 'package:nutmeup/widgets/Navigators/BottomNavigation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../constants/Colors.dart';
import '../fragments/HomeFragments/AccountFragment.dart';
import '../fragments/HomeFragments/DeliveryFragment.dart';
import '../fragments/HomeFragments/HomeFragment.dart';
import '../fragments/HomeFragments/RepairFragment.dart';
import '../fragments/HomeFragments/SparePartsFragment.dart';
import 'package:location/location.dart' as locate;

import 'dart:io' show Platform;

import '_Stores/Orders/OrdersHomePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Extra {
  int currentBtnNavPosition = 0;
  var controller = PageController();
  bool alwayLocationPermission = false;
  bool locationPermission = false;

  locate.Location location = locate.Location();

  Future<UserModel> getInfo() async {
    UserModel model;
    var a = await firestore.collection(USERS).doc(userId).get();
    if (a.exists) {
      model = UserModel.fromJson(a.data() as Map<String, dynamic>);
      Provider.of<UserProvider>(context, listen: false)
          .updateUserProvider(model);

      return model;
    } else {
      return UserModel();
    }
  }

// update my location every 5 minuetes
  checkLocationPermission() async {
    alwayLocationPermission =
        await Permission.locationAlways.request().isGranted;
    if (alwayLocationPermission) {
      locationPermission = await Permission.location.request().isGranted;

      if (locationPermission) {
        location.enableBackgroundMode(enable: true);
      }

      if (Platform.isAndroid || Platform.isIOS) {
        location.onLocationChanged
            .listen((locate.LocationData currentLocation) {
          print(currentLocation.toString());

          var MyLocation = geo.point(
              latitude: currentLocation.latitude!,
              longitude: currentLocation.longitude!);

          Provider.of<MyLocationProvider>(context, listen: false)
              .updateMyLocation(MyLocation);

          // firestore
          //     .collection(USERS)
          //     .doc(userId)
          //     .set({'location': MyLocation.data}, SetOptions(merge: true));

          // print(currentLocation);
        });
      }
    } else {
      print("No ");
      await Permission.locationAlways.request().isGranted;
      await Permission.location.request().isGranted;
      // var status = await Permission.locationWhenInUse.request();
      // print(status);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLocationPermission();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        bottomNavigationBar: BottomNavigation(
          currentPage: currentBtnNavPosition,
          onChange: (index) {
            setState(() {
              currentBtnNavPosition = index;
              controller.animateToPage(currentBtnNavPosition,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.decelerate);
            });
          },
        ),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "NutMeUp",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            (currentBtnNavPosition != 0 && currentBtnNavPosition != 4)
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: (() {
                            if (currentBtnNavPosition == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const OrdersHomePage())));
                            }
                          }),
                          child: Row(
                            children: [
                              Text(
                                (currentBtnNavPosition == 0)
                                    ? ""
                                    : currentBtnNavPosition == 1
                                        ? "Repairs"
                                        : currentBtnNavPosition == 2
                                            ? "Orders"
                                            : currentBtnNavPosition == 3
                                                ? "Deliveries"
                                                : "",
                                style: TextStyle(
                                    color: colorLightBlue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                  height: 23,
                                  width: 23,
                                  margin:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: colorLightBlue,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    "9",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: colorWhite,
                                        fontWeight: FontWeight.w700),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox()
          ],
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: getInfo(),
          builder: (a, AsyncSnapshot<UserModel> b) {
            if (b.hasData) {
              return PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    currentBtnNavPosition = value;
                  });
                },
                children: const [
                  HomeFragment(),
                  RepairFragment(),
                  SparePartsPage(),
                  DeliveryFragment(),
                  AccountFragment()
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ));
  }
}
