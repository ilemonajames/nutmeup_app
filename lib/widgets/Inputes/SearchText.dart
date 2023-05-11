import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

class SearchTextField extends StatefulWidget {
  SearchTextField({Key? key, required this.controller, required this.onChange , required this.hint})
      : super(key: key);
      
  TextEditingController controller;
  Function onChange;
  String hint;

  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<SearchTextField> {
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
      textAlign: TextAlign.left,
      
      
      onChanged: (value) =>  widget.onChange(value),
      decoration: InputDecoration(
        prefixIcon: Container(
          child: Icon(Icons.search , size: 30 , color: colorBlue,) ,
        ),
        hintStyle:  TextStyle(fontSize: 17 , color: colorGray),
        floatingLabelBehavior:
            FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: widget.hint,
        filled: true, // Needed for adding a fill color
        fillColor: colorWhite,
        isDense: true, // Reduces height a bit
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: backgroundGray), // No border
          borderRadius: BorderRadius.circular(30),
       
        ),
        
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: backgroundGray), // No border
          borderRadius: BorderRadius.circular(30), // Apply corner radius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: backgroundGray), // No border
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
