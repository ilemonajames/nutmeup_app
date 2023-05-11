import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/models/Vehicle/VehicleModel.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

import '_cars/Create.dart';

class CreateNewCar extends StatefulWidget {
  CreateNewCar({Key? key, this.model}) : super(key: key);
  var model;

  @override
  State<CreateNewCar> createState() => _CreateNewCarState();
}

class _CreateNewCarState extends State<CreateNewCar> {

  @override
  void initState() {
    super.initState();
 
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
              padding:  const EdgeInsets.all(15),
              margin: const  EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "All fileds are required. Please enter correct information about your car",
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
              child: createCar(model :widget.model),
            )
          ],
        ),
      ),
    );
  }
}
