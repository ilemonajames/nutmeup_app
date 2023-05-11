import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/models/Requests/RequestModel1.dart';
import 'package:nutmeup/providers/MyLocationProvider.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';
import 'package:provider/provider.dart';

import '../../models/Mechanic/MechanicModel.dart' as mod;
import '../_Cars/ListCars.dart';
import 'LocationSearch.dart';

class MapSample extends StatefulWidget {
  MapSample({required this.repair_class});
  REPAIR_CLASS repair_class;

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kGooglePlex;
  late RequestItem request;

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  late Marker _marker_2;
  late GeoFirePoint? myLocation;

  ///

  @override
  void initState() {
    super.initState();
    myLocation =
        Provider.of<MyLocationProvider>(context, listen: false).geoFirePoint;

    if (myLocation != null) {
      _kGooglePlex = CameraPosition(
        target: LatLng(myLocation!.latitude, myLocation!.longitude),
        zoom: 17.4746,
      );

      _marker_2 = Marker(
          markerId: const MarkerId("MyLocation"),
          position: LatLng(myLocation!.latitude, myLocation!.longitude));

      request = RequestItem(
        intent: widget.repair_class.name,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(context).BackAppBar(color: colorWhite),
      body: Stack(
        children: [
          Expanded(
              child: (myLocation == null)
                  ? Container(
                      margin: const EdgeInsets.only(
                          bottom: 100, top: 100, right: 50, left: 50),
                      alignment: Alignment.bottomCenter,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Location Error!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: colorBlue,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "We could not access your device location due a permission error. Please go to your device setting and enable location service",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15, color: colorBlue),
                            )
                          ]),
                    )
                  : GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _kGooglePlex,
                      markers: {
                        _marker_2,
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    )),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/images/icons/world_map.png",
                  width: 120,
                  height: 120,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                  ),
                  child: Text(
                    "Where is the Car?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 20),
                  child: Text(
                    "Kindly let us know the car’s location so that\nwe can find technicians within the area",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: colorGray,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                (myLocation == null)
                    ? const SizedBox()
                    : GestureDetector(
                        onTap: () {
                          var geoHasher = GeoHasher();
                          String locationHash = geoHasher.encode(
                              myLocation!.longitude, myLocation!.latitude,
                              precision: 6);

                          mod.Location location = mod.Location(
                              geohash: locationHash,
                              geopoint: GeoPoint(
                                  myLocation!.latitude, myLocation!.longitude));

                          request.location = location;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ListAllCars(
                                        item: request,
                                      )));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: colorBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(
                            "Use Current Location",
                            style: TextStyle(
                                color: colorWhite,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      var locatonData = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => LocationSearchPage()));

                      if (locatonData != null) {
                        List<dynamic> locations = await locationFromAddress(
                            (locatonData as Map)["title"]);

                        if (locations.isNotEmpty) {
                          double lat = ((locations[0])
                              as Map<String, dynamic>)["Latitude"];
                          double long = ((locations[0])
                              as Map<String, dynamic>)["Longitude"];

                          var geoHasher = GeoHasher();
                          String locationHash =
                              geoHasher.encode(long, lat, precision: 6);

                          mod.Location location = mod.Location(
                              geohash: locationHash,
                              geopoint: GeoPoint(
                                  myLocation!.latitude, myLocation!.longitude));

                          request.location = location;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ListAllCars(
                                        item: request,
                                      )));
                        } else {
                          Alart(
                              message: "No selection was made", isError: true);
                        }
                      } else {
                        Alart(message: "No selection was made", isError: true);
                      }
                    } catch (e) {}
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: colorWhite,
                        border: Border.all(width: 1, color: colorBlue),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      "Input Location Manually",
                      style: TextStyle(
                          color: colorBlue,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: Text('To the lake!'),
      //   icon: Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
