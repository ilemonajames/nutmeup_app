import 'package:flutter/material.dart';

import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/models/Store/StoreModel.dart';
import 'package:nutmeup/pages/_Stores/CreateShopPage.dart';
import 'package:nutmeup/providers/StoreProvider.dart';
import 'package:nutmeup/utilities/utilities.dart';
import 'package:provider/provider.dart';

import '../../constants/Colors.dart';
import '../../constants/Constants.dart';
import '../../pages/_Stores/CreateProductPage.dart';
import '../../widgets/messagesExtras.dart';

class MyStoreFragment extends StatefulWidget {
  const MyStoreFragment({Key? key}) : super(key: key);

  @override
  State<MyStoreFragment> createState() => _MachanicProfileFragmentState();
}

class _MachanicProfileFragmentState extends State<MyStoreFragment> with Extra {
  Future<StoreModel> getInfo() async {
    StoreModel model;
    var a = await firestore.collection(STORES).doc(userId).get();
    if (a.exists) {
      model = StoreModel.fromJson(a.data() as Map<String, dynamic>);
      Provider.of<StoreProvider>(context, listen: false)
          .updateStoreProvider(model);

      return model;
    } else {
      return StoreModel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        child: FutureBuilder(
          future: getInfo(),
          builder: (a, AsyncSnapshot<StoreModel?> b) {
            StoreModel? store;
            if (b.hasData) {
              if (b.data!.name == null) {
                return EmptyMessage(
                    message: "Create store front",
                    onClick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const CreateStorePage())));
                    },
                    title: DefaultMessages().emptyMessage(about: "Store"));
              } else {
                store = b.data as StoreModel;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwugfqgQHwlmhbLgLba64a9qofvJBC6sVNMA&usqp=CAU",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "4.8",
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "( ${store.sRating} Reviews )",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: colorLightBlue,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Text(
                              store.name!,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: colorBlue,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              formatPhoneNumber(phone: store.phone!),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorGray,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                        Column(
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      store!.location!.name!,
                      style: TextStyle(
                          color: colorBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      store.bioData!,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: colorGray),
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
                                    builder: (builder) => CreateProductPage()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xffE4F0FF),
                              border:
                                  Border.all(width: 1, color: colorLightBlue),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              "Post a Product",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: colorLightBlue,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        )),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              store.sProducts ?? "0",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: colorBlue,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Total Products",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorGray,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ));
  }
}
