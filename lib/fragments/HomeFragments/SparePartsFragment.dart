import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';
import 'package:nutmeup/pages/_Payments/PaymentPage.dart';
import 'package:nutmeup/pages/_Stores/CreateShopPage.dart';
import 'package:nutmeup/pages/_Stores/ViewProductPage.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Product/Products.dart';

import '../../Api/LocationApi.dart';
import '../../models/Location/LocationDataModel.dart';
import '../../widgets/Inputes/SearchText.dart';
import '../../widgets/Navigators/BoxNavigator.dart';

class SparePartsPage extends StatefulWidget {
  const SparePartsPage({Key? key}) : super(key: key);

  @override
  State<SparePartsPage> createState() => _SparePartsPageState();
}

class _SparePartsPageState extends State<SparePartsPage> with Extra {
  var controller = ScrollController();

  LatLng startLocation = const LatLng(7.500640, 9.061460);
  LatLng endLocation = const LatLng(7.500640, 9.061460);

  var dataStram;
  late GeoFirePoint center;

  List<String> arrOptions = ["All", "Accessories", "Fluids", "Spare Parts"];

  SingleRepairOption(
      {required String image, required String text, width, height}) {
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

  // ignore: non_constant_identifier_names
  SingleProduct({required ProductModel product, required String itemId}) {
    List<LatLng> polylineCoordinates = [];

    return FutureBuilder(
        future: LocationApi(context).LocationData(startLocation, endLocation),
        builder: (context, AsyncSnapshot<dynamic> res) {
          if (res.hasData) {
            PolylineResult? polyRes = res.data["poly"];
            GetLocationData? localRes = res.data["local"];

            if (polyRes!.points.isNotEmpty) {
              polyRes.points.forEach((PointLatLng point) {
                polylineCoordinates
                    .add(LatLng(point.latitude, point.longitude));
              });
            } else {
              print(res.error);
            }

            double totalDistance = 0;
            for (var i = 0; i < polylineCoordinates.length - 1; i++) {
              totalDistance += calculateDistance(
                  polylineCoordinates[i].latitude,
                  polylineCoordinates[i].longitude,
                  polylineCoordinates[i + 1].latitude,
                  polylineCoordinates[i + 1].longitude);
            }

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewProductPage(
                              product: product,
                              itemId: itemId,
                            )));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorWhite,
                ),
                margin: const EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 120,
                                height: 140,
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  child: Image.network(
                                    product.gallery!.first.link!,
                                    height: 150,
                                    width: 130,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 130,
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    color: Color(0xffE4F0FF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(top: 6),
                                child: Text(
                                  (product.condition ==
                                          ITEM_CONDITION.BRAND_NEW)
                                      ? "Brand New"
                                      : (product.condition ==
                                              ITEM_CONDITION.FAIRLY_USED)
                                          ? "Fairly Used"
                                          : "Used",
                                  style: TextStyle(color: colorBlue),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: colorBlue),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        product.sRatting.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: colorGray,
                                            fontWeight: FontWeight.w600),
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
                                  Text(
                                    "( ${product.reviews ?? 'No'} Reviews )",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: colorGray,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "${formatAmount(product.price!.amount)} ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: colorLightBlue),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 13,
                                        color: colorBlue,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        width: 150,
                                        child: Text(
                                          localRes!.destinationAddresses!.first,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: colorBlue,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    localRes.rows!.first.elements!.first
                                                .distance !=
                                            null
                                        ? "${totalDistance.roundToDouble().toInt()}Km away (${localRes.rows!.first.elements!.first.duration!.text})"
                                        : "No close route",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: colorGray,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ],
                          ))
                        ]),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => PaymentHome(
                                        itemId: itemId,
                                        data: product,
                                        type: PAYMENT_TYPE.PRODUCT)));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            decoration: const BoxDecoration(
                                color: Color(0xff6BAEFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(children: const [
                              Icon(
                                Icons.shopping_cart,
                                size: 18,
                                color: Color(0xff343434),
                              ),
                              Text(
                                "    Buy   ",
                                style: TextStyle(color: Color(0xff343434)),
                              ),
                            ]),
                          ),
                        ))
                  ],
                ),
              ),
            );
          }
          return SingleLoading(context);
        });
  }

  @override
  void initState() {
    center = geo.point(latitude: 9.0719056, longitude: 7.4675026);
    dataStram = geo
        .collection(
            collectionRef: firestore
                .collection(PRODUCTS)
                .where("status", isEqualTo: "ACTIVE"))
        .within(center: center, radius: 100, field: 'location');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundGray,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 10,
        ),

        Container(
          child: SearchTextField(
            onChange: (v) {},
            controller: TextEditingController(),
            hint: "Search",
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => const CreateStorePage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorLightBlue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    height: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/icons/white_sell_on_nutmeup.png",
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sell on NutMeUp",
                            style: TextStyle(
                                color: colorWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )
                        ]),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    "assets/images/icons/blue_filter.png",
                    height: 20,
                  ),
                  const SizedBox(
                    width: 20,
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
                    width: 10,
                  ),
                ],
              ),
            )),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        BoxNavigator(
          onChange: (index) {
            setState(() {
              if (index == 0) {
                dataStram = geo
                    .collection(
                        collectionRef: firestore
                            .collection(PRODUCTS)
                            .where("status", isEqualTo: "ACTIVE"))
                    .within(center: center, radius: 100, field: 'location');
              } else {
                var queryRef = firestore
                    .collection(PRODUCTS)
                    .where("status", isEqualTo: "ACTIVE")
                    .where('category', isEqualTo: arrOptions[index].toString());

                dataStram = geo
                    .collection(collectionRef: queryRef)
                    .within(center: center, radius: 100, field: 'location');
              }
            });
          },
          namesList: arrOptions,
        ),
        const SizedBox(
          height: 15,
        ),

        // Container(
        //   alignment: Alignment.center,
        //   child: EmptyMessage(
        //       message: "Create New",
        //       onClick: () {
        //         // Navigator.push(
        //         //     context,
        //         //     MaterialPageRoute(
        //         //         builder: ((context) =>  CreateNewCar())));
        //       },
        //       title:
        //           DefaultMessages().emptyMessage(about: "Product")),
        // ),

        // FutureBuilder(
        //     future: ,
        //     builder: (a, b) {
        //       return Text("data");
        //     }),

        Expanded(
          child: StreamBuilder(
              stream: dataStram,
              builder: (a,
                  AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
                      b) {
                List<ProductModel> products = [];

                if (b.connectionState == ConnectionState.waiting) {
                  return SingleLoading(context);
                }

                if (b.connectionState == ConnectionState.active) {
                  if (b.data == null) {
                    return Container(
                      alignment: Alignment.center,
                      child: const Text("Nothing here to see"),
                    );
                  }
                }

                if (b.hasData) {
                  if (b.data!.isEmpty) {
                    return const Center(
                      child: Text("Nothing here yet!!"),
                    );
                  } else {
                    b.data!.forEach((element) {
                      products.add(ProductModel.fromJson(
                          element.data() as Map<String, dynamic>));
                    });
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return ListView.builder(
                    itemCount: products.length,
                    shrinkWrap: false,
                    itemBuilder: (a, index) {
                      return SingleProduct(
                          product: products[index], itemId: b.data![index].id);
                    });
              }),
        ),

        const SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
