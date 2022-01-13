import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/services/apiWeather_service.dart';
import 'package:weather/ui/weatherforecast/weatherforecast_viewmodel.dart';

class WeatherForecastPage extends StatelessWidget {
  const WeatherForecastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WeatherForeastViewModel>.reactive(
      viewModelBuilder: () => locator<WeatherForeastViewModel>(),
      onModelReady: (model) async => await model.initialize(),
      builder: (context, viewModel, child) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Je suis connecté"),
            Text(locator<AuthenticationService>().weatherUser != null
                ? locator<AuthenticationService>().weatherUser!.name ?? "N/A"
                : "N/A"),
            const Text("Page avec la liste des météos"),
            ElevatedButton(
              child: const Text("Se déconnecter"),
              onPressed: () {
                locator<AuthenticationService>().logout();
              },
            ),
            /*
            ElevatedButton(
              child: const Text("getMeteo"),
              onPressed: () {
                locator<apiWeather>().getMeteoInTime("Limoges");
              },
            ),
            */
            locator<ApiWeather>().meteo!=null ?  Image.network('http://openweathermap.org/img/wn/'+ locator<ApiWeather>().meteo!.icon!+'@4x.png',fit: BoxFit.contain, scale: 0.7,
            loadingBuilder: (context, child, progress){
              return progress == null
                ? child
                : const LinearProgressIndicator();
            },)
             
              : const CircularProgressIndicator(),

            Text(locator<ApiWeather>().meteo!= null ?
               "A : "+locator<ApiWeather>().meteo!.ville! +" il fait : " +locator<ApiWeather>().meteo!.temperature! + " avec un temps : " +locator<ApiWeather>().meteo!.description! : "N/A"),
          ],
        ),
      ),
    )
  );
  }
}
