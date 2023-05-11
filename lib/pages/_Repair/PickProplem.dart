import 'package:flutter/material.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Requests/RequestModel1.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';

import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '../../models/Vehicle/VehicleModel.dart';
import '../_Mechanic/FindAMechanic.dart';

class PickProblemPage extends StatefulWidget {
  PickProblemPage({Key? key, this.model, required this.item}) : super(key: key);
  var model;

  RequestItem item;
  @override
  State<PickProblemPage> createState() => _PickProblemPageState();
}

class _PickProblemPageState extends State<PickProblemPage> with Extra {
  VehicleModel? selectedVehicle;
  bool _isLoading = false;
  int? selectedProblem;
  List<String> options = [
    "I know what is wrong,\nSelect  Problem.",
    "I don’t know what is wrong, but I know the kind of mechanic/technician I need",
    "I have no idea what’s going on, I need to speak with an expert first."
  ];

  late RequestItem item;
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

  SingleProblem({required String text, required int index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedProblem = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            border: selectedProblem == index
                ? Border.all(color: colorLightBlue)
                : null,
            color: const Color(0xffE5F1FF),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: colorGray),
        ),
      ),
    );
  }

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
              padding: const EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "What is wrong with the vehicle?",
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List<Widget>.generate(
                        options.length,
                        (index) =>
                            SingleProblem(text: options[index], index: index))
                    .toList(),
              )),
            ),
            CustomButton(
              text: "Next",
              margin: const EdgeInsets.all(10),
              loading: _isLoading,
              onClick: () async {
                if (selectedProblem == null) {
                  Alart(message: "No selction made", isError: true);
                } else {
                  item.carFault = options[selectedProblem!];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FindAMechanic(
                                item: item,
                              )));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
