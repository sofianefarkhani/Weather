import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/model/meteoInCity.dart';
import 'package:dio/dio.dart';
import 'package:weather/model/weather.dart';

@lazySingleton
class ApiWeather with ReactiveServiceMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  MeteoInCity? _meteo;
  // GETTERS
  MeteoInCity? get meteo => _meteo;
  

  Future<MeteoInCity?> getMeteoInTime(String ville) async{

    try{
        var response = await Dio().get('http://api.openweathermap.org/data/2.5/weather?q='+ville+'&units=metric&lang=fr&appid=178c2b97a47d94cb40d373de212a8cd0');
        
        final meteo = MeteoInCity.fromJson(jsonDecode(response.toString()));
        _meteo = meteo;
       
    }
    catch(ex){
      print(ex.toString());

    }
    return meteo;
  }


}