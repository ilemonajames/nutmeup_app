import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Mechanic/MechanicModel.dart';
import 'package:nutmeup/models/Requests/RequestModel1.dart';
import 'package:nutmeup/pages/_Mechanic/ViewMechanicProfile.dart';

import 'package:nutmeup/pages/_Stores/CreateShopPage.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Api/LocationApi.dart';
import '../../models/Location/LocationDataModel.dart';
import '../../providers/MyLocationProvider.dart';
import '../../utilities/utilities.dart';
import '../../widgets/Inputes/SearchText.dart';
import '../../widgets/Navigators/BoxNavigator.dart';

class FindAMechanic extends StatefulWidget {
  FindAMechanic({Key? key, required this.item})
      : super(
          key: key,
        );

  RequestItem item;
  @override
  State<FindAMechanic> createState() => _FindAMechanicState();
}

class _FindAMechanicState extends State<FindAMechanic> with Extra {
  var controller = ScrollController();
  var dataStram;
  late GeoFirePoint center;
  late RequestItem item;
  late GeoFirePoint geoFirePoint;

  SingleRepairOption(
      {required String image, required String text, width, height}) {
    bool _hasCallSupport = false;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(left: 10, top: 15),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: backgroundGray,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                ),
                child: Image.asset(
                  image,
                  width: width ?? 35,
                  height: height ?? 35,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 16, color: colorGray),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    item = widget.item;

    geoFirePoint =
        Provider.of<MyLocationProvider>(context, listen: false).geoFirePoint!;
    center = geo.point(
        latitude: geoFirePoint.latitude, longitude: geoFirePoint.longitude);
    //--------------------------------my location----------------||
    dataStram = geo
        .collection(
            collectionRef: firestore
                .collection(MECHANICS)
                .where("status", isEqualTo: "ACTIVE"))
        .within(center: center, radius: 100, field: 'location');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(context)
          .BackAppBarWithTitle(color: colorLightBlue, title: "Find a Mechanic"),
      // appBar: AppBars(context).BackAppBar(color: Colors.white),
      body: Container(
        color: backgroundGray,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: SearchTextField(
                    onChange: (v) {},
                    controller: TextEditingController(),
                    hint: "Search",
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (constext) => ViewMechanicProfile(
                  //             mech: singleMec, distance: "20-200")));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: colorWhite,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  height: 40,
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        "assets/images/icons/blue_filter.png",
                        height: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Text(
                        "Filter",
                        style: TextStyle(
                            color: colorGray,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )),
                      const Icon(Icons.arrow_drop_down_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          item.location == null
              ? Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const CreateStorePage()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: colorWhite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          height: 40,
                          width: 150,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 15,
                                  color: colorBlue,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Find on Map",
                                  style: TextStyle(
                                      color: colorBlue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ]),
                        )),
                  ],
                )
              : SizedBox(),
          const SizedBox(
            height: 15,
          ),
          BoxNavigator(
            onChange: (index) {
              if (index == 0) {
                dataStram = geo
                    .collection(
                        collectionRef: firestore
                            .collection(MECHANICS)
                            .where("status", isEqualTo: "ACTIVE"))
                    .within(center: center, radius: 100, field: 'location');
              } else {
                var queryRef = firestore
                    .collection(MECHANICS)
                    .where("status", isEqualTo: "ACTIVE")
                    .where('storeType', isEqualTo: index - 1);

                dataStram = geo
                    .collection(collectionRef: queryRef)
                    .within(center: center, radius: 100, field: 'location');
              }

              setState(() {});
            },
            namesList: const ["All", "Mobile", "Workshop", "Hybrid"],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: StreamBuilder(
            stream: dataStram,
            builder: (a,
                AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>> b) {
              if (b.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (b.hasData) {
                if (b.data!.isEmpty) {
                  return const Center(
                    child: Text("Nothing found. "),
                  );
                }

                List<MechanicModel> models = [];
                b.data!.forEach((element) {
                  models.add(MechanicModel.fromJson(
                      element.data() as Map<String, dynamic>));
                });
                return ListView.builder(
                    itemCount: models.length,
                    shrinkWrap: true,
                    itemBuilder: (a, b) {
                      List<LatLng> polylineCoordinates = [];

                      MechanicModel singleMec = models[b];

                      LatLng startLocation =
                          LatLng(geoFirePoint.latitude, geoFirePoint.longitude);
                      LatLng endLocation = LatLng(
                          singleMec.location!.geopoint!.latitude,
                          singleMec.location!.geopoint!.latitude);

                      return FutureBuilder(
                          future: LocationApi(context)
                              .LocationData(startLocation, endLocation),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              PolylineResult? polyRes = snapshot.data["poly"];
                              GetLocationData? localRes =
                                  snapshot.data["local"];

                              if (polyRes!.points.isNotEmpty) {
                                polyRes.points.forEach((PointLatLng point) {
                                  polylineCoordinates.add(
                                      LatLng(point.latitude, point.longitude));
                                });
                              } else {
                                print(snapshot.error);
                              }

                              double totalDistance = 0;
                              for (var i = 0;
                                  i < polylineCoordinates.length - 1;
                                  i++) {
                                totalDistance += calculateDistance(
                                    polylineCoordinates[i].latitude,
                                    polylineCoordinates[i].longitude,
                                    polylineCoordinates[i + 1].latitude,
                                    polylineCoordinates[i + 1].longitude);
                              }

                              String specials = "";
                              singleMec.specailization!.forEach(
                                (element) {
                                  specials = element + " | ";
                                },
                              );

                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: colorWhite,
                                ),
                                margin: EdgeInsets.only(bottom: 10),
                                child: Stack(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (constext) =>
                                                              ViewMechanicProfile(
                                                                item: item,
                                                                mech: singleMec,
                                                                distance: localRes!
                                                                            .rows!
                                                                            .first
                                                                            .elements!
                                                                            .first
                                                                            .distance !=
                                                                        null
                                                                    ? "${totalDistance.roundToDouble().toInt()}Km away (${localRes.rows!.first.elements!.first.duration!.text})"
                                                                    : "No close route",
                                                              )));
                                                },
                                                child: Container(
                                                  width: 120,
                                                  height: 130,
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                    child: Image.network(
                                                      singleMec.iamge!,
                                                      height: 150,
                                                      width: 130,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: colorWhite,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(5)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 7,
                                                        offset: const Offset(0,
                                                            5), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                singleMec.name!,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: colorGray),
                                              ),
                                              Text(
                                                specials,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: colorBlue),
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Icon(
                                                        Icons.location_pin,
                                                        size: 13,
                                                        color: colorBlue,
                                                      ),
                                                      Text(
                                                        localRes!
                                                            .destinationAddresses!
                                                            .first,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: colorBlue,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                    localRes
                                                                .rows!
                                                                .first
                                                                .elements!
                                                                .first
                                                                .distance !=
                                                            null
                                                        ? "${totalDistance.roundToDouble().toInt()}Km away (${localRes.rows!.first.elements!.first.duration!.text})"
                                                        : "     No close route",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: colorGray,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${singleMec.sRating}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: colorGray,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        size: 16,
                                                        color: colorGray,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${singleMec.sProducts} ",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: colorGray,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      const Icon(
                                                        Icons.handyman_outlined,
                                                        size: 13,
                                                        color:
                                                            Color(0xff343434),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      try {
                                                        final Uri launchUri =
                                                            Uri(
                                                          scheme: 'tel',
                                                          path:
                                                              singleMec.phone!,
                                                        );
                                                        await launchUrl(
                                                            launchUri);
                                                      } on Exception catch (e) {
                                                        //
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5,
                                                              bottom: 5,
                                                              left: 10,
                                                              right: 10),
                                                      decoration: const BoxDecoration(
                                                          color:
                                                              Color(0xff6BAEFF),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                      child:
                                                          Row(children: const [
                                                        Icon(
                                                          Icons.call_outlined,
                                                          size: 18,
                                                          color:
                                                              Color(0xff343434),
                                                        ),
                                                        Text(
                                                          "    Call   ",
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xff343434)),
                                                        ),
                                                      ]),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ))
                                        ]),
                                  ],
                                ),
                              );
                            } else {
                              return Text("loading");
                            }
                          });
                    });
              }

              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          )),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
