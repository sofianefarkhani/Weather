import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/utils/utils.dart';

@injectable
class RegisterViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  RegisterViewModel(this._authenticationService);

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

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

  register(BuildContext context) async {
    if (verifyEmail(context, _emailController.text) &&
        verifyPassword(context, _passwordController.text)) {
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
