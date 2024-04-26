import 'package:flutter/material.dart';

class RegistrationController extends ChangeNotifier {
  bool isInside = false;
  bool isPasswordVisible = true;
  bool isconfirmPasswordVisible = true;
  void changeInside(bool value) {
    isInside = value;
    notifyListeners();
  }

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  toggleconfirmPasswordVisibility() {
    isconfirmPasswordVisible = !isconfirmPasswordVisible;
    notifyListeners();
  }
}
