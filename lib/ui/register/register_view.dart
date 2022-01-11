import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/ui/register/register_viewmodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => locator<RegisterViewModel>(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Register page"),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Inscrivez-vous',
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
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: TextField(
                      obscureText: true,
                      controller: viewModel.passwordController,
                      onSubmitted: (value) => viewModel.verifyPassword(value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  TextField(
                    controller: viewModel.nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nom',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.register(context),
                    child: const Text('Envoyer'),
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
