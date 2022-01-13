import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:geocoding/geocoding.dart';

@injectable
class MapViewModel extends BaseViewModel {
  GoogleMapController? mapController;

  Set<Marker> markers = {};

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

  Future getCurrentLocation() async {}
}
