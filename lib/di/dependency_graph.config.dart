// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/api_weather_service.dart' as _i3;
import '../services/authentication_service.dart' as _i4;
import '../ui/content/content_viewmodel.dart' as _i5;
import '../ui/login/login_viewmodel.dart' as _i6;
import '../ui/map/map_viewmodel.dart' as _i7;
import '../ui/profile/profile_viewmodel.dart' as _i8;
import '../ui/register/register_viewmodel.dart' as _i9;
import '../ui/weatherforecast/weatherforecast_viewmodel.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.ApiWeather>(() => _i3.ApiWeather());
  gh.lazySingleton<_i4.AuthenticationService>(
      () => _i4.AuthenticationService());
  gh.factory<_i5.ContentViewModel>(
      () => _i5.ContentViewModel(get<_i4.AuthenticationService>()));
  gh.factory<_i6.LoginViewModel>(
      () => _i6.LoginViewModel(get<_i4.AuthenticationService>()));
  gh.factory<_i7.MapViewModel>(() => _i7.MapViewModel());
  gh.factory<_i8.ProfileViewModel>(
      () => _i8.ProfileViewModel(get<_i4.AuthenticationService>()));
  gh.factory<_i9.RegisterViewModel>(
      () => _i9.RegisterViewModel(get<_i4.AuthenticationService>()));
  gh.factory<_i10.WeatherForeastViewModel>(
      () => _i10.WeatherForeastViewModel(get<_i3.ApiWeather>()));
  return get;
}
