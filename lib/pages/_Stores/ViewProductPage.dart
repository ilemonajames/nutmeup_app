import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nutmeup/Api/LocationApi.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Location/LocationDataModel.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';
import 'package:nutmeup/utilities/TimeAgo.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Inputes/ImageView.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';
import 'package:skeletons/skeletons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/Colors.dart';
import '../../constants/DBNames.dart';
import '../../models/Store/StoreModel.dart';
import '../../utilities/Enums.dart';
import '../_Payments/PaymentPage.dart';

class ViewProductPage extends StatefulWidget {
  ViewProductPage({Key? key, required this.product, required this.itemId})
      : super(key: key);

  ProductModel product;
  String itemId;

  @override
  State<ViewProductPage> createState() => _ViewProductPageState();
}

_SingleLoading(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: colorWhite, borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 30,
                  width: 70,
                  borderRadius: BorderRadius.circular(5),
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                  )),
            ),
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  padding: EdgeInsets.only(top: 15, right: 15),
                  shape: BoxShape.circle,
                  width: 30,
                  height: 30),
            )
          ],
        ),
        SkeletonLine(
          style: SkeletonLineStyle(
              borderRadius: BorderRadius.circular(5),
              height: 220,
              padding: const EdgeInsets.all(15)),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(5),
                  height: 10,
                  width: 10,
                  padding: const EdgeInsets.only(left: 7, right: 7)),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                borderRadius: BorderRadius.circular(5),
                height: 10,
                width: 10,
              ),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(5),
                  height: 10,
                  width: 10,
                  padding: const EdgeInsets.only(left: 7, right: 7)),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: SkeletonParagraph(
            style: SkeletonParagraphStyle(
                lines: 2,
                spacing: 6,
                lineStyle: SkeletonLineStyle(
                  randomLength: true,
                  height: 15,
                  borderRadius: BorderRadius.circular(8),
                  minLength: MediaQuery.of(context).size.width / 2,
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 20,
                  width: 70,
                  borderRadius: BorderRadius.circular(5),
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                  )),
            ),
            SkeletonLine(
              style: SkeletonLineStyle(
                  height: 20,
                  width: 70,
                  borderRadius: BorderRadius.circular(5),
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                  )),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        SkeletonParagraph(
          style: SkeletonParagraphStyle(
              lines: 3,
              spacing: 6,
              lineStyle: SkeletonLineStyle(
                randomLength: false,
                height: 15,
                borderRadius: BorderRadius.circular(8),
                minLength: MediaQuery.of(context).size.width / 2,
              )),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    ),
  );
}

class _ViewProductPageState extends State<ViewProductPage> with Extra {
  final controller = PageController();
  late ProductModel product;
  late GeoFirePoint center;
  var dataStram;

  LatLng startLocation = const LatLng(7.500640, 9.061460);
  LatLng endLocation = const LatLng(7.500640, 9.061460);

  List<String> tex = ["Love", "sjke", "can do", "Fuck"];
  List<LatLng> polylineCoordinates = [];

  Future<StoreModel> getInfo({required String storeID}) async {
    StoreModel model;
    var a = await firestore.collection(STORES).doc(storeID).get();
    if (a.exists) {
      model = StoreModel.fromJson(a.data() as Map<String, dynamic>);

      return model;
    } else {
      return StoreModel();
    }
  }

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
                              itemId: widget.itemId,
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
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 10),
                            decoration: const BoxDecoration(
                                color: Color(0xff6BAEFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => PaymentHome(
                                            data: product,
                                            itemId: itemId,
                                            type: PAYMENT_TYPE.PRODUCT)));
                              },
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
                            ))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 110,
                                height: 130,
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
                                width: 120,
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
                  ],
                ),
              ),
            );
          }
          return _SingleLoading(context);
        });
  }

  @override
  void initState() {
    super.initState();
    product = widget.product;
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
    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: AppBars(context).BackAppBar(color: Colors.transparent),
      body: FutureBuilder(
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

              return SingleChildScrollView(
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(3, 3),
                            spreadRadius: 8,
                            blurRadius: 21,
                            color: Color.fromRGBO(230, 230, 230, 0.91),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: colorWhite),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                              (product.condition == ITEM_CONDITION.BRAND_NEW)
                                  ? "Brand New"
                                  : (product.condition ==
                                          ITEM_CONDITION.FAIRLY_USED)
                                      ? "Fairly Used"
                                      : "Used",
                              style: TextStyle(color: colorBlue),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.amber.shade600,
                                borderRadius: BorderRadius.circular(30)),
                            child: Icon(
                              Icons.star_rounded,
                              size: 20,
                              color: colorWhite,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 250,
                        child: PageView.builder(
                            controller: controller,
                            itemCount: product.gallery!.length,
                            itemBuilder: (a, index) {
                              print(index);
                              return Container(
                                margin:
                                    const EdgeInsets.only(left: 3, right: 3),
                                decoration: BoxDecoration(
                                    color: colorLightGray,
                                    borderRadius: BorderRadius.circular(10)),
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product.gallery![index].link!,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const SkeletonLine(
                                          style: SkeletonLineStyle(height: 240),
                                        );
                                      },
                                    )),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SmoothPageIndicator(
                        controller: controller,
                        count: product.gallery!.length,
                        effect: WormEffect(
                          dotHeight: 7,
                          dotColor: colorLightGray,
                          activeDotColor: colorBlue,
                          dotWidth: 7,
                          type: WormType.thin,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        product.name!,
                        style: TextStyle(
                            color: colorBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatAmount(product.price!.amount),
                            style: TextStyle(
                                color: colorLightBlue,
                                fontSize: 17,
                                fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => PaymentHome(
                                          data: product,
                                          itemId: widget.itemId,
                                          type: PAYMENT_TYPE.PRODUCT)));
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 20, right: 20),
                              decoration: BoxDecoration(
                                  color: colorLightBlue.withOpacity(.4),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(children: const [
                                Icon(
                                  Icons.shopping_cart,
                                  size: 16,
                                ),
                                Text(
                                  "Buy",
                                  style: TextStyle(fontSize: 16),
                                )
                              ]),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_pin,
                                    size: 15,
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
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                localRes.rows!.first.elements!.first.distance !=
                                        null
                                    ? "${totalDistance.roundToDouble().toInt()} Km away (${localRes.rows!.first.elements!.first.duration!.text})"
                                    : "No close route",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    product.sRatting.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 17,
                                    color: colorGray,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "( ${product.reviews ?? 'No'} Reviews )",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: colorLightBlue,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Text(
                          product.description!,
                          style: TextStyle(
                              color: colorGray,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                        future: getInfo(storeID: product.storeId!),
                        builder: (a, AsyncSnapshot<StoreModel?> b) {
                          StoreModel? store;
                          if (b.hasData) {
                            if (b.data!.name == null) {
                              return Container(
                                child: Text("No thjing here Fucer"),
                              );
                            } else {
                              store = b.data as StoreModel;

// CachedNetworkImage(
//   imageUrl: "http://via.placeholder.com/200x150",
//   imageBuilder: (context, imageProvider) => Container(
//     decoration: BoxDecoration(
//       image: DecorationImage(
//           image: imageProvider,
//           fit: BoxFit.cover,
//           colorFilter:
//               ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
//     ),
//   ),
//   placeholder: (context, url) => CircularProgressIndicator(),
//   errorWidget: (context, url, error) => Icon(Icons.error),
// ),

                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color(0xffE9F3FF),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ImageViews(context).ProfileImage(
                                          height: 50,
                                          width: 50,
                                          link: store.iamge),
                                      // ClipRRect(
                                      //     borderRadius:
                                      //         BorderRadius.circular(50),
                                      //     child: Image.network(
                                      //       "http://via.placeholder.com/200x150",
                                      //       width: 50,
                                      //       height: 50,
                                      //       fit: BoxFit.cover,
                                      //       loadingBuilder: (context, child,
                                      //           loadingProgress) {
                                      //         if (loadingProgress == null)
                                      //           return child;
                                      //         return const SkeletonLine(
                                      //           style: SkeletonLineStyle(
                                      //               height: 40),
                                      //         );
                                      //       },
                                      //     )),
                                      Expanded(
                                          child: Container(
                                        margin: EdgeInsets.only(left: 15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              store.name!,
                                              style: TextStyle(
                                                  color: colorBlue,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                                formatPhoneNumber(
                                                    phone: store.phone!),
                                                style: TextStyle(
                                                    color: colorGray,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16)),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              'Registered ${TimeClass().timeAgo((store.createdAt as Timestamp).toDate())}',
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            )
                                          ],
                                        ),
                                      )),
                                      Text(
                                        "View Seller",
                                        style: TextStyle(color: colorLightBlue),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ]),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ]),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(3, 3),
                              spreadRadius: 8,
                              blurRadius: 21,
                              color: Color.fromRGBO(230, 230, 230, 0.91),
                            )
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: colorWhite),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "  Similar Items to Consider",
                            style: TextStyle(
                                color: colorBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder(
                              stream: dataStram,
                              builder: (a,
                                  AsyncSnapshot<
                                          List<
                                              DocumentSnapshot<
                                                  Map<String, dynamic>>>>
                                      b) {
                                List<ProductModel> products = [];

                                if (b.connectionState ==
                                    ConnectionState.waiting) {
                                  return _SingleLoading(context);
                                }

                                if (b.connectionState ==
                                    ConnectionState.active) {
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
                                      products.add(ProductModel.fromJson(element
                                          .data() as Map<String, dynamic>));
                                    });
                                  }
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                                return ListView.builder(
                                    itemCount: products.length,
                                    shrinkWrap: true,
                                    itemBuilder: (a, index) {
                                      return SingleProduct(
                                          itemId: b.data![index].id,
                                          product: products[index]);
                                    });
                              }),
                        ],
                      )),
                  const SizedBox(
                    height: 30,
                  )
                ]),
              );
            }
            return _SingleLoading(context);
          }),
    );
  }
}
