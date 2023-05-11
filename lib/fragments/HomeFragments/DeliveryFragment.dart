import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

import '../../pages/_Delivery/DeliveryMapPage.dart';
import '../../pages/_Delivery/SearchMapPage.dart';

class DeliveryFragment extends StatefulWidget {
  const DeliveryFragment({Key? key}) : super(key: key);

  @override
  State<DeliveryFragment> createState() => _DeliveryFragmentState();
}

class _DeliveryFragmentState extends State<DeliveryFragment> {
  var controller = ScrollController();
  SingleRepairOption(
      {required String image,
      required String text,
      required String title,
      showDivider,
      width,
      height}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchMapPage()));
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
            Container(
              margin: EdgeInsets.only(bottom: 15),
              color: colorLightGray,
              height: 1,
              width: double.infinity,
            ),
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  padding: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xffE4F0FF),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
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
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, color: colorBlue),
                    ),
                    Text(
                      text,
                      style: TextStyle(fontSize: 14, color: colorGray),
                    )
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      "Pickup and Delivery",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: colorBlue),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (builder) => MapSample()));
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/icons/find_agents.png",
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Find Available\nDelivery Agents",
                                    textAlign: TextAlign.center,
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
                                  "assets/images/icons/deliver_goods.png",
                                  height: 60,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Make Money\nDelivering Goods",
                                  textAlign: TextAlign.center,
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
                              "assets/images/icons/need_truck.png",
                              width: 60,
                              height: 60,
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
                                  "Do you need a tow truck instead? ",
                                  style: TextStyle(
                                      fontSize: 16, color: colorLightBlue),
                                ),
                                Text(
                                  "Find the closeset tow truck to pick\nup the affected vehicle",
                                  style:
                                      TextStyle(fontSize: 15, color: colorGray),
                                ),
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // ElevatedButton(onPressed: () {}, child: Text("hss")),
                        Text(
                          "Select the most suitable vehicle to pick up\nthe item(s) to be delievered",
                          style: TextStyle(
                              fontSize: 16,
                              color: colorBlue,
                              fontWeight: FontWeight.w600),
                        ),
                        SingleRepairOption(
                            title: "Motorcycle",
                            image: "assets/images/icons/clear_bike.png",
                            text:
                                "Ideal for light weight packages which can fit\ninto the delivery box at the back of a bike."),
                        SingleRepairOption(
                            title: "Car",
                            image: "assets/images/icons/clear_car.png",
                            text:
                                "Ideal for items that cannot fit into a motor\ncycle e.g a set of replacement tyres."),
                        SingleRepairOption(
                            title: "Mini Van",
                            image: "assets/images/icons/clear_mini_van.png",
                            text:
                                "Ideal for larger and bulky items such as\nwashing washine and bulk supply."),
                        SingleRepairOption(
                            title: "Truck",
                            image: "assets/images/icons/clear_truck.png",
                            text:
                                "Perfect for moving ernomous quantity of\nproducts, equipment, furniture, etc"),
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
