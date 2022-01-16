import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:geocoding/geocoding.dart';

@injectable
class MapViewModel extends BaseViewModel {
  GoogleMapController? mapController;

  Set<Marker> markers = {};

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

  Future addMarker(LatLng pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    String? city = placemarks.first.locality;
    markers.add(Marker(
      markerId: const MarkerId("id"),
      position: pos,
      infoWindow: InfoWindow(
        title: city,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
  }

  void addCity(String ville){
    var listVille = [];
    listVille.add(ville);
     var userInfo = _firestore.collection('users').doc(getCurrentUID());
      userInfo.update({'villes': FieldValue.arrayUnion(listVille), });
  }

  Future getCurrentLocation() async {}
}
