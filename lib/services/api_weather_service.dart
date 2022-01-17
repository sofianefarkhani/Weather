import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/model/meteo_in_city.dart';
import 'package:dio/dio.dart';

@lazySingleton
class ApiWeather with ReactiveServiceMixin {
  MeteoInCity? _meteo;
  // GETTERS
  MeteoInCity? get meteo => _meteo;

  Future<MeteoInCity?> getMeteoInTime(String ville) async {
    try {
      var response = await Dio().get(
          'http://api.openweathermap.org/data/2.5/weather?q=' +
              ville +
              '&units=metric&lang=fr&appid=178c2b97a47d94cb40d373de212a8cd0');

      final meteo = MeteoInCity.fromJson(jsonDecode(response.toString()));
      _meteo = meteo;
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
    }
    return meteo;
  }
}
