import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
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
        backgroundColor: const Color(0xff030317),
        body: Column(
          children: [
            GlowContainer(
              height: MediaQuery.of(context).size.height - 360,
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.only(
                  top: 50, left: 30, right: 30, bottom: 30),
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
                          locator<ApiWeather>().meteo != null
                              ? Image.network(
                                  'http://openweathermap.org/img/wn/' +
                                      locator<ApiWeather>().meteo!.icon! +
                                      '@4x.png',
                                  fit: BoxFit.contain,
                                  scale: 0.7,
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : const LinearProgressIndicator();
                                  },
                                )
                              : const CircularProgressIndicator(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      locator<ApiWeather>().meteo != null
                                          ? locator<ApiWeather>()
                                              .meteo!
                                              .ville!
                                              .toUpperCase()
                                          : "N/A",
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
                                            text: locator<ApiWeather>().meteo !=
                                                    null
                                                ? locator<ApiWeather>()
                                                        .meteo!
                                                        .temperature! +
                                                    " °C"
                                                : "N/A",
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
                                    locator<ApiWeather>().meteo != null
                                        ? locator<ApiWeather>()
                                            .meteo!
                                            .description!
                                        : "N/A",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: GestureDetector(
                onTap: () {},
                child: const GlowText(
                  'Supprimer la ville',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      /*Scaffold(
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
    )*/
    );
  }
}
