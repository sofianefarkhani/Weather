import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/model/meteoInCity.dart';
import 'package:weather/services/apiWeather_service.dart';
import 'package:weather/services/authentication_service.dart';

@injectable
class WeatherForeastViewModel extends BaseViewModel {
  final ApiWeather _meteo;
  List<MeteoInCity> _meteos = [];

  List<MeteoInCity> get meteos => _meteos;

  WeatherForeastViewModel(this._meteo);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final CarouselController _carouselController = CarouselController();
  CarouselController get carouselController => _carouselController;

  Future initialize() async {
    await _meteo.getMeteoInTime("Limoges"); 
    if(locator<AuthenticationService>().weatherUser !=null){
      for(var item in locator<AuthenticationService>().weatherUser!.villes!){
        MeteoInCity? meteoDansLaVille = await _meteo.getMeteoInTime(item.toString());
        if(meteoDansLaVille!=null) {
          _meteos.add(meteoDansLaVille);
        }
      }
    }
  }

  carouselChangeCity(int index, CarouselPageChangedReason reason) {}
}
