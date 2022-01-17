import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/utils/utils.dart';

@injectable
class ProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;
  ProfileViewModel(this._authenticationService);

  final TextEditingController _newPasswordController = TextEditingController();
  TextEditingController get newPasswordController => _newPasswordController;

  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  TextEditingController get confirmNewPassordController =>
      _confirmNewPasswordController;

  bool verifyPassword(BuildContext context, String value) {
    bool isValid = Utils.verifyPassword(context, value);
    notifyListeners();

    return isValid;
  }

  updateProfile(BuildContext context) async {
    if (verifyPassword(context, _newPasswordController.text) &&
        verifyPassword(context, _confirmNewPasswordController.text) &&
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
                Utils.displayMessage(context, 'Action annulée');
              },
              child: const Text('NON'),
            ),
            TextButton(
              onPressed: () async {
                await _authenticationService.deleteUser(context);
                Navigator.of(context).pop();
                Utils.displayMessage(
                    context, "Le compte vient d'être supprimé");
                Navigator.of(context).pop();
              },
              child: const Text('OUI'),
            ),
          ],
        ),
      );
}
