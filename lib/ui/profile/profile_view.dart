import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
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
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Mon profil"),
          backgroundColor: const Color(0xff00A1FF),
        ),
        backgroundColor: const Color(0xff030317),
        body: Column(
          children: [
            GlowContainer(
              height: MediaQuery.of(context).size.height - 330,
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
              glowColor: const Color(0xff00A1FF).withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              color: const Color(0xff00A1FF),
              spreadRadius: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 430,
                      child: Stack(
                        children: [
                          const Image(
                            image: AssetImage("assets/sunny_2d.png"),
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: TextField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      cursorColor: Colors.white,
                                      obscureText: true,
                                      controller:
                                          viewModel.newPasswordController,
                                      onSubmitted: (value) => viewModel
                                          .verifyPassword(context, value),
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        labelText: 'Nouvea mot de passe',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: TextField(
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      cursorColor: Colors.white,
                                      obscureText: true,
                                      controller:
                                          viewModel.confirmNewPassordController,
                                      onSubmitted: (value) => viewModel
                                          .verifyPassword(context, value),
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        labelText:
                                            'Confirmation du mot de passe',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: GlowButton(
                onPressed: () => viewModel.updateProfile(context),
                width: 150,
                child: const Text(
                  "Mettre à jour",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: GestureDetector(
                onTap: () => viewModel.deleteProfile(context),
                child: const GlowText(
                  'Supprmier le compte',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
