import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/ui/profile/profile_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => locator<ProfileViewModel>(),
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Profile page"),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(locator<AuthenticationService>().weatherUser != null
                        ? locator<AuthenticationService>().weatherUser!.name ??
                            "N/A"
                        : "N/A"),
                    Text(viewModel.displayedError),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                        obscureText: true,
                        controller: viewModel.newPasswordController,
                        onSubmitted: (value) => viewModel.verifyPassword(value),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nouvea mot de passe',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextField(
                        obscureText: true,
                        controller: viewModel.confirmNewPassordController,
                        onSubmitted: (value) => viewModel.verifyPassword(value),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Confirmation du mot de passe',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => viewModel.updateProfile(context),
                      child: const Text('Mettre à jour'),
                    ),
                    GestureDetector(
                      onTap: () => viewModel.deleteProfile(context),
                      child: const Text(
                        'Supprmier le compte',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
