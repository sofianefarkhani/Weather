import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
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
            CarouselSlider(
              carouselController: viewModel.carouselController,
              items: viewModel.meteos.map((meteo) {
                return GlowContainer(
                  height: MediaQuery.of(context).size.height - 360,
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.only(
                      top: 50, left: 20, right: 20, bottom: 30),
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
                                    meteo.icon! +
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Text(
                                          meteo.ville!.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
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
                                                text:
                                                    meteo.temperature! + " °C",
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
                                        meteo.description.toString(),
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
              }).toList(),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                height: MediaQuery.of(context).size.height - 360,
                viewportFraction: 1,
                onPageChanged: (index, reason) =>
                    viewModel.carouselChangeCity(index, reason),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: GestureDetector(
                onTap: () => {
                  viewModel.deleteCityOfList(viewModel
                      .meteos[viewModel.currentIndex].ville!
                      .toString())
                },
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
    );
  }
}
