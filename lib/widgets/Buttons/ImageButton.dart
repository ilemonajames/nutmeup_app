import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:nutmeup/constants/Colors.dart';

class CustomImageButton extends StatefulWidget {
  CustomImageButton(
      {Key? key, required this.onClick, required this.text, required this.icon})
      : super(key: key);
  Function onClick;
  String text;
  IconData icon;

  @override
  State<CustomImageButton> createState() => _CustomImageButtonState();
}

class _CustomImageButtonState extends State<CustomImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onClick(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: colorLightGray,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  Image.asset("assets/images/icons/google_icon.png"),
              Icon(
                widget.icon,
                color: colorBlue,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(fontSize: 16, color: colorBlue),
              )
            ]),
      ),
    );
  }
}
