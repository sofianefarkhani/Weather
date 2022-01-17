import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/model/user.dart';
import 'package:weather/services/authentication_service.dart';
import 'package:weather/ui/content/content_viewmodel.dart';
import 'package:weather/ui/map/map_view.dart';
import 'package:weather/ui/weatherforecast/weatherforecast_view.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContentViewModel>.reactive(
      viewModelBuilder: () => locator<ContentViewModel>(),
      onModelReady: (model) async => await model.initialize(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Weather"),
          actions: [
            Container(child: Row(
              children: [
                Text(locator<AuthenticationService>().weatherUser!.name.toString()),
                IconButton(
                  onPressed: () {
                    viewModel.logout();
                  },
                  icon: const Icon(Icons.logout),
      
                ),
              ],
            ) ,)
            
          ],
          leading: IconButton(
            onPressed: () => {viewModel.navigateToProfileView(context)},
            icon: const Icon(Icons.account_circle_rounded),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff030317),
          selectedItemColor: const Color(0xff00A1FF),
          unselectedItemColor: Colors.white,
          onTap: (newIndex) => viewModel.setIndex(newIndex),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.apartment),
              label: "Villes",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
            ),
          ],
          currentIndex: viewModel.currentIndex,
        ),
        body: const [WeatherForecastPage(), MapPage()]
            .elementAt(viewModel.currentIndex),
      ),
    );
  }
}
