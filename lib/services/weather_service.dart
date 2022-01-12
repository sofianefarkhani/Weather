import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/model/weather.dart';

@lazySingleton
class WeatherService with ReactiveServiceMixin {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Weather? _weather;

  // GETTERS

  Weather? get weather => _weather;

  // METHODS

  Future addWeatherInFirestore(String currentUID, Weather pWeather) async {}

  displaySnackbarError(BuildContext context, String displayedError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(displayedError, style: const TextStyle(color: Colors.red))),
    );
  }
}
