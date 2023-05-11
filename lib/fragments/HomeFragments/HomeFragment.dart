import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:nutmeup/constants/Colors.dart';
import 'package:nutmeup/constants/DBNames.dart';
import 'package:nutmeup/controllers/extras.dart';
import 'package:nutmeup/widgets/Inputes/ImageView.dart';
import 'package:nutmeup/widgets/messagesExtras.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';

import '../../providers/UsersProvider.dart';
import '../../widgets/Buttons/Button.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> with Extra {
  var controller = ScrollController();

  SingleMechanicLoading() {
    return Container(
      width: 200,
      height: 200,
      margin: EdgeInsets.only(left: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                    shape: BoxShape.circle, width: 55, height: 55),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 13,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 13,
                        width: 30,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 13,
                    //width: 30,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              SizedBox(
                height: 6,
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 13,
                    width: 35,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              SizedBox(
                height: 5,
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 13,
                    width: 100,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 13,
                        width: 20,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                        height: 13,
                        width: 100,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 13,
                    width: 20,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              SkeletonLine(
                style: SkeletonLineStyle(
                    height: 13,
                    width: 100,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              )
            ],
          ),
        ],
      ),
    );
  }

  SingleMechanic() {
    return Container(
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(left: 10, top: 15),
      decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageViews(context)
                  .ProfileImage(link: null, width: 55, height: 55),
              // ClipRRect(
              //   borderRadius: const BorderRadius.all(Radius.circular(40)),
              //   child: Image.network(
              //     "https://www.genautoinc.com/wp-content/uploads/2021/02/Hire-a-professional-mechanic-in-maryland.jpg",
              //     width: 60,
              //     height: 60,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    padding:
                        EdgeInsets.only(top: 3, bottom: 3, right: 5, left: 5),
                    decoration: BoxDecoration(
                        color: colorLightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Text(
                      " PROMOTED ",
                      style: TextStyle(fontSize: 10, color: colorWhite),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "John Bikikisu",
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Automobile Mechanic",
                style: TextStyle(
                    fontSize: 13,
                    color: colorBlue,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "12km away (18mins)",
                style: TextStyle(
                    fontSize: 13,
                    color: colorGray,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_pin,
                size: 13,
                color: colorBlue,
              ),
              Text(
                "Gwagwalada",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: colorBlue,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.star,
                    size: 16,
                    color: colorLightBlue,
                  ),
                ],
              ),
              Text(
                "(102 Reviews)",
                style: TextStyle(
                    fontSize: 13,
                    color: colorLightBlue,
                    fontWeight: FontWeight.w700),
              )
            ],
          )
        ],
      ),
    );
  }

  SinglePageOption(
      {required Function onClick,
      required String title,
      required String image,
      required String subTitle}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        height: 110,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            color: Color(0xffE4F0FF),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Row(children: [
          const SizedBox(
            width: 25,
          ),
          Image.asset(
            image,
            width: 50,
            height: 50,
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: colorBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                subTitle,
                style: const TextStyle(color: Color(0xff646464), fontSize: 15),
              )
            ],
          ))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context, listen: false);

    return SingleChildScrollView(
      controller: controller,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: colorWhite,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: colorBlue),
                    ),
                    Text(
                      "Select Services",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: colorBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SinglePageOption(
                        image: "assets/images/icons/mechanic.png",
                        onClick: () {},
                        title: "MECHANIC",
                        subTitle:
                            "Find a mechanic or make money\nworking as a mechanic."),
                    SinglePageOption(
                        image: "assets/images/icons/spare_parts.png",
                        onClick: () {},
                        title: "SPARE PARTS",
                        subTitle:
                            "Buy or Sell spare parts and car\naccessories and car fluids."),
                    SinglePageOption(
                        image: "assets/images/icons/delivery_agent.png",
                        onClick: () {},
                        title: "DELIVERY AGENT",
                        subTitle: "Find or become a delivery agent."),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: backgroundGray,
                  borderRadius: const BorderRadius.all(Radius.circular(13))),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Mechanics Near Me",
                      style: TextStyle(
                          color: colorBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                        stream: firestore
                            .collection(USERS)
                            .doc(userId)
                            .collection("NEAR_ME")
                            .snapshots(),
                        builder: (a, AsyncSnapshot<QuerySnapshot> b) {
                          if (b.hasData) {
                            if (b.data!.docs.isEmpty) {
                              return Container(
                                padding: const EdgeInsets.all(30),
                                alignment: Alignment.center,
                                child: Column(children: [
                                  Text(
                                    "No Mechanic Closeby",
                                    style: TextStyle(
                                        color: colorBlue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "We could'nt find any mechanics within a 100km radius of your current location. Click the button to search now",
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 40,
                                    child: CustomButton(
                                      onClick: () {},
                                      text: "Search Now",
                                    ),
                                  )
                                ]),
                              );
                            }
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    height: 210,
                                    child: ListView.builder(
                                        itemCount: 5,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (a, b) {
                                          return SingleMechanic();
                                        }),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Container(
                                    height: 205,
                                    child: ListView.builder(
                                        itemCount: 2,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (a, b) {
                                          return SingleMechanicLoading();
                                        }),
                                  ),
                                ],
                              ),
                            );
                          }
                        })
                  ]),
            )
          ]),
    );
  }
}
