import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Authentication/UserModel.dart';
import 'package:nutmeup/models/Store/OrdersModel.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';
import 'package:nutmeup/utilities/TimeAgo.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';
import 'package:nutmeup/widgets/Inputes/ImageView.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';
import 'package:nutmeup/widgets/messagesExtras.dart';

import '../../../utilities/utilities.dart';

class ViewOrderHomePage extends StatefulWidget {
  ViewOrderHomePage(
      {Key? key,
      required this.itemId,
      required this.itemModel,
      required this.userModel,
      required this.orderModel})
      : super(key: key);

  String itemId;
  var itemModel; // product model
  OrderModel orderModel;
  UserModel userModel;

  @override
  State<ViewOrderHomePage> createState() => _ViewOrderHomePageState();
}

class _ViewOrderHomePageState extends State<ViewOrderHomePage> with Extra {
  late String itemId;
  var itemModel; // product model
  late OrderModel orderModel;
  late UserModel userModel;
  bool hasDelivery = false;

  late ProductModel productModel;

  @override
  void initState() {
    super.initState();

    itemId = widget.itemId;
    itemModel = widget.itemModel;
    orderModel = widget.orderModel;
    userModel = widget.userModel;

    productModel = itemModel as ProductModel;
  }

  @override
  Widget build(BuildContext context) {
    print(userId);

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: AppBars(context).BackAppBar(
        color: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageViews(context).ProfileImage(
                      height: 40,
                      width: 40,
                      link: userModel.bioData!.profilePhoto),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${userModel.bioData!.name}",
                        style: TextStyle(
                            color: colorBlue,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            '${formatPhoneNumber(phone: userModel.bioData!.phone!)}  ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 13,
                                color: colorLightBlue,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.phone,
                            size: 16,
                            color: colorLightBlue,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        " ${userModel.bioData!.email!}",
                        style: TextStyle(
                            color: colorLightBlue,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffF4F9FF),
                        border: Border.all(width: 1, color: colorLightBlue),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 2,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "  Message  ",
                            style:
                                TextStyle(color: colorLightBlue, fontSize: 15),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(5)),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: Image.network(
                                  productModel.gallery!.first.link!,
                                  height: 150,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
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
                                "Used",
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
                              productModel.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: colorBlue),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     // Row(
                            //     //   mainAxisAlignment: MainAxisAlignment.center,
                            //     //   crossAxisAlignment: CrossAxisAlignment.center,
                            //     //   children: [
                            //     //     Text(
                            //     //       "3333",
                            //     //       textAlign: TextAlign.center,
                            //     //       style: TextStyle(
                            //     //           fontSize: 13,
                            //     //           color: colorGray,
                            //     //           fontWeight: FontWeight.w600),
                            //     //     ),
                            //     //     Icon(
                            //     //       Icons.star,
                            //     //       size: 16,
                            //     //       color: colorGray,
                            //     //     ),
                            //     //   ],
                            //     // ),

                            //     const SizedBox(
                            //       width: 20,
                            //     ),
                            //     Text(
                            //       "( Reviews )",
                            //       style: TextStyle(
                            //           fontSize: 13,
                            //           color: colorGray,
                            //           fontWeight: FontWeight.w600),
                            //     )
                            //   ],
                            // ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              "${formatAmount(productModel.price!.amount!)} ",
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        "Abuja Nigeria",
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
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "No close route",
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
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: colorRed.withOpacity(.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(children: const [
                            Icon(
                              Icons.cancel_outlined,
                              size: 18,
                              color: Color(0xff343434),
                            ),
                            Text(
                              "    Reject order   ",
                              style: TextStyle(color: Color(0xff343434)),
                            ),
                          ]),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(5)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order information",
                      style: TextStyle(
                          color: colorBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: colorLightGray,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    SummaryEntry(
                      title: "Created At",
                      value: TimeClass()
                          .timeAgo((orderModel.createAt as Timestamp).toDate()),
                    ),
                    SummaryEntry(
                      title: "Payment method",
                      value: orderModel.payment!.paymentType!,
                    ),
                    SummaryEntry(
                      title: "Payment status",
                      value: orderModel.payment!.paymentStatus!,
                    ),
                    SummaryEntry(
                      title: "Discount",
                      value: "NGN ${orderModel.discount}",
                    ),
                    SummaryEntry(
                      title: "Total paid",
                      value:
                          "NGN ${(orderModel.discount! + orderModel.amount!)}",
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: colorLightGray,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    SummaryEntry(
                      title: "Order status",
                      value: orderModel.status!,
                    ),
                    SummaryEntry(
                      title: "Delivery method",
                      value: "-",
                    ),
                    SummaryEntry(
                      title: "Delivery status",
                      value: "-",
                    ),
                  ]),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(5)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery",
                      style: TextStyle(
                          color: colorBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: colorLightGray,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    hasDelivery
                        ? Column(
                            children: [
                              SummaryEntry(
                                title: "Est. Del.",
                                value: TimeClass().timeAgo(
                                    (orderModel.createAt as Timestamp)
                                        .toDate()),
                              ),
                              SummaryEntry(
                                title: "Driver",
                                value: "Emmanuel Victor",
                              ),
                              SummaryEntry(
                                title: "Plate number",
                                value: orderModel.payment!.paymentStatus!,
                              ),
                              SummaryEntry(
                                title: "Vehicle",
                                value: "#33245 Toyota Camery",
                              ),
                              SummaryEntry(
                                  title: "Track",
                                  value: "In Transit ( See on Map )",
                                  isVoucher: true),
                            ],
                          )
                        : Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            child: Column(children: [
                              Text(
                                "No Delivery data",
                                style: TextStyle(
                                    color: colorBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              const Text(
                                "You can find delivery agents to deliver this order right here. Click on the button to get a delivery agant",
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 150,
                                child: CustomButton(
                                  onClick: () {},
                                  text: "Deliver Item",
                                ),
                              )
                            ]),
                          ),
                  ]),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      )),
    );
  }
}

SummaryEntry({required String title, required String value, isVoucher}) {
  bool _isVoucher = isVoucher ?? false;
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: TextStyle(
            color: colorGray, fontSize: 17, fontWeight: FontWeight.w500),
      ),
      Text(
        value,
        style: TextStyle(
            color: _isVoucher ? green : colorGray,
            fontSize: 15,
            fontWeight: FontWeight.w500),
      ),
    ]),
  );
}
