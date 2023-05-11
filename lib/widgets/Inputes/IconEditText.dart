import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

class IconEditText extends StatefulWidget {
  IconEditText({Key? key, required this.controller, required this.hint})
      : super(key: key);
  TextEditingController controller;
  String hint;
  @override
  _IconEditTextState createState() => _IconEditTextState();
}

class _IconEditTextState extends State<IconEditText> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  @override
  Widget build(BuildContext context) {
    return 
    TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: false,
      controller: widget.controller,
      focusNode: textFieldFocusNode,
      
      decoration: InputDecoration(
        prefixIcon: Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: colorLightBlue , 
            borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          child: Text("₦" , style: TextStyle(fontSize: 16 , color: colorWhite , fontWeight: FontWeight.w700),),
        ),
        hintStyle: TextStyle(fontSize: 13),
        floatingLabelBehavior:
            FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: widget.hint,
        filled: true, // Needed for adding a fill color
        fillColor: colorWhite,
        isDense: true, // Reduces height a bit
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: colorLightGray), // No border
          borderRadius: BorderRadius.circular(12), // Apply corner radius
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: colorLightGray), // No border
          borderRadius: BorderRadius.circular(12), // Apply corner radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: colorLightGray), // No border
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
