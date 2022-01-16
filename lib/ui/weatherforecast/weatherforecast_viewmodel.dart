import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/model/meteoInCity.dart';
import 'package:weather/services/apiWeather_service.dart';
import 'package:weather/services/authentication_service.dart';

@injectable
class WeatherForeastViewModel extends BaseViewModel {
  final ApiWeather _meteo;
  final List<MeteoInCity> _meteos = [];

  List<MeteoInCity> get meteos => _meteos;

  WeatherForeastViewModel(this._meteo);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final CarouselController _carouselController = CarouselController();
  CarouselController get carouselController => _carouselController;

  Future initialize() async {
    await _meteo.getMeteoInTime("Limoges");
    if (locator<AuthenticationService>().weatherUser != null) {
      for (var item in locator<AuthenticationService>().weatherUser!.villes!) {
        MeteoInCity? meteoDansLaVille =
            await _meteo.getMeteoInTime(item.toString());
        if (meteoDansLaVille != null) {
          _meteos.add(meteoDansLaVille);
          print(_meteos.last.ville);
        }
      }
    }
    notifyListeners();
  }

  void carouselChangeCity(int index, CarouselPageChangedReason reason) {
    _currentIndex = index;
  }

  void addCityInCarousel(BuildContext context, MeteoInCity meteoInCity) {
    print("Name of city : " + meteoInCity.ville!);
    GlowContainer(
      height: MediaQuery.of(context).size.height - 360,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
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
                  Image.network(
                    'http://openweathermap.org/img/wn/' +
                        meteoInCity.icon! +
                        '@4x.png',
                    fit: BoxFit.contain,
                    scale: 0.7,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const LinearProgressIndicator();
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              meteoInCity.ville!.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.thermostat_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: meteoInCity.temperature! + " °C",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            meteoInCity.description.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
