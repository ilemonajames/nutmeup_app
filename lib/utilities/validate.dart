// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:nutmeup/utilities/utilities.dart';

enum AboveOrBelow { ABOVE, BELLOW, EQUAL }

class inputeValidate {
  BuildContext context;
  inputeValidate(this.context);

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s) != -1;
  }

  ValidateField(TextEditingController controller,
      {isEmailValid,
      isDigit,
      int checkCount = -1,
      AboveOrBelow aboveOrBelow = AboveOrBelow.ABOVE}) {
    bool _canProceed = false;
    bool _isEmail = isEmailValid ?? false;
    bool _isDigits = isDigit ?? false;

    String textValue = controller.text.trim();
    if (textValue.isEmpty) {
      Alart(message: "Field(s) empty", isError: true);
      return;
    }
    if (_isEmail) {
      if (emailValidation().isEmailValid(email: textValue)) {
        // email is not valid
      } else {
        Alart(message: "Please enter a valid email address", isError: true);
        return;
      }
    }

    if (checkCount != -1) {
      if (aboveOrBelow == AboveOrBelow.BELLOW) {
        if (checkCount <= textValue.length) {
          // all good
        } else {
          Alart(
              message:
                  "Text limit error: text should be less or equal to  $checkCount",
              isError: true);
          return;
        }
      }
      if (aboveOrBelow == AboveOrBelow.ABOVE) {
        if (checkCount >= textValue.length) {
          // all good
        } else {
          Alart(
              message:
                  "Text limit error: text should be greater or equal to $checkCount",
              isError: true);
          return;
        }

        if (aboveOrBelow == AboveOrBelow.EQUAL) {
          if (checkCount == textValue.length) {
            // all good
          } else {
            Alart(
                message:
                    "Text limit error: text should be greater or equal to $checkCount",
                isError: true);

            return;
          }
        }
      }
    }

    if (_isDigits) {
      if (!_isNumeric(textValue)) {
        Alart(message: "Numeric data exptected.", isError: true);
        return;
      }
    }

    return textValue;
  }
}
