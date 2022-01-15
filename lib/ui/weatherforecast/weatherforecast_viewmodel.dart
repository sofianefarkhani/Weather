import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/apiWeather_service.dart';

@injectable
class WeatherForeastViewModel extends BaseViewModel {
  final ApiWeather _meteo;

  WeatherForeastViewModel(this._meteo);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final CarouselController _carouselController = CarouselController();
  CarouselController get carouselController => _carouselController;

  Future initialize() async {
    await _meteo.getMeteoInTime("Limoges");
  }

  carouselChangeCity(int index, CarouselPageChangedReason reason) {}
}
