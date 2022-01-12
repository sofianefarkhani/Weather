import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/ui/content/content_view.dart';
import 'package:weather/ui/login/login_viewmodel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => locator<LoginViewModel>(),
      builder: (context, viewModel, child) => Scaffold(
          backgroundColor: const Color(0xff030317),
          body: Column(
            children: [
              GlowContainer(
                height: MediaQuery.of(context).size.height - 230,
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
                      child: Container(
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
                                        controller: viewModel.emailController,
                                        onSubmitted: (value) {
                                          viewModel.verifyEmail(value);
                                        },
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Email',
                                        ),
                                      ),
                                    ),
                                    TextField(
                                      obscureText: true,
                                      controller: viewModel.passwordController,
                                      onSubmitted: (value) =>
                                          viewModel.verifyPassword(value),
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Password',
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
                    /*Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 0.2, color: Colors.white),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        "rrrrrrrs",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),*/
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: GlowButton(
                  onPressed: () => viewModel.login(context),
                  width: 150,
                  child: const Text(
                    "Connexion",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: GestureDetector(
                  onTap: () => viewModel.navigateToRegisterView(context),
                  child: const Text(
                    "Vous n'avez pas de compte ? Inscrivez-vous",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )

          /*Scaffold(
          appBar: AppBar(
            title: const Text("MyLoginPage"),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Connectez-vous',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(viewModel.displayedError),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: viewModel.emailController,
                      onSubmitted: (value) {
                        viewModel.verifyEmail(value);
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    controller: viewModel.passwordController,
                    onSubmitted: (value) => viewModel.verifyPassword(value),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.login(context),
                    child: const Text('Connexion'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: GestureDetector(
                      onTap: () => viewModel.navigateToRegisterView(context),
                      child: const Text(
                          "Vous n'avez pas de compte ? Inscrivez-vous"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },*/
          ),
    );
  }
}
