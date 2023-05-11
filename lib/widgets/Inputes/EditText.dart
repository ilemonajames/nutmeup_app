import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutmeup/constants/Colors.dart';

class EditTextField extends StatefulWidget {
  EditTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      this.isPhone,
      this.editable})
      : super(key: key);
  TextEditingController controller;
  String hint;
  var isPhone;
  var editable;
  //
  @override
  _EditTextFieldState createState() => _EditTextFieldState();
}

class _EditTextFieldState extends State<EditTextField> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  late bool _isPhone;
  late bool _editable;

  List<TextInputFormatter> formatters = [];

  int characters = 0;

  @override
  void initState() {
    super.initState();

    _isPhone = widget.isPhone ?? false;
    _editable = widget.editable ?? true;

    if (_isPhone) {
      formatters.add(LengthLimitingTextInputFormatter(11));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: false,
      enabled: _editable,
      controller: widget.controller,
      focusNode: textFieldFocusNode,
      inputFormatters: formatters,
      onChanged: ((value) {
        setState(() {
          characters = value.characters.length;
        });
      }),
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 13),
        floatingLabelBehavior:
            FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: widget.hint,
        counterText: _isPhone ? "$characters/11 digits" : null,
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
