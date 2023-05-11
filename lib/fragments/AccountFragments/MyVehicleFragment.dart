import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nutmeup/constants/Constants.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Vehicle/VehicleModel.dart';
import 'package:nutmeup/pages/_Last/Operationdone.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/modal.dart';

import '../../constants/Colors.dart';
import '../../pages/_Cars/createCar.dart';
import '../../widgets/messagesExtras.dart';

class MyVehicleFragment extends StatefulWidget {
  const MyVehicleFragment({Key? key}) : super(key: key);

  @override
  State<MyVehicleFragment> createState() => _MyVehicleFragmentState();
}

class _MyVehicleFragmentState extends State<MyVehicleFragment> with Extra {
  SinglePageOption(
      {required Function onClick,
      required String title,
      required bool isBold}) {
    return Expanded(
        child: GestureDetector(
      onTap: () => onClick(),
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
      ),
    ));
  }

  SingleVehicle({required VehicleModel model}) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                    GestureDetector(
                      onTap: () {
                        showMessageDialog(context,
                            title: "Confirm delete",
                            message:
                                "You are about to delete this vehicle \"${model.title}\"\nAre you sure you want to preoceed.",
                            onProceed: () async {
                          var process = await firestore
                              .collection(VEHICLES)
                              .doc(model.vehicleId)
                              .update({"status": "DELETED"});

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => Lastpage(
                                        status: STATUS.SUCCESS,
                                      )));
                        });
                      },
                      child: Icon(
                        Icons.delete_outline_outlined,
                        color: colorBlue,
                      ),
                    )
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
                        onClick: () {}),
                    const SizedBox(
                      width: 5,
                    ),
                    SinglePageOption(
                        title: model.year!, isBold: false, onClick: () {})
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    SinglePageOption(
                        title: model.gear!, isBold: true, onClick: () {}),
                    const SizedBox(
                      width: 10,
                    ),
                    SinglePageOption(
                        title: model.config!, isBold: true, onClick: () {})
                  ],
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
                                builder: (builder) => CreateNewCar()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xffE4F0FF),
                          border: Border.all(width: 1, color: colorLightBlue),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          "Add New",
                          style: TextStyle(
                              fontSize: 15,
                              color: colorLightBlue,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CreateNewCar(
                                      model: model,
                                    )));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xffE4F0FF),
                          border: Border.all(width: 1, color: colorLightBlue),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          "Edit Vehicle",
                          style: TextStyle(
                              fontSize: 15,
                              color: colorLightBlue,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
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
                                builder: ((context) => CreateNewCar())));
                      },
                      title: DefaultMessages().emptyMessage(about: "Vehicle"));
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
      ]),
    );
  }
}
