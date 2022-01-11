import 'package:flutter/material.dart';

class WeatherForecastPage extends StatelessWidget {
  const WeatherForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: const Center(
        child: Text("Page avec la liste des météos"),
      ),
    );
  }
}
