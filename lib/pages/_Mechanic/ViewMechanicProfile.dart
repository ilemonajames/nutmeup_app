import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nutmeup/constants/Constants.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/pages/HomePage.dart';
import 'package:nutmeup/pages/_Mechanic/CreateMechanicStore.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '../../constants/Colors.dart';

import '../../models/Mechanic/MechanicModel.dart';
import '../../models/Mechanic/ServiceModel.dart';
import '../../models/Requests/RequestModel1.dart';
import '../../utilities/modal.dart';
import '../../utilities/utilities.dart';

import '../../widgets/Navigators/BoxNavigator.dart';
import '../../widgets/messagesExtras.dart';

class ViewMechanicProfile extends StatefulWidget {
  ViewMechanicProfile(
      {Key? key,
      required this.distance,
      required this.item,
      required this.mech})
      : super(key: key);

  MechanicModel mech;
  String distance;
  RequestItem item;

  @override
  State<ViewMechanicProfile> createState() => _ViewMechanicProfileState();
}

class _ViewMechanicProfileState extends State<ViewMechanicProfile> with Extra {
  int selectTab = 0;
  bool serviceLoading = false;
  var serviceAmountController = TextEditingController();
  List<Map<String, dynamic>> selectedServices = [];
  List<String> selectedSpecializations = [];

  late MechanicModel mech;
  late String distance;
  late RequestItem item;

  SingleReview() {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  child: Image.network(
                    "https://www.genautoinc.com/wp-content/uploads/2021/02/Hire-a-professional-mechanic-in-maryland.jpg",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 17,
                      itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        size: 10,
                        color: colorLightBlue,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "John Fashola",
                      style: TextStyle(
                          color: colorBlue,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )
              ],
            ),
            Text(
              "26 Aug 2022",
              style: TextStyle(
                  color: colorGray, fontSize: 13, fontWeight: FontWeight.w500),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "He is a really great guy, I called him late at night, and he came through for me despite the skepticism about my request considering it was really late and a bit far from his location.",
          style: TextStyle(
              color: colorGray, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              "assets/images/icons/verifiedcar.png",
              width: 25,
              height: 25,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "2022 Lexus ES 350",
              style: TextStyle(
                  color: colorBlue, fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        )
      ]),
    );
  }

  @override
  void initState() {
    super.initState();

    mech = widget.mech;
    distance = widget.distance;
    item = widget.item;
    item.mechanic = mech;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars(context).BackAppBar(color: colorWhite),
        backgroundColor: backgroundGray,
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: colorWhite,
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(3),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.amber.shade800,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.star_rounded,
                        color: colorWhite,
                        size: 17,
                      ),
                    )
                  ],
                )

                // Profile image
                ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          child: Image.network(
                            mech.iamge!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mech.name!,
                              style: TextStyle(
                                color: colorGray,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Automobile Mechanic",
                              style: TextStyle(
                                  color: colorBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              distance,
                              style: TextStyle(
                                color: colorGray,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "${mech.sProducts}",
                          style: TextStyle(
                              color: colorBlue,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Icon(
                          Icons.handyman_outlined,
                          color: colorBlue,
                          size: 15,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "4.8",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: colorLightBlue,
                                      fontWeight: FontWeight.w700),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: colorLightBlue,
                                ),
                              ],
                            ),
                            Text(
                              "(102 Reviews)",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: colorLightBlue,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        Text(
                          "Registered 6 months Ago",
                          style: TextStyle(
                            color: colorGray,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        item.workerId = mech.storeId;
                        item.clientId = userId;

                        var upload = await FirebaseFirestore.instance
                            .collection(CUSTOMERS)
                            .add(item.toJson());

                        showMessageDialog(context, title: "Booking Completed",
                            onProceed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (a) => const HomePage()),
                              (route) => false);
                        },
                            message:
                                "Order booking with ID ${upload.id} was placed successfully. Thank you.");
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: colorLightBlue.withOpacity(.6),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: colorBlack,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              " Book ",
                              style: TextStyle(
                                  color: colorBlack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
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
                BoxNavigator(
                  hasShadow: false,
                  onChange: (selected) {
                    setState(() {
                      selectTab = selected;
                    });
                  },
                  namesList: const ["About", "Specialization", "Reviews"],
                ),
                Visibility(
                  maintainState: true,
                  visible: selectTab == 1,
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Expertise",
                            style: TextStyle(
                                color: colorBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          (mech.specailization!.length! == 0)
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text("Nothing added here yet!"),
                                )
                              : ListView(
                                  primary: true,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                      Wrap(
                                        spacing: 4.0,
                                        runSpacing: 0.0,
                                        children: List<Widget>.generate(
                                            mech.specailization!
                                                .length, // place the length of the array here
                                            (int index) {
                                          return Chip(
                                              backgroundColor: colorLightBlue
                                                  .withOpacity(.1),
                                              label: Text(
                                                mech.specailization![index],
                                              ));
                                        }).toList(),
                                      ),
                                    ]),

                          /// Manufacturer Section

                          Text(
                            "Maufacturers",
                            style: TextStyle(
                                color: colorBlue,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          (mech.specailization!.length == 0)
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text("Nothing added here yet!"),
                                )
                              : ListView(
                                  primary: true,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                      Wrap(
                                        spacing: 4.0,
                                        runSpacing: 0.0,
                                        children: List<Widget>.generate(
                                            mech.specailization!
                                                .length, // place the length of the array here
                                            (int index) {
                                          return Chip(
                                              backgroundColor: colorLightBlue
                                                  .withOpacity(.1),
                                              label: Text(
                                                mech.specailization![index],
                                              ));
                                        }).toList(),
                                      ),
                                    ]),
                        ]),
                  ),
                ),
                //
                Visibility(
                    maintainState: true,
                    visible: selectTab == 2,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Reviews (${mech.sRating})",
                              style: TextStyle(
                                  color: colorBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              color: colorGray.withOpacity(.2),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // SingleReview(),
                          ]),
                    )),
                Visibility(
                    maintainState: true,
                    visible: selectTab == 0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Automobile Mechanic",
                              style: TextStyle(
                                  color: colorBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              mech.address!,
                              style: TextStyle(
                                  color: colorGray,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Bio",
                              style: TextStyle(
                                  color: colorBlue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              mech.bioData!,
                              style: TextStyle(
                                  color: colorGray,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    )),
              ]),
            ),
            Container(
              decoration: BoxDecoration(color: colorWhite),
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service Charge",
                    style: TextStyle(
                        fontSize: 16,
                        color: colorBlue,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    color: colorGray.withOpacity(.2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  (selectedServices.isEmpty)
                      ? Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Nothing here yet!!",
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: selectedServices.length,
                          itemBuilder: (a, b) {
                            ServiceModel serviceModel =
                                ServiceModel.fromJson(selectedServices[b]);
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          serviceModel.title!,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: colorGray,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Starting at",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: colorGray,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                formatAmount(
                                                    serviceModel.amount),
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: colorLightBlue,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 1,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    color: colorGray.withOpacity(.2),
                                  )
                                ],
                              ),
                            );
                          }),
                ],
              ),
            )
          ]),
        ));
  }
}
