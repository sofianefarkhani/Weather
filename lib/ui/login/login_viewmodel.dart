import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/ui/register/register_view.dart';
import 'package:weather/utils/utils.dart';

@injectable
class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  LoginViewModel(this._authenticationService);

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  bool verifyEmail(BuildContext context, String value) {
    bool emailValid = Utils.verifyEmail(context, value);
    notifyListeners();
    return emailValid;
  }

  bool verifyPassword(BuildContext context, String value) {
    bool isValid = Utils.verifyPassword(context, value);
    notifyListeners();

    return isValid;
  }

  login(BuildContext context) async {
    if (verifyEmail(context, _emailController.text) &&
        verifyPassword(context, _passwordController.text)) {
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
