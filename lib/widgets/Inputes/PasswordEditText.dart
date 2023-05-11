import 'package:flutter/material.dart';
import 'package:nutmeup/constants/Colors.dart';

class PasswordField extends StatefulWidget {
  PasswordField({Key? key, required this.controller , required this.hint}) : super(key: key);
  TextEditingController controller;
  String hint;
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscured,
      controller: widget.controller,
      focusNode: textFieldFocusNode,
      decoration: InputDecoration(
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
        // prefixIcon: const Icon(Icons.lock_rounded, size: 24),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: GestureDetector(
            onTap: _toggleObscured,
            child: Icon(
              _obscured
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              size: 24,
              color: colorGray,
            ),
          ),
        ),
      ),
    );


  }
}
