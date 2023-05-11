import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:nutmeup/Api/PaymentApi.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Authentication/UserModel.dart';
import 'package:nutmeup/models/Store/OrdersModel.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';
import 'package:nutmeup/providers/UsersProvider.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';
import 'package:provider/provider.dart';

import '../../models/Payment/ReferenceModel.dart';
import '../../utilities/Enums.dart';
import '../_Last/Operationdone.dart';

class PaymentHome extends StatefulWidget {
  PaymentHome(
      {Key? key, required this.type, required this.data, required this.itemId})
      : super(key: key);

  PAYMENT_TYPE type;
  var data;
  String itemId;

  @override
  State<PaymentHome> createState() => _PaymentHomeState();
}

enum PAYMENT_METHODS {
  TRANSFER,
  CASH_ON_DELVERY,
  CASH_ON_PICK_UP,
  DEFAUALT_CARD,
  ENAIRAPAYMENT
}

class _PaymentHomeState extends State<PaymentHome> with Extra {
  String groupName = "groupValue";
  PAYMENT_METHODS selected = PAYMENT_METHODS.TRANSFER;
  late String itemId;

  ToggleRow({
    required PAYMENT_METHODS value,
    required String text,
  }) {
    return Container(
      height: 30,
      child: Row(
        children: [
          Radio(
              value: value,
              groupValue: selected,
              onChanged: (s) {
                setState(() {
                  selected = value;
                });
              }),
          Text(
            text,
            style: TextStyle(
                color: colorGray, fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  HedersContainr({required String title, required String image}) {
    return Container(
      child: Row(children: [
        Image.asset(
          image,
          width: 20,
          height: 20,
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(
              color: colorBlue, fontWeight: FontWeight.w600, fontSize: 16),
        )
      ]),
    );
  }

  late ProductModel productModel;
  late double amount;
  late double discount = 0;
  final plugin = PaystackPlugin();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    itemId = widget.itemId;
    plugin.initialize(
        publicKey: "sk_test_a73f6c885f6684ce06141e142aafbf5910f2793f");
    if (widget.type == PAYMENT_TYPE.PRODUCT) {
      productModel = widget.data as ProductModel;
      amount = productModel.price!.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user =
        Provider.of<UserProvider>(context, listen: false).userModel;
    return Scaffold(
        backgroundColor: backgroundGray,
        appBar: AppBars(context).BackAppBar(color: Colors.transparent),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(5)),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                          color: colorBlue,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 1,
                      color: colorLightGray,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HedersContainr(
                            title: "Discounts and Promo",
                            image: "assets/images/icons/discount.png"),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Redeem voucher",
                                style: TextStyle(
                                    color: colorGray,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                child: TextField(
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: colorGray,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                      hintText: "Enter promo code",
                                      enabledBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none),
                                  controller: TextEditingController(),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      color: colorLightGray,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HedersContainr(
                            title: "Select Payment Method",
                            image: "assets/images/icons/wallet.png"),
                        Container(
                          margin: EdgeInsets.only(left: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              ToggleRow(
                                value: PAYMENT_METHODS.TRANSFER,
                                text: "Bank transfer",
                              ),
                              ToggleRow(
                                value: PAYMENT_METHODS.CASH_ON_PICK_UP,
                                text: "Cash on pick-up",
                              ),
                              ToggleRow(
                                value: PAYMENT_METHODS.CASH_ON_DELVERY,
                                text: "Cash on delivery",
                              ),
                              ToggleRow(
                                value: PAYMENT_METHODS.DEFAUALT_CARD,
                                text: "Card Payment",
                              ),
                              ToggleRow(
                                value: PAYMENT_METHODS.ENAIRAPAYMENT,
                                text: "E-Naira",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 1,
                      color: colorLightGray,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 15, bottom: 10),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HedersContainr(
                            title: "Bill Summary",
                            image: "assets/images/icons/summary.png"),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              SummaryEntry(
                                title: "Sub total",
                                value: (widget.type == PAYMENT_TYPE.PRODUCT)
                                    ? productModel.price!.amount
                                    : 0,
                              ),
                              SummaryEntry(
                                title: "Service fee",
                                value: 100,
                              ),
                              SummaryEntry(
                                title: "Voucher discount",
                                isVoucher: true,
                                value: discount,
                              ),
                              Container(
                                height: 1,
                                color: colorLightGray,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 5, bottom: 1),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10, top: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                            color: colorGray,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        formatAmount((amount + 100) - discount),
                                        style: TextStyle(
                                            color: colorLightBlue,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ]),
                              ),
                              Container(
                                height: 1,
                                color: colorLightGray,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(top: 1, bottom: 1),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ]),
            ),
            CustomButton(
              onClick: () async {
                String paymentId = uuid.v4();
                String paymentStatus = "PENDING";
                setState(() {
                  isLoading = true;
                });

                if (selected == PAYMENT_METHODS.DEFAUALT_CARD) {
                  References transactionRef = await PaymentApi()
                      .fetchAccessCodeFrmServer(user!.bioData!.email!,
                          "${((amount + 100) - discount) * 100}");

                  if (transactionRef.authorization_url.isNotEmpty) {
                    Charge charge = Charge()
                      ..amount = (((amount + 100) - discount) * 100).toInt()
                      ..accessCode = transactionRef.access_code
                      ..email = user!.bioData!.email;
                    CheckoutResponse response = await plugin.checkout(
                      context,
                      fullscreen: true,
                      method: CheckoutMethod.selectable,
                      charge: charge,
                    );

                    if (response.status == true) {
                      Map verifyTransaction = await PaymentApi()
                          .verifyTransaction(response.reference.toString());
                      print(verifyTransaction);

                      if (!verifyTransaction['status']) {
                        setState(() {
                          isLoading = false;
                          paymentStatus = "COMPLETED";
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Lastpage(
                                      status: STATUS.FAILED,
                                    )));
                        return;
                      }

                      String customerCode = verifyTransaction["data"]
                          ["customer"]["customer_code"];
                      String customerId = verifyTransaction["data"]["customer"]
                              ["id"]
                          .toString();
                    } else {
                      setState(() {
                        isLoading = false;
                        paymentStatus = "FAILED";
                      });

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Lastpage(
                                    status: STATUS.FAILED,
                                  )));
                      return;
                    }
                  }
                }

                try {
                  print("here");
                  OrderModel orderModel = OrderModel(
                      createAt: FieldValue.serverTimestamp(),
                      orderType: widget.type.name,
                      customerId: user!.userId,
                      itemId: widget.itemId,
                      storeId: (widget.type == PAYMENT_TYPE.PRODUCT)
                          ? productModel.storeId
                          : "",
                      payment: Payment(
                          paymentId: paymentId,
                          paymentType: selected.name,
                          paymentStatus: paymentStatus),
                      amount: amount,
                      charge: 100,
                      discount: discount,
                      status: "PENDING");

                  await firestore
                      .collection(ORDERS)
                      .doc(paymentId)
                      .set(orderModel.toJson());

                  bool _checkEverything =
                      await checkEverything({"amount": amount});

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Lastpage(
                                status: STATUS.SUCCESS,
                              )));
                } on Exception catch (e) {
                  print("something went wrong");
                }
              },
              text: "Proceed",
              loading: isLoading,
              margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
            )
          ],
        )));
  }

  SummaryEntry({required String title, required double value, isVoucher}) {
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
          (_isVoucher ? "- " : "") + formatAmount(value),
          style: TextStyle(
              color: _isVoucher ? green : colorGray,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
      ]),
    );
  }

  Future<dynamic> checkEverything(Map<String, double> map) async {
    return true;
  }
}
