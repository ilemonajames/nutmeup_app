import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Store/ProductModel.dart';

import 'package:nutmeup/providers/StoreProvider.dart';
import 'package:nutmeup/utilities/Enums.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:nutmeup/widgets/Buttons/Button.dart';
import 'package:nutmeup/widgets/Navigators/AppBar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'dart:io' as File;

import '../../constants/Colors.dart';
import '../../widgets/Inputes/EditText.dart';
import '../../widgets/Inputes/IconEditText.dart';
import '../_Last/Operationdone.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> with Extra {
  final ImagePicker _picker = ImagePicker();
  var productNameController = TextEditingController();
  var descController = TextEditingController();
  var productPriceController = TextEditingController();
  String? selectedCategory;

  List<String> images = [];
  var _radioValue1 = 1;
  var _type = "";
  bool isLoading = false;

  Future<String?> uploadFile(var filePath, String imageName) async {
    File.File file = File.File.fromUri(Uri.parse(filePath));
    try {
      var fil = await FirebaseStorage.instance
          .ref('uploads/${imageName}.png')
          .putFile(file);
      return fil.ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
  }

  SingleImage({position}) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: colorLightGray)),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: (position != null)
              ? Image.file(
                  File.File.fromUri(Uri.parse(images[position])),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/images/icons/other_image.png",
                  height: 80,
                  width: 80,
                )),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StoreProvider storeInfo =
        Provider.of<StoreProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBars(context).BackAppBar(color: Colors.grey.shade200),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: colorWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Post a Product",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: colorBlue,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  child: Image.network(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwugfqgQHwlmhbLgLba64a9qofvJBC6sVNMA&usqp=CAU",
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container();
                                    },
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      storeInfo.storeModel!.name!,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: colorBlue,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      formatPhoneNumber(
                                          phone: storeInfo.storeModel!.phone!),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: colorGray,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upload Photo(s)",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colorBlue),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    bool hasFileAccess = await Permission
                                        .storage
                                        .request()
                                        .isGranted;

                                    if (!hasFileAccess) {
                                      return;
                                    }
                                    final pickedFile = await _picker.pickImage(
                                      source: ImageSource.gallery,
                                      maxWidth: 1800,
                                      maxHeight: 1800,
                                      imageQuality: 50,
                                    );

                                    print("got here");

                                    if (pickedFile == null) {
                                      return;
                                    }

                                    log(pickedFile.toString());
                                    setState(() {
                                      images.add(pickedFile.path);
                                    });
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 100,
                                  height: 100,
                                  child: Stack(children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        "assets/images/icons/first_image.png",
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              Row(
                                children: (images.isEmpty)
                                    ? [
                                        SingleImage(),
                                        SingleImage(),
                                        SingleImage(),
                                      ]
                                    : List<Widget>.generate(images.length,
                                        (index) {
                                        return SingleImage(position: index);
                                      }),
                              )
                            ]),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Text(
                            "You can upload .jpg and .png images only ",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorGray),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          Text(
                            "Product name",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colorBlue),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          EditTextField(
                            controller: productNameController,
                            hint: "Title of product goes here",
                          ),

                          const SizedBox(
                            height: 20,
                          ),

// End of phone number section

                          const SizedBox(
                            height: 12,
                          ),

                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colorBlue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: colorLightGray,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedCategory ?? "Select category",
                                    style: TextStyle(
                                        color: colorGray, fontSize: 16),
                                  ),
                                  PopupMenuButton(
                                      icon: const RotatedBox(
                                        quarterTurns: (45 + 90),
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          size: 15,
                                        ),
                                      ),
                                      itemBuilder: (_) =>
                                          const <PopupMenuItem<String>>[
                                            PopupMenuItem<String>(
                                                child: Text('Spare Part'),
                                                value: 'Spare Part'),
                                            PopupMenuItem<String>(
                                                child:
                                                    Text('Vehicle Accessory'),
                                                value: 'Vehicle Accessory'),
                                            PopupMenuItem<String>(
                                                child: Text('Engine Oil'),
                                                value: 'Engine Oil'),
                                          ],
                                      onSelected: (value) {
                                        setState(() {
                                          selectedCategory = value.toString();
                                        });
                                      })
                                ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),

                          Text(
                            "Price",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: colorBlue),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          IconEditText(
                            controller: productPriceController,
                            hint: "Cost of product",
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Text(
                            "Condition",
                            style: TextStyle(
                                color: colorBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Radio(
                                value: 0,
                                groupValue: _radioValue1,
                                onChanged: (int? value) {
                                  setState(() {
                                    if (value != null) {
                                      _radioValue1 = value;
                                      _type = "Workshop ";
                                    }
                                  });
                                },
                              ),
                              const Text(
                                'Brand New ',
                                style: TextStyle(fontSize: 14.0),
                              ),
                              Radio(
                                value: 1,
                                groupValue: _radioValue1,
                                onChanged: (int? value) => {
                                  setState(() {
                                    if (value != null) {
                                      _radioValue1 = value;
                                      _type = "Mobile";
                                    }
                                  })
                                },
                              ),
                              const Text(
                                'Fairly Used',
                                style: TextStyle(fontSize: 14.0),
                              ),
                              Radio(
                                value: 2,
                                groupValue: _radioValue1,
                                onChanged: (int? value) {
                                  setState(() {
                                    if (value != null) {
                                      _radioValue1 = value;
                                      _type = "Hybrid Mechanic";
                                    }
                                  });
                                },
                              ),
                              const Text(
                                'Used',
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
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
                              controller: descController,
                              focusNode: FocusNode(),
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 13),
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .never, //Hides label on focus or if filled
                                labelText: "Detailed information about product",
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
                          ),

                          CustomButton(
                              onClick: () async {
                                String product_id = uuid.v4();
                                String productName =
                                    productNameController.text.trim();
                                double? productPrice = double.tryParse(
                                    productPriceController.text.trim());

                                String desc = descController.text.trim();

                                if (desc.isEmpty) {
                                  Alart(
                                      message: "Please enter description",
                                      isError: true);
                                  return;
                                }

                                if (productPrice == null) {
                                  Alart(
                                      message: "Please enter a valid amount",
                                      isError: true);
                                  return;
                                }

                                if (selectedCategory == null) {
                                  Alart(
                                      message: "Please select a category",
                                      isError: true);
                                  return;
                                }

                                try {
                                  List<Gallery> galleryImages = [];
                                  setState(() {
                                    isLoading = true;
                                  });

                                  for (int a = 0; a < images.length; a++) {
                                    var fileLink = await uploadFile(
                                        images[a], '${product_id}-$a');

                                    print("done with ${a + 1}");
                                    if (fileLink != null) {
                                      galleryImages.add(Gallery(
                                          link: fileLink.toString(),
                                          type: "IMAGE"));
                                    }
                                  }

                                  ProductModel model = ProductModel(
                                      name: productName,
                                      storeId: userId,
                                      userId: userId,
                                      price: Price(amount: productPrice),
                                      condition: _radioValue1,
                                      category: selectedCategory!,
                                      location: storeInfo.storeModel!.location!,
                                      description: desc,
                                      status: "PENDING",
                                      sold: [],
                                      sRatting: 0,
                                      gallery: galleryImages);

                                  await firestore
                                      .collection(PRODUCTS)
                                      .doc(product_id)
                                      .set(model.toJson());

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => Lastpage(
                                                status: STATUS.SUCCESS,
                                              )),
                                      (route) => false);
                                } catch (e) {
                                  Alart(
                                      message: "Failed ${e.toString()}",
                                      isError: true);
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                              loading: isLoading,
                              text: "Submit")
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ]),
            ),
          ],
        )),
      ),
    );
  }
}
