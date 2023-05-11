import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({Key? key, required this.onChange , required this.currentPage}) : super(key: key);
  Function onChange;
  int currentPage;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
int selected = 0;
  Widget SingleNavigation(
      {required int position,
      required String title,
      required String selectedImage,
      required String unseleted}) {
    return GestureDetector(
      onTap: (() {
        widget.onChange(position);
      }),
      child: Column(
        children: [
          Image.asset(
            widget.currentPage == position ? selectedImage : unseleted,
            height: 25,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }



@override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xffE4F0FF),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleNavigation(
              position: 0,
              selectedImage: "assets/images/icons/select_home.png",
              unseleted: "assets/images/icons/unselect_home.png",
              title: "Home"),
          SingleNavigation(
              position: 1,
              selectedImage: "assets/images/icons/select_hand.png",
              unseleted: "assets/images/icons/unselect_hand.png",
              title: "Repair"),
          SingleNavigation(
              position: 2,
              selectedImage: "assets/images/icons/select_part.png",
              unseleted: "assets/images/icons/unselect_part.png",
              title: "Spare Parts"),
          SingleNavigation(
              position: 3,
              selectedImage: "assets/images/icons/select_bike.png",
              unseleted: "assets/images/icons/unselect_bike.png",
              title: "Delivery"),
          SingleNavigation(
              position: 4,
              selectedImage: "assets/images/icons/select_person.png",
              unseleted: "assets/images/icons/unselect_person.png",
              title: "Account"),
        ],
      ),
    );
  }
}
