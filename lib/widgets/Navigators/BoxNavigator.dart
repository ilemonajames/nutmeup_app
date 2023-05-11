import 'package:flutter/material.dart';

import 'package:nutmeup/constants/Colors.dart';

class BoxNavigator extends StatefulWidget {
  BoxNavigator(
      {Key? key,
      required this.namesList,
      required this.onChange,
      this.hasShadow})
      : super(key: key);
  List<String> namesList;
  Function onChange;
  var hasShadow;

  @override
  State<BoxNavigator> createState() => _BoxNavigatorState();
}

class _BoxNavigatorState extends State<BoxNavigator> {
  int selected = 0;
  bool hasShadow = true;

  SingleTap({required String title, required int position}) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        setState(() {
          selected = position;
          widget.onChange(position ?? 0);
        });
      },
      child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: position == selected
                  ? Border.all(width: 1, color: colorLightBlue)
                  : Border.all(color: colorOffWhite),
              borderRadius: position == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5))
                  : (position == (widget.namesList.length - 1))
                      ? const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))
                      : null,
              color:
                  position == selected ? const Color(0xffF4F9FF) : colorWhite),
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          )),
    ));
  }

  @override
  void initState() {
    super.initState();
    hasShadow = widget.hasShadow ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: colorWhite,
            borderRadius:
                hasShadow ? const BorderRadius.all(Radius.circular(5)) : null),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List<Widget>.generate(widget.namesList.length, (index) {
            return SingleTap(title: widget.namesList[index], position: index);
          }).toList(),
        ));
  }
}
