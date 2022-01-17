import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/model/meteo_in_city.dart';
import 'package:weather/services/api_weather_service.dart';
import 'package:weather/ui/weatherforecast/weatherforecast_viewmodel.dart';
import 'package:weather/utils/utils.dart';

@injectable
class MapViewModel extends BaseViewModel {
  GoogleMapController? mapController;

  Set<Marker> markers = {};

  late MeteoInCity _meteoOnMap;
  MeteoInCity get meteoOnMap => _meteoOnMap;

  bool _meteoPresentInList = false;
  bool get meteoPresentInList => _meteoPresentInList;

  //partie firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String getCurrentUID() {
    String uid = '';
    if (_auth.currentUser != null) {
      uid = _auth.currentUser!.uid;
    }
    return uid;
  }

  Future addMarker(BuildContext context, LatLng pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    String? cityName = placemarks.first.locality;
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: pos,
          zoom: 10,
        ),
      ),
    );
    await checkAndDisplayMeteoOnPoint(cityName!);
    markers.add(
      Marker(
        markerId: const MarkerId("id"),
        position: pos,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              cityName.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            content: RichText(
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    child: Icon(
                      Icons.thermostat_rounded,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: _meteoOnMap.temperature! + " °C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Utils.displayMessage(context, "La ville n'a pas été ajoutée");
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  addCity(_meteoOnMap);
                  Utils.displayMessage(
                      context, "La ville vient d'être ajoutée");
                },
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    notifyListeners();
  }

  void addCity(MeteoInCity ville) {
    var listVille = [];
    listVille.add(ville.ville);
    var userInfo = _firestore.collection('users').doc(getCurrentUID());
    userInfo.update({
      'ville': FieldValue.arrayUnion(listVille),
    });
    locator<WeatherForeastViewModel>().addMeteoObj(ville);
    notifyListeners();
  }

  Future pinUserInMap(BuildContext context) async {
    Position _position = await determinePosition();
    LatLng _currentPos = LatLng(_position.latitude, _position.longitude);
    await addMarker(context, _currentPos);
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPos,
          zoom: 9,
        ),
      ),
    );
    notifyListeners();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future checkAndDisplayMeteoOnPoint(String villeName) async {
    //si on change de ville on verifie bien que la presence du nom de la ville soi a faut avant de regarder si elle y est
    if (_meteoPresentInList) {
      _meteoPresentInList = false;
    }

    for (var item in locator<WeatherForeastViewModel>().meteos) {
      if (item.ville == villeName) {
        _meteoPresentInList = true;
      }
    }
    MeteoInCity? meteoDansLaVille =
        await locator<ApiWeather>().getMeteoInTime(villeName);
    if (meteoDansLaVille != null) {
      _meteoOnMap = meteoDansLaVille;
    }
  }
}
