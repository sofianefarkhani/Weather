import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/authentication_service.dart';

@injectable
class ProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;
  ProfileViewModel(this._authenticationService);

  String _displayedError = "";
  String get displayedError => _displayedError;

  final TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController => _newPasswordController;

  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  TextEditingController get confirmNewPassordController =>
      _confirmNewPasswordController;

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

  updateProfile(BuildContext context) async {
    if (verifyPassword(_newPasswordController.text) &&
        verifyPassword(_confirmNewPasswordController.text) &&
        _newPasswordController.text == _confirmNewPasswordController.text) {
      await _authenticationService.updatePassword(
          _newPasswordController.text, context);
    }
  }

  deleteProfile(BuildContext context) async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmation de suppression'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                displayMessage(context, 'Action annulée');
              },
              child: const Text('NON'),
            ),
            TextButton(
              onPressed: () async {
                await _authenticationService.deleteUser(context);
                Navigator.of(context).pop();
                displayMessage(context, "Le compte vient d'être supprimé");
                Navigator.of(context).pop();
              },
              child: const Text('OUI'),
            ),
          ],
        ),
      );

  displayMessage(BuildContext context, String message) {
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
}
