import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Authentication/UserModel.dart';
import 'package:nutmeup/models/Store/OrdersModel.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';
import 'package:nutmeup/utilities/TimeAgo.dart';
import 'package:nutmeup/widgets/Navigators/BoxNavigator.dart';

import '../../../utilities/utilities.dart';
import '../../../widgets/Product/Products.dart';
import 'ViewOrderPage.dart';

class OrdersHomePage extends StatefulWidget {
  const OrdersHomePage({Key? key}) : super(key: key);

  @override
  State<OrdersHomePage> createState() => _OrdersHomePageState();
}

class _OrdersHomePageState extends State<OrdersHomePage> with Extra {
  var orderRef;
  var customerRef;
  var invoicesRef;
  var transactionRef;

  var selected = 0;

  SingleProduct({required OrderModel model}) {
    late UserModel __userModel;
    ProductModel __productModel;

    return FutureBuilder(
        future: firestore.collection(PRODUCTS).doc(model.itemId!).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> res) {
          if (res.hasData) {
            ProductModel _products =
                ProductModel.fromJson(res.data!.data() as Map<String, dynamic>);

            __productModel = _products;

            return GestureDetector(
              onTap: () {},
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
                                width: 110,
                                height: 130,
                                padding: const EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVauj89LA2V9W7QNqqqXZU3Pwq3ZFZat-Z4A&usqp=CAU",
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewOrderHomePage(
                                                itemId: model.itemId!,
                                                userModel: __userModel,
                                                itemModel:
                                                    __productModel, // product
                                                orderModel: model, // order
                                              )));
                                },
                                child: Container(
                                  width: 130,
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffE4F0FF),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    "Preview Order",
                                    style: TextStyle(color: colorBlue),
                                  ),
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
                                _products.name!,
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
                              FutureBuilder(
                                  future: firestore
                                      .collection(USERS)
                                      .doc(model.customerId)
                                      .get(),
                                  builder:
                                      (a, AsyncSnapshot<DocumentSnapshot> b) {
                                    if (b.hasData) {
                                      UserModel userModel = UserModel.fromJson(
                                          b.data!.data()
                                              as Map<String, dynamic>);

                                      __userModel = userModel;
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${TimeClass().timeAgo((model.createAt as Timestamp).toDate())}   ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: colorGray,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Icon(
                                                Icons.link_sharp,
                                                size: 16,
                                                color: colorGray,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            userModel.bioData!.name!,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: colorGray,
                                                fontWeight: FontWeight.w600),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Text("fetching customer..");
                                    }
                                  }),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "${formatAmount(3344)} ",
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
                                          "Adeleke Usma",
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
                            decoration: const BoxDecoration(
                                color: Color(0xff6BAEFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Row(children: const [
                              Icon(
                                Icons.phone,
                                size: 18,
                                color: Color(0xff343434),
                              ),
                              Text(
                                "    Contact   ",
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
    super.initState();

    orderRef =
        firestore.collection(ORDERS).where("storeId", isEqualTo: userId).get();

    customerRef = firestore
        .collection(CUSTOMERS)
        .where("storeId", isEqualTo: userId)
        .get();

    invoicesRef = firestore
        .collection(INVOICES)
        .where("storeId", isEqualTo: userId)
        .get();

    transactionRef = firestore
        .collection(TRANSACTIONS)
        .where("storeId", isEqualTo: userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    print(userId);

    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                child: Icon(
              Icons.arrow_back,
              color: colorBlack,
            ))),
        title: const Text(
          "Orders",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: colorBlue,
            ),
            onSelected: (newValue) {
              // add this property
              setState(() {
                //_value = newValue; // it gives the value which is selected
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                child: Text("Create Invoice"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text("Report a customer"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Edit Store"),
                value: 2,
              ),
            ],
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Wallet Balance",
                            style: TextStyle(
                                color: colorBlue,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${formatAmount(2000)} ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: colorLightBlue),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '34.3 ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: colorLightBlue,
                                    fontWeight: FontWeight.w600),
                              ),
                              Icon(
                                Icons.star,
                                size: 16,
                                color: colorLightBlue,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "( 0 Reviews )",
                            style: TextStyle(
                                fontSize: 13,
                                color: colorGray,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "See All Reviews",
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
                            "  Withdraw   ",
                            style:
                                TextStyle(color: colorLightBlue, fontSize: 15),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            BoxNavigator(
              onChange: (index) {
                setState(() {
                  selected = index;
                });
              },
              namesList: const [
                "Orders",
                "Customers",
                "Invoices",
                "Transactions"
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            FutureBuilder(
                future: selected == 0 ? orderRef : null,
                builder: (a, AsyncSnapshot<QuerySnapshot> b) {
                  if (b.hasData) {
                    if (selected == 0) {
                      // print(b.error);
                      List<OrderModel> models = [];

                      b.data!.docs.forEach((element) {
                        OrderModel model = OrderModel.fromJson(
                            element.data() as Map<String, dynamic>);
                        models.add(model);
                      });

                      if (models.isEmpty) {
                        return Container(
                          height: 300,
                          alignment: Alignment.center,
                          child: const Text("Nothing here yet!!"),
                        );
                      }

                      return ListView.builder(
                          itemCount: models.length,
                          shrinkWrap: true,
                          itemBuilder: (a, index) {
                            return SingleProduct(model: models[index]);
                          });
                    } else {
                      return Text("Loads");
                    }
                  } else {
                    return SingleLoading(context);
                  }
                }),
          ],
        ),
      )),
    );
  }
}
