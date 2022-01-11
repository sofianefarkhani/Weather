import 'package:flutter/material.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/services/authentication_service.dart';

class WeatherForecastPage extends StatelessWidget {
  const WeatherForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Je suis connecté"),
            Text(locator<AuthenticationService>().weatherUser != null
                ? locator<AuthenticationService>().weatherUser!.name ?? "N/A"
                : "N/A"),
            const Text("Page avec la liste des météos"),
            ElevatedButton(
              child: const Text("Se déconnecter"),
              onPressed: () {
                locator<AuthenticationService>().logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
