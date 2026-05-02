import 'package:flutter/material.dart';

class AppValidators {
  static String? requiredField(BuildContext context, String? value, String errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }
}
