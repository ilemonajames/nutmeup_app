import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/constants/data.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Vehicle/VehicleBrandModel.dart';
import 'package:nutmeup/models/Vehicle/VehicleModel.dart';
import 'package:nutmeup/pages/_Last/Operationdone.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/validate.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';
import 'package:nutmeup/widgets/Inputes/EditText.dart';

class createCar extends StatefulWidget {
  createCar({Key? key, this.model}) : super(key: key);
  var model;

  @override
  State<createCar> createState() => _createCarState();
}

class _createCarState extends State<createCar> with Extra {
  var year = TextEditingController();
  var title = TextEditingController();
  var _title = "My Car";

  late List<VehicleBrandModel> brands;
  VehicleBrandModel? selectedBrand;
  VehicleModel? model;

  List<String?> mdels = [];
  String? selectedModel;

  bool isLoading = false;

  DropDownContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          border: Border.all(color: colorLightGray),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  @override
  void initState() {
    brands = [];
    super.initState();
    carsBrands.forEach((element) {
      brands.add(VehicleBrandModel.fromJson(element));
    });

    if (widget.model != null) {
      model = widget.model as VehicleModel;
      title.text = model!.title!;
      year.text = model!.year!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        EditTextField(
          controller: title,
          hint: "Title e.g My Car",
        ),
        const SizedBox(
          height: 10,
        ),
        DropDownContainer(
            child: DropdownButton<VehicleBrandModel>(
          isExpanded: true,
          underline: Container(),
          hint: Text(selectedBrand == null
              ? "Select Manufacture"
              : selectedBrand!.brand!),
          items: brands.map((VehicleBrandModel value) {
            return DropdownMenuItem<VehicleBrandModel>(
              value: value,
              child: Text(value.brand!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedBrand = value;
              mdels = value!.models!;
            });
          },
        )),
        const SizedBox(
          height: 10,
        ),
        DropDownContainer(
            child: DropdownButton<String?>(
          isExpanded: true,
          underline: Container(),
          hint: Text(selectedModel ?? "Select Brand"),
          items: mdels.map((String? value) {
            return DropdownMenuItem<String?>(
              value: value,
              child: Text(value!),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedModel = value;
            });
          },
        )),
        const SizedBox(
          height: 10,
        ),
        EditTextField(
          controller: year,
          hint: "Year",
        ),
        const SizedBox(
          height: 15,
        ),
        CustomButton(
          text: "Submit",
          loading: isLoading,
          onClick: () async {
            _title = inputeValidate(context).ValidateField(title);
            var _year = inputeValidate(context).ValidateField(year);
            var id = uuid.v4();

            VehicleModel model = VehicleModel(
                title: _title,
                year: _year,
                gear: "4 WD Gear",
                status: "ACTIVE",
                config: "Front-Drive",
                manufacturer: selectedBrand!.brand,
                createdBy: userId,
                vehicleId: id,
                createdAt: FieldValue.serverTimestamp());

            setState(() {
              isLoading = true;
            });

            try {
              var upload = await FirebaseFirestore.instance
                  .collection(VEHICLES)
                  .doc(id)
                  .set(model.toJson());

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => Lastpage(
                            status: STATUS.SUCCESS,
                          )));
            } catch (e) {
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
