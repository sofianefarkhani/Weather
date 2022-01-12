import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
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
      builder: (context, viewModel, child) {
        return Scaffold(
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
      },
    );
  }
}
