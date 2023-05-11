import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Mechanic/MechanicModel.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';
import 'package:nutmeup/widgets/Inputes/SearchText.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';

class SpecializationPage extends StatefulWidget {
  SpecializationPage({Key? key, this.selected}) : super(key: key);
  var selected;

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> with Extra {
  var searchController = TextEditingController();

  var SelectedSkill = [];
  var max = 10;
  var isLoading = false;
  var Skills = [
    "AC Technicaian",
    "Arc Welder",
    "Auto Mechanic",
    "Battery Technician",
    "Brake and Transmission Technician",
    "Diagnostics Technician",
    "Diesel Mechanic",
    "Filter Machinist",
    "Hravy Vehicle Mechanic",
    "Locksmith",
    "Panel Beater",
    "Radiator Repairer",
    "Rewire",
    "Service Technician",
    "Spary Painter",
    "Steam Washer",
    "Towing Van Operator",
    "Upholstery",
    "Vulcanizer",
    "Other"
  ];

  var displaySkills = [];
  var searchKey = "";

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      SelectedSkill = widget.selected;
    }
  }

  @override
  Widget build(BuildContext context) {
    displaySkills = [];
    for (String skill in Skills) {
      if (skill.toLowerCase().contains(searchKey.toLowerCase())) {
        displaySkills.add(skill);
      }
    }
    return Scaffold(
      backgroundColor: backgroundGray,
      appBar: AppBars(context).BackAppBar(color: colorOffWhite),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: colorWhite, borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Specialization",
                    style: TextStyle(
                        color: colorBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Select all Areas of Expertise (10 Max)",
                    style: TextStyle(
                        color: colorGray,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SearchTextField(
                    controller: searchController,
                    hint: "Search",
                    onChange: (value) {
                      searchKey = value;
                      setState(() {});
                    },
                  ),
                ]),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: colorWhite, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                  itemCount: displaySkills.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (a, b) {
                    return GestureDetector(
                      onTap: () {
                        if (SelectedSkill.contains(displaySkills[b])) {
                          SelectedSkill.remove(displaySkills[b]);
                        } else {
                          if (SelectedSkill.length <= 10) {
                            SelectedSkill.add(displaySkills[b]);
                          }
                        }
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(children: [
                          b == 0
                              ? const SizedBox()
                              : Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: colorLightGray,
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                displaySkills[b],
                                style: TextStyle(fontSize: 17),
                              ),
                              Checkbox(
                                  value: SelectedSkill.contains(Skills[b]),
                                  onChanged: (_) {})
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    );
                  }),
            ),
          )),
          Container(
            margin:
                const EdgeInsets.only(left: 10, right: 10, bottom: 30, top: 10),
            child: CustomButton(
              loading: isLoading,
              margin: const EdgeInsets.only(left: 20, right: 20),
              text: "Update",
              onClick: () async {
                setState(() {
                  isLoading = true;
                });

                await firestore
                    .collection(MECHANICS)
                    .doc(userId)
                    .update({"specailization": SelectedSkill});

                setState(() {
                  isLoading = false;
                });
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
