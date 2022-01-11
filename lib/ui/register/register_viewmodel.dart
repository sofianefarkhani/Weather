import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/authentication_service.dart';

@injectable
class RegisterViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  RegisterViewModel(this._authenticationService);

  String _displayedError = "";
  String get displayedError => _displayedError;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  bool verifyEmail(String value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);

    if (!emailValid) {
      _displayedError = "Veuillez entrer un email valide";
      notifyListeners();
    } else {
      _displayedError = "";
      notifyListeners();
    }

    return emailValid;
  }

  bool verifyPassword(String value) {
    bool isValid = true;

    if (value.length < 6) {
      isValid = false;
      _displayedError = "Ton mot de passe est trop court";
      notifyListeners();
    } else {
      _displayedError = "";
      notifyListeners();
    }

    return isValid;
  }

  register(BuildContext context) async {
    if (verifyEmail(_emailController.text) &&
        verifyPassword(_passwordController.text)) {
      await _authenticationService.registerWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
          context);
      await _authenticationService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text, context);
      Navigator.of(context).pop();
    }
  }
}
