import 'dart:async';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '../../widgets/Inputes/EditText.dart';

class SearchMapPage extends StatefulWidget {
  @override
  State<SearchMapPage> createState() => SearchMapPageState();
}

class SearchMapPageState extends State<SearchMapPage> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // static final CameraPosition _kLake = CameraPosition(
  //     bearing: 192.8334901395799,
  //     target: LatLng(37.43296265331129, -122.08832357078792),
  //     tilt: 59.440717697143555,
  //     zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(context).BackAppBar(color: colorWhite),
      body: Stack(
        children: [
          Expanded(
              child: GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          )),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 140,
                  width: 20,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Color(0xff34A853)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                      const Expanded(
                          child: DottedLine(
                        direction: Axis.vertical,
                        lineLength: double.infinity,
                        lineThickness: 2.0,
                        dashLength: 10.0,
                        dashColor: Color(0xffD0D0D0),
                        dashGapLength: 5.0,
                        dashGapRadius: 0.0,
                      )),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 3, color: Color(0xffE22162)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pick-up Address",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colorBlue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: false,
                            controller: TextEditingController(),
                            focusNode: FocusNode(),
                            decoration: InputDecoration(
                              suffixIcon: Container(
                                  margin: EdgeInsets.only(
                                      left: 3, right: 5, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                      color: colorLightGray,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  width: 70,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.location_pin,
                                        color: colorBlue,
                                      ),
                                      Text('  Map')
                                    ],
                                  )),
                              hintStyle: TextStyle(fontSize: 13),
                              floatingLabelBehavior: FloatingLabelBehavior
                                  .never, //Hides label on focus or if filled
                              labelText: "X9G8+675, 9001109, Wuse",
                              filled: true, // Needed for adding a fill color
                              fillColor: colorWhite,
                              isDense: true, // Reduces height a bit
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: colorLightGray), // No border
                                borderRadius: BorderRadius.circular(
                                    12), // Apply corner radius
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: colorLightGray), // No border
                                borderRadius: BorderRadius.circular(
                                    12), // Apply corner radius
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: colorLightGray), // No border
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, right: 15, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Drop-off Address",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colorBlue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          EditTextField(
                            controller: TextEditingController(),
                            hint: "Title of product goes here",
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ],
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}
