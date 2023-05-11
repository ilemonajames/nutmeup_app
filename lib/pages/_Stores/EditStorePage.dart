import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_place/google_place.dart' as localSearch;
import 'package:image_picker/image_picker.dart';
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

class EditStorePage extends StatefulWidget {
  EditStorePage(
      {Key? key, required this.createOrEdit, required this.infoToEdit})
      : super(key: key);

  CREATE_OR_EDIT createOrEdit;
  INFORMATION_TO_EDIT infoToEdit;

  @override
  State<EditStorePage> createState() => _EditStorePageState();
}

class _EditStorePageState extends State<EditStorePage> with Extra {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  bool physicalStore = false;
  bool canEditNumber = true;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  // Future<bool> updateRecord() {
  //   return false;
  // }

  ProfileCoverImage() {
    return Container(
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorLightGray,
                ),
                child: Stack(children: [
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTsM8cHFvCC63C07r1OeyZb93-LIDYv72pW3g&usqp=CAU",
                          fit: BoxFit.cover,
                        )),
                  ),
                  Center(
                    child: GestureDetector(
                        onTap: () async {
                          int? selectedAction = await BottomSheetOptionSelector(
                            context,
                            options: [
                              "Profile image",
                              "Cover Image",
                              "Remove images",
                            ],
                            title: "What image would you like to update today?",
                          );

                          if (selectedAction != null) {
                            final XFile? image = await _picker.pickImage(
                                source: ImageSource.gallery);

                            print(image!.path);
                          }
                        },
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.4),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Edit Image",
                                  style: TextStyle(color: colorWhite),
                                )
                              ]),
                        )),
                  )
                ]),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 150.0, // (background container size) - (circle height / 2)
            child: Container(
              height: 120.0,
              width: 120.0,
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAxRI0KkNdpe5nRXLp_Sp9EWemtbtyqE5Mdw&usqp=CAU",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: colorWhite),
            ),
          )
        ],
      ),
    );
  }

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
                      "Please ensure details you provide are correct and authentic. Thank you.",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: colorBlack),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Visibility(
                        visible: widget.infoToEdit == INFORMATION_TO_EDIT.IMAGE,
                        child: ProfileCoverImage()),
                    Visibility(
                        visible: widget.infoToEdit == INFORMATION_TO_EDIT.NAME,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Business Name",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: colorBlue),
                            ),
                            Visibility(
                                child: Column(
                              children: [],
                            )),
                            const SizedBox(
                              height: 15,
                            ),
                            EditTextField(
                              controller: nameController,
                              hint: "Business Name",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                    Visibility(
                        visible: widget.infoToEdit == INFORMATION_TO_EDIT.PHONE,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                              phoneController.text = user
                                                  .userModel!.bioData!.phone!;
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
                                      width: 1,
                                      color: colorLightGray), // No border
                                  borderRadius: BorderRadius.circular(
                                      12), // Apply corner radius
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: colorLightGray), // No border
                                  borderRadius: BorderRadius.circular(
                                      12), // Apply corner radius
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: colorLightGray), // No border
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                    Visibility(
                        visible:
                            widget.infoToEdit == INFORMATION_TO_EDIT.ADDRES,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                              color:
                                                  colorLightGray), // No border
                                          borderRadius:
                                              BorderRadius.circular(12), //
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color:
                                                  colorLightGray), // No border
                                          borderRadius:
                                              BorderRadius.circular(12), //
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1,
                                              color:
                                                  colorLightGray), // No border
                                          borderRadius:
                                              BorderRadius.circular(12), //
                                        ))),
                                suggestionsCallback: (pattern) async {
                                  var places = [];

                                  if (pattern.isEmpty) {
                                    return places;
                                  }
                                  var googlePlace = localSearch.GooglePlace(
                                      "AIzaSyA86GO4MoUenwXbcWFou6cBSy_Oln65dbM");
                                  var result = await googlePlace
                                      .queryAutocomplete
                                      .get(pattern);

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
                                  addressController.text =
                                      (suggestion as Map)["title"];
                                },
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )),
                    Visibility(
                        visible:
                            widget.infoToEdit == INFORMATION_TO_EDIT.PHYISICAL,
                        child: Row(
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
                        )),
                    Visibility(
                        visible: widget.infoToEdit == INFORMATION_TO_EDIT.BIO,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  filled:
                                      true, // Needed for adding a fill color
                                  fillColor: colorWhite,
                                  isDense: true, // Reduces height a bit
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: colorLightGray), // No border
                                    borderRadius: BorderRadius.circular(
                                        12), // Apply corner radius
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: colorLightGray), // No border
                                    borderRadius: BorderRadius.circular(
                                        12), // Apply corner radius
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: colorLightGray), // No border
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    (widget.infoToEdit != INFORMATION_TO_EDIT.IMAGE)
                        ? CustomButton(
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

                              var result = await googleGeocoding.geocoding
                                  .get(_address, []);

                              if (result!.results!.length! <= 0) {
                                Alart(
                                    message: "Location not on the map",
                                    isError: true);
                                return;
                              }
                              double long = result
                                  .results!.first.geometry!.location!.lng!;
                              double lat = result
                                  .results!.first.geometry!.location!.lat!;

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
                            text: "Update")
                        : SizedBox()
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
