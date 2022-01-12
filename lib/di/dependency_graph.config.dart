// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../services/authentication_service.dart' as _i3;
import '../services/weather_service.dart' as _i9;
import '../ui/content/content_viewmodel.dart' as _i4;
import '../ui/login/login_viewmodel.dart' as _i5;
import '../ui/map/map_viewmodel.dart' as _i6;
import '../ui/profile/profile_viewmodel.dart' as _i7;
import '../ui/register/register_viewmodel.dart'
    as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AuthenticationService>(
      () => _i3.AuthenticationService());
  gh.factory<_i4.ContentViewModel>(
      () => _i4.ContentViewModel(get<_i3.AuthenticationService>()));
  gh.factory<_i5.LoginViewModel>(
      () => _i5.LoginViewModel(get<_i3.AuthenticationService>()));
  gh.factory<_i6.MapViewModel>(() => _i6.MapViewModel());
  gh.factory<_i7.ProfileViewModel>(
      () => _i7.ProfileViewModel(get<_i3.AuthenticationService>()));
  gh.factory<_i8.RegisterViewModel>(
      () => _i8.RegisterViewModel(get<_i3.AuthenticationService>()));
  gh.lazySingleton<_i9.WeatherService>(() => _i9.WeatherService());
  return get;
}
