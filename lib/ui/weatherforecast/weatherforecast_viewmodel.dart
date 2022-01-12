import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/services/apiWeather_service.dart';


@injectable
class WeatherForeastViewModel extends BaseViewModel {
  final ApiWeather _meteo;

  WeatherForeastViewModel(this._meteo);

  Future initialize() async {
    await _meteo.getMeteoInTime("Limoges");
  }

}
