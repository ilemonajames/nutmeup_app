import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:nutmeup/constants/Constants.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Mechanic/MechanicModel.dart';
import 'package:nutmeup/models/Mechanic/ServiceModel.dart';
import 'package:nutmeup/pages/_Mechanic/CreateMechanicStore.dart';
import 'package:nutmeup/pages/_Mechanic/Specializations.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Inputes/IconEditText.dart';
import 'package:nutmeup/widgets/messagesExtras.dart';

import '../../constants/Colors.dart';
import '../../pages/_Stores/CreateShopPage.dart';
import '../../pages/_Stores/EditStorePage.dart';
import '../../widgets/Buttons/Button.dart';

import '../../widgets/Navigators/BoxNavigator.dart';

class MachanicProfileFragment extends StatefulWidget {
  const MachanicProfileFragment({Key? key}) : super(key: key);

  @override
  State<MachanicProfileFragment> createState() =>
      _MachanicProfileFragmentState();
}

class _MachanicProfileFragmentState extends State<MachanicProfileFragment>
    with Extra {
  int selectedButton = 0;
  bool serviceLoading = false;
  var _radioValue1 = 1;
  var _gender = "Male";
  var serviceAmountController = TextEditingController();

  var selectedService;
  List<Map<String, dynamic>> selectedServices = [];
  List<String> selectedSpecializations = [];

  updateType(SERVICE_TYPE types) async {
    await firestore
        .collection(MECHANICS)
        .doc(userId)
        .update({"storeType": types.index});
    Alart(message: "Updated", isError: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: StreamBuilder(
          stream: firestore.collection(MECHANICS).doc(userId).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot?> b) {
            if (b.hasData) {
              if (!b.data!.exists) {
                return EmptyMessage(
                    message: "Create store front",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CreateMechanic())));
                    },
                    title: DefaultMessages()
                        .emptyMessage(about: "Mechanic Store"));
              }

              MechanicModel model = MechanicModel.fromJson(
                  b.data!.data() as Map<String, dynamic>);

              selectedServices = [];
              model.services!.forEach((element) {
                selectedServices.add(element.toJson());
              });

              _radioValue1 = model.storeType ?? 0;

              return Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mecahnic Score",
                                  style: TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${model.sRating} ',
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
                                  border: Border.all(
                                      width: 1, color: colorLightBlue),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(7))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Image.asset(
                                      "assets/images/icons/history_tab.png",
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "  Repair History  ",
                                      style: TextStyle(
                                          color: colorLightBlue, fontSize: 15),
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: colorLightGray,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Workshop",
                                  style: TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300,
                                  child: Text(
                                    model!.location!.name!,
                                    maxLines: 3,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: colorGray),
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                int? selectedAction =
                                    await BottomSheetOptionSelector(
                                  context,
                                  options: [
                                    "Mech. Profile image",
                                    "Contact number",
                                    "Location",
                                    "Bio. Data info. "
                                  ],
                                  title:
                                      "What would you like to edit about your profile",
                                );

                                if (selectedAction == null) {
                                  Alart(
                                      message: "Nothing selected",
                                      isError: true);
                                  return;
                                }

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditStorePage(
                                            createOrEdit: CREATE_OR_EDIT.EDIT,
                                            infoToEdit: selectedAction == 0
                                                ? INFORMATION_TO_EDIT.IMAGE
                                                : selectedAction == 1
                                                    ? INFORMATION_TO_EDIT.PHONE
                                                    : selectedAction == 2
                                                        ? INFORMATION_TO_EDIT
                                                            .ADDRES
                                                        : INFORMATION_TO_EDIT
                                                            .BIO)));
                              },
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/icons/edit.png",
                                    width: 20,
                                    height: 20,
                                  ),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: colorGray,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: colorLightGray,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bio",
                                  style: TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 50,
                                  child: Text(
                                    model.bioData!,
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: colorGray),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Service Type",
                                  style: TextStyle(
                                      color: colorBlue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                          value: 0,
                                          groupValue: _radioValue1,
                                          onChanged: (int? value) {
                                            setState(() {
                                              if (value != null) {
                                                _radioValue1 = value;
                                                _gender = "Workshop ";

                                                updateType(
                                                    SERVICE_TYPE.WORKSHOP);
                                              }
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Workshop ',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: 1,
                                          groupValue: _radioValue1,
                                          onChanged: (int? value) => {
                                            setState(() {
                                              if (value != null) {
                                                _radioValue1 = value;
                                                _gender = "Mobile";
                                                updateType(SERVICE_TYPE.MOBILE);
                                              }
                                            })
                                          },
                                        ),
                                        const Text(
                                          'Mobile',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                          value: 2,
                                          groupValue: _radioValue1,
                                          onChanged: (int? value) {
                                            setState(() {
                                              if (value != null) {
                                                _radioValue1 = value;
                                                _gender = "Hybrid Mechanic";
                                                updateType(SERVICE_TYPE.HYBRID);
                                              }
                                            });
                                          },
                                        ),
                                        const Text(
                                          'Hybrid Mech.',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: colorLightGray,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Specialization",
                              style: TextStyle(
                                  color: colorBlue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            (model.specailization!.length! == 0)
                                ? Container()
                                : ListView(
                                    primary: true,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: <Widget>[
                                        Wrap(
                                          spacing: 4.0,
                                          runSpacing: 0.0,
                                          children: List<Widget>.generate(
                                              model.specailization!
                                                  .length, // place the length of the array here
                                              (int index) {
                                            return Chip(
                                                backgroundColor: colorLightBlue
                                                    .withOpacity(.1),
                                                label: Text(
                                                  model.specailization![index],
                                                ));
                                          }).toList(),
                                        ),
                                      ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "See All",
                                  style: TextStyle(
                                      color: colorLightBlue,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                SpecializationPage(
                                                  selected:
                                                      model.specailization!,
                                                )));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF4F9FF),
                                        border: Border.all(
                                            width: 1, color: colorLightBlue),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7))),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "   Add New     ",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: colorLightBlue,
                                                fontSize: 15),
                                          )
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: colorLightGray,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Service Charge",
                              style: TextStyle(
                                  color: colorBlue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "List the services that you offer and include an average\ncost. Mechanics who add a list of quotation tend to get\nrepair request more often",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: colorGray),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ExpandablePanel(
                              theme: ExpandableThemeData(hasIcon: false),
                              header: Container(
                                padding: const EdgeInsets.all(15),
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: const BoxDecoration(
                                    color: Color(0xffF4F9FF),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "See All Listed Services",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: colorBlue, fontSize: 15),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 16,
                                        color: colorBlue,
                                      )
                                    ]),
                              ),
                              collapsed: Container(),
                              expanded: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: (selectedServices.isEmpty)
                                      ? Container(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: const [
                                              Text(
                                                "No Services yet!",
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
                                                ServiceModel.fromJson(
                                                    selectedServices[b]);
                                            return Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          serviceModel.title!,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: colorGray,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Text(
                                                                "Starting at",
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color:
                                                                        colorGray,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              Text(
                                                                formatAmount(
                                                                    serviceModel
                                                                        .amount),
                                                                maxLines: 1,
                                                                style: TextStyle(
                                                                    color:
                                                                        colorLightBlue,
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              selectedServices
                                                                  .removeAt(b);

                                                              await firestore
                                                                  .collection(
                                                                      MECHANICS)
                                                                  .doc(userId)
                                                                  .set(
                                                                      {
                                                                    'services':
                                                                        selectedServices
                                                                  },
                                                                      SetOptions(
                                                                          merge:
                                                                              true));

                                                              setState(() {
                                                                selectedService =
                                                                    null;
                                                                serviceAmountController
                                                                    .text = "";
                                                                serviceLoading =
                                                                    false;
                                                                Alart(
                                                                    message:
                                                                        "Record Removed!!",
                                                                    isError:
                                                                        false);
                                                              });
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: Icon(
                                                                Icons
                                                                    .cancel_outlined,
                                                                color: colorGray
                                                                    .withOpacity(
                                                                        .5),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 1,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 10),
                                                    color: colorGray
                                                        .withOpacity(.2),
                                                  )
                                                ],
                                              ),
                                            );
                                          })),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                  color: Color(0xffF4F9FF),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Add a New Service",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: colorBlue, fontSize: 15),
                                        ),
                                        Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                          size: 16,
                                          color: colorBlue,
                                        )
                                      ]),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        color: colorWhite,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        border: Border.all(
                                            width: 1, color: colorLightGray)),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: Container(),
                                      hint: Text(selectedService ??
                                          "Select a service"),
                                      icon: RotatedBox(
                                        quarterTurns: 45,
                                        child: Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: colorBlue,
                                          size: 15,
                                        ),
                                      ),
                                      items: <String>[
                                        'General Servicing',
                                        'Diagnostics',
                                        'Suspension Repair',
                                        'Oxegen Sensor Replacement',
                                        'Wheels Alignment',
                                        'Transmission Issues',
                                        'Break Pad work'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedService = value;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Add a New Service",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: colorBlue, fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  IconEditText(
                                    controller: serviceAmountController,
                                    hint: "Estimated cost of service",
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomButton(
                                    onClick: () async {
                                      if (selectedService == null) {
                                        Alart(
                                            message: "Please select Service",
                                            isError: true);
                                        return;
                                      }

                                      if (serviceAmountController
                                          .text.isEmpty) {
                                        Alart(
                                            message: "Please enter amount",
                                            isError: true);
                                        return;
                                      }

                                      setState(() {
                                        serviceLoading = true;
                                      });
                                      String service_id = uuid.v4();

                                      ServiceModel model = ServiceModel(
                                        serviceId: service_id,
                                        title: selectedService,
                                        isNegotiable: false,
                                        amount: int.parse(
                                            serviceAmountController.text
                                                .trim()),
                                      );

                                      selectedServices.add(model.toJson());

                                      await firestore
                                          .collection(MECHANICS)
                                          .doc(userId)
                                          .set({'services': selectedServices},
                                              SetOptions(merge: true));

                                      setState(() {
                                        selectedService = null;
                                        serviceAmountController..text = "";
                                        serviceLoading = false;
                                        Alart(
                                            message: "Record Added!!",
                                            isError: false);
                                      });
                                    },
                                    loading: serviceLoading,
                                    text: "Add Service",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: colorLightGray,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Statistics",
                              style: TextStyle(
                                  color: colorBlue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BoxNavigator(
                              onChange: () {},
                              namesList: const [
                                "Completed  Repr.",
                                "Earnings",
                                "Cancelled Book.."
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Nothing here yet!",
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 100,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          }),
    );
  }
}
