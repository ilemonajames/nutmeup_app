import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Requests/RequestModel1.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';

import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '../../constants/Constants.dart';
import '../../models/Vehicle/VehicleModel.dart';
import '../../widgets/messagesExtras.dart';
import '../_Repair/PickProplem.dart';
import 'createCar.dart';

class ListAllCars extends StatefulWidget {
  ListAllCars({Key? key, this.model, required this.item}) : super(key: key);
  var model;

  RequestItem item;

  @override
  State<ListAllCars> createState() => _ListAllCarsState();
}

class _ListAllCarsState extends State<ListAllCars> with Extra {
  VehicleModel? selectedVehicle;
  bool _isLoading = false;

  SinglePageOption({required String title, required bool isBold}) {
    return Expanded(
        child: Container(
      height: 25,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(7))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 15,
                  fontWeight: isBold ? FontWeight.w700 : FontWeight.w400),
            )
          ]),
    ));
  }

  SingleVehicle({required VehicleModel model}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVehicle = model;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: colorLightGray))),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/icons/filled_car.png",
                height: 17,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.title!,
                        style: TextStyle(
                            fontSize: 16,
                            color: colorBlue,
                            fontWeight: FontWeight.w700),
                      ),
                      selectedVehicle == null
                          ? Icon(
                              Icons.radio_button_off,
                              color: colorBlue,
                            )
                          : selectedVehicle!.vehicleId == model.vehicleId
                              ? Icon(
                                  Icons.radio_button_checked,
                                  color: colorBlue,
                                )
                              : Icon(
                                  Icons.radio_button_off,
                                  color: colorBlue,
                                ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SinglePageOption(
                        title: model.manufacturer!,
                        isBold: false,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SinglePageOption(
                        title: model.year!,
                        isBold: false,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: [
                      SinglePageOption(
                        title: model.gear!,
                        isBold: true,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SinglePageOption(
                        title: model.config!,
                        isBold: true,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (builder) => CreateNewCar()));
                  //       },
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         padding: const EdgeInsets.all(5),
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xffE4F0FF),
                  //           border: Border.all(width: 1, color: colorLightBlue),
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(5)),
                  //         ),
                  //         child: Text(
                  //           "Add New",
                  //           style: TextStyle(
                  //               fontSize: 15,
                  //               color: colorLightBlue,
                  //               fontWeight: FontWeight.w300),
                  //         ),
                  //       ),
                  //     )),
                  //     SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //         child: GestureDetector(
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (builder) => CreateNewCar(
                  //                       model: model,
                  //                     )));
                  //       },
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         padding: const EdgeInsets.all(5),
                  //         decoration: BoxDecoration(
                  //           color: const Color(0xffE4F0FF),
                  //           border: Border.all(width: 1, color: colorLightBlue),
                  //           borderRadius:
                  //               const BorderRadius.all(Radius.circular(5)),
                  //         ),
                  //         child: Text(
                  //           "Edit Vehicle",
                  //           style: TextStyle(
                  //               fontSize: 15,
                  //               color: colorLightBlue,
                  //               fontWeight: FontWeight.w300),
                  //         ),
                  //       ),
                  //     ))
                  //   ],
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ))
            ]),
      ),
    );
  }

  late RequestItem item;
  @override
  void initState() {
    super.initState();

    item = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: AppBars(context).BackAppBar(color: colorWhite),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Answer a Few Questions To Get The Best Mechanic For Your Need",
                style: TextStyle(
                    color: colorBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colorLightGray)),
              child: Container(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Which car would you like to schedule for a repair or routine maintenence for?",
                    style: TextStyle(
                        color: colorGray,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),

                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorLightGray)),
                    child: StreamBuilder(
                        stream: firestore
                            .collection(VEHICLES)
                            .where("createdBy", isEqualTo: userId)
                            .where("status", isEqualTo: "ACTIVE")
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot?> b) {
                          if (b.hasData) {
                            if (b.data!.docs!.length == 0) {
                              return EmptyMessage(
                                  message: "Create New",
                                  onClick: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                CreateNewCar())));
                                  },
                                  title: DefaultMessages()
                                      .emptyMessage(about: "Vehicle"));
                            }

                            List<VehicleModel> myCars = [];
                            b.data!.docs.forEach((element) {
                              VehicleModel singleModel = VehicleModel.fromJson(
                                  element.data() as Map<String, dynamic>);
                              myCars.add(singleModel);
                            });

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: myCars.length,
                                itemBuilder: (a, b) {
                                  return SingleVehicle(model: myCars[b]);
                                });
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                        }),
                  )

                  //createCar(model: widget.model)
                ],
              )),
            ),
            CustomButton(
              text: "Next",
              margin: const EdgeInsets.all(10),
              loading: _isLoading,
              onClick: () async {
                if (selectedVehicle == null) {
                  Alart(message: "No selction made", isError: true);
                } else {
                  item.car = selectedVehicle!;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PickProblemPage(item: item)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
