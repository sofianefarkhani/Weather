import 'package:flutter/material.dart';

class Utils {
  static displayMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  static bool verifyEmail(BuildContext context, String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailValid) {
      Utils.displayMessage(context, "Veuillez entrer un email valide");
    }

    return emailValid;
  }

  static bool verifyPassword(BuildContext context, String value) {
    bool isValid = true;

    if (value.length < 6) {
      isValid = false;
      Utils.displayMessage(context, "Ton mot de passe est trop court");
    }

    return isValid;
  }
}
