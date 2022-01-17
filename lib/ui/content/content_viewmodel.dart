import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/ui/profile/profile_view.dart';

@injectable
class ContentViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService;

  ContentViewModel(this._authenticationService);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Future logout() async {
    await _authenticationService.logout();
  }

  Future initialize() async {
    await _authenticationService.getWeatherUserFromFirestore();
    notifyListeners();
  }

  void setIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }

  navigateToProfileView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const ProfilePage(),
      ),
    );
  }
}
