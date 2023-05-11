import 'package:flutter/material.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/models/Requests/RequestModel1.dart';
import 'package:nutmeup/pages/_Mechanic/FindAMechanic.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:provider/provider.dart';

import '../../pages/_Delivery/DeliveryMapPage.dart';
import '../../providers/UsersProvider.dart';

class RepairFragment extends StatefulWidget {
  const RepairFragment({Key? key}) : super(key: key);

  @override
  State<RepairFragment> createState() => _RepairFragmentState();
}

class _RepairFragmentState extends State<RepairFragment> {
  var controller = ScrollController();
  SingleRepairOption(
      {required String image,
      required REPAIR_CLASS repair_class,
      required String text,
      width,
      height}) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => FindAMechanic(
        //               repair_class: repair_class,
        //             )));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => MapSample(
                      repair_class: repair_class,
                    )));
      },
      child: Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);

    return SingleChildScrollView(
      controller: controller,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: backgroundGray,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Hello ${user.userModel!.bioData!.name},",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: colorBlue),
                    ),
                    Text(
                      "What do you need?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: colorBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          color: colorWhite,
                          height: 190,
                          child: GestureDetector(
                            onTap: () {
                              RequestItem item = RequestItem();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FindAMechanic(
                                            item: item,
                                          )));
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons/search_mechanic.png",
                                    height: 70,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Find a Mechanic",
                                    style: TextStyle(fontSize: 17),
                                  )
                                ]),
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                          color: colorWhite,
                          height: 190,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/icons/iam_a_mechanic.png",
                                  height: 70,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "I am a Mechanic",
                                  style: TextStyle(fontSize: 17),
                                )
                              ]),
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 120,
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              "assets/images/icons/message_icon.png",
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Don’t know what is wrong with\nyour vehicle?",
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  "Contact a representative",
                                  style: TextStyle(
                                      fontSize: 16, color: colorLightBlue),
                                )
                              ],
                            ))
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(children: [
                        SingleRepairOption(
                            repair_class: REPAIR_CLASS.FIND_TOW_TRUCK,
                            image: "assets/images/icons/find_a_truck.png",
                            text: "Find nearby tow truck"),
                        SingleRepairOption(
                            repair_class: REPAIR_CLASS.CAR_NOT_STARTING,
                            image: "assets/images/icons/car_not_starting.png",
                            text: "Car is not starting inspection"),
                        SingleRepairOption(
                            repair_class: REPAIR_CLASS.CHANGE_OIL,
                            height: 9.0,
                            image: "assets/images/icons/change_oil.png",
                            text: "Change oil and filter"),
                        SingleRepairOption(
                            repair_class: REPAIR_CLASS.BRAKE_PADS_REPLACEMENT,
                            image: "assets/images/icons/break_pads.png",
                            text: "Brake pads replacement"),
                        SingleRepairOption(
                            repair_class: REPAIR_CLASS.CAR_INSPECTION,
                            image: "assets/images/icons/inspection.png",
                            text: "Pre-purchase car inspection"),
                        SingleRepairOption(
                            repair_class: REPAIR_CLASS.OVER_HEATING,
                            image: "assets/images/icons/over_heating.png",
                            text: "Over heating engine"),
                        const SizedBox(
                          height: 10,
                        )
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ]),
    );
  }
}
