import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/ui/register/register_view.dart';

@injectable
class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  LoginViewModel(this._authenticationService);

  String _displayedError = "";
  String get displayedError => _displayedError;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

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

  login(BuildContext context) async {
    if (verifyEmail(_emailController.text) &&
        verifyPassword(_passwordController.text)) {
      _authenticationService.signInWithEmailAndPassword(
          _emailController.text, _passwordController.text, context);
    }
  }

  navigateToRegisterView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const RegisterPage(),
      ),
    );
  }
}
