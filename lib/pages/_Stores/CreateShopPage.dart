import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_place/google_place.dart' as localSearch;
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Store/StoreModel.dart' as store;
import 'package:nutmeup/providers/UsersProvider.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/utilities/validate.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';
import 'package:provider/provider.dart';

import '../../constants/Colors.dart';
import '../../widgets/Inputes/EditText.dart';
import '../_Last/Operationdone.dart';

class CreateStorePage extends StatefulWidget {
  const CreateStorePage({Key? key}) : super(key: key);

  @override
  State<CreateStorePage> createState() => _CreateStorePageState();
}

class _CreateStorePageState extends State<CreateStorePage> with Extra {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  bool physicalStore = false;
  bool canEditNumber = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBars(context).BackAppBar(color: colorWhite),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              color: colorWhite,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Hello ${user.userModel!.bioData!.name},",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: colorBlue),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Set up your account in order to sell spare parts, engine oils and  car accessories on NutMeUp ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: colorBlack),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    Text(
                      "Business Name",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: colorBlue),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    EditTextField(
                      controller: nameController,
                      hint: "Business Name",
                    ),

                    // Phone Number section

                    const SizedBox(
                      height: 25,
                    ),

                    Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: colorBlue),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: false,
                      readOnly: !canEditNumber,
                      controller: phoneController,
                      focusNode: FocusNode(),
                      decoration: InputDecoration(
                        suffixIcon: Container(
                            child: PopupMenuButton(
                                icon: const RotatedBox(
                                  quarterTurns: (45 + 90),
                                  child: Icon(Icons.arrow_back_ios),
                                ),
                                itemBuilder: (_) =>
                                    const <PopupMenuItem<String>>[
                                      PopupMenuItem<String>(
                                          child: Text(
                                              'Use same as  profile number'),
                                          value: 'profile'),
                                      PopupMenuItem<String>(
                                          child: Text('Enter Number'),
                                          value: 'enter'),
                                    ],
                                onSelected: (value) {
                                  if (value == "profile") {
                                    setState(() {
                                      phoneController.text =
                                          user.userModel!.bioData!.phone!;
                                      canEditNumber = false;
                                    });
                                  } else if (value == "enter") {
                                    setState(() {
                                      phoneController.text = "";
                                      canEditNumber = true;
                                    });
                                  }
                                })),
                        hintStyle: TextStyle(fontSize: 13),
                        floatingLabelBehavior: FloatingLabelBehavior
                            .never, //Hides label on focus or if filled
                        labelText: "Phone",
                        filled: true, // Needed for adding a fill color
                        fillColor: colorWhite,
                        isDense: true, // Reduces height a bit
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorLightGray), // No border
                          borderRadius:
                              BorderRadius.circular(12), // Apply corner radius
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorLightGray), // No border
                          borderRadius:
                              BorderRadius.circular(12), // Apply corner radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorLightGray), // No border
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

// End of phone number section

                    const SizedBox(
                      height: 12,
                    ),

                    Text(
                      "Store Address",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: colorBlue),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // EditTextField(
                    //   controller: addressController,
                    //   hint: "Store Address",
                    // ),

                    Container(
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: addressController,
                            autofocus: false,
                            decoration: InputDecoration(
                                hintText: "Location",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: colorLightGray), // No border
                                  borderRadius: BorderRadius.circular(12), //
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: colorLightGray), // No border
                                  borderRadius: BorderRadius.circular(12), //
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: colorLightGray), // No border
                                  borderRadius: BorderRadius.circular(12), //
                                ))),
                        suggestionsCallback: (pattern) async {
                          var places = [];

                          if (pattern.isEmpty) {
                            return places;
                          }
                          var googlePlace = localSearch.GooglePlace(
                              "AIzaSyA86GO4MoUenwXbcWFou6cBSy_Oln65dbM");
                          var result =
                              await googlePlace.queryAutocomplete.get(pattern);

                          result!.predictions!.forEach((element) {
                            places.add({
                              "title": element.description.toString(),
                              "ref": element.reference
                            });
                          });

                          return places;
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            leading: Icon(
                              Icons.location_pin,
                              color: colorBlue,
                            ),
                            title: Text(
                              (suggestion as Map)["title"],
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          addressController.text = (suggestion as Map)["title"];
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "I don’t have a physical store",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: colorBlue),
                        ),
                        Switch(
                            value: physicalStore,
                            onChanged: (onChanged) {
                              setState(() {
                                physicalStore = onChanged;
                              });
                            })
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      "Bio",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: colorBlue),
                    ),
                    const SizedBox(
                      height: 12,
                    ),

                    SizedBox(
                      height: 200,
                      child: TextField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: false,
                        maxLines: 5,
                        textAlignVertical: TextAlignVertical.top,
                        textAlign: TextAlign.start,
                        controller: bioController,
                        focusNode: FocusNode(),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 13),
                          floatingLabelBehavior: FloatingLabelBehavior
                              .never, //Hides label on focus or if filled
                          labelText: "Summarise your business here",
                          filled: true, // Needed for adding a fill color
                          fillColor: colorWhite,
                          isDense: true, // Reduces height a bit
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: colorLightGray), // No border
                            borderRadius: BorderRadius.circular(
                                12), // Apply corner radius
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: colorLightGray), // No border
                            borderRadius: BorderRadius.circular(
                                12), // Apply corner radius
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: colorLightGray), // No border
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),

                    CustomButton(
                        loading: isLoading,
                        onClick: () async {
                          var _name = inputeValidate(context)
                              .ValidateField(nameController);

                          var _phone = inputeValidate(context)
                              .ValidateField(phoneController);

                          var _address = inputeValidate(context)
                              .ValidateField(addressController);

                          var _bio = inputeValidate(context)
                              .ValidateField(bioController);

                          var googleGeocoding = GoogleGeocoding(
                              "AIzaSyA86GO4MoUenwXbcWFou6cBSy_Oln65dbM");

                          var result =
                              await googleGeocoding.geocoding.get(_address, []);

                          if (result!.results!.length! <= 0) {
                            Alart(
                                message: "Location not on the map",
                                isError: true);
                            return;
                          }
                          double long =
                              result.results!.first.geometry!.location!.lng!;
                          double lat =
                              result.results!.first.geometry!.location!.lat!;

                          store.StoreModel model = store.StoreModel(
                              name: _name,
                              phone: _phone,
                              location: store.Location(
                                  name: _address,
                                  geohash: "",
                                  geopoint: GeoPoint(long, lat)),
                              bioData: _bio,
                              storeId: userId,
                              physicalStore: physicalStore,
                              tags: [],
                              services: [],
                              sRating: 0.0,
                              createdBy: userId,
                              createdAt: FieldValue.serverTimestamp());

                          setState(() {
                            isLoading = true;
                          });

                          try {
                            var upload = await FirebaseFirestore.instance
                                .collection(STORES)
                                .doc(userId)
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
                        text: "Submit")
                  ]),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        )),
      ),
    );
  }
}
