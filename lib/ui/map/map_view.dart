import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:weather/di/dependency_graph.dart';
import 'package:weather/ui/map/map_viewmodel.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapViewModel>.reactive(
      viewModelBuilder: () => locator<MapViewModel>(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: GoogleMap(
            onMapCreated: (controller) {
              setState(() {
                viewModel.mapController = controller;
              });
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(45.833619, 1.261105),
              zoom: 9,
            ),
            zoomControlsEnabled: true,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            myLocationEnabled: false,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: false,
            onLongPress: (pos) {
              setState(() {
                viewModel.addMarker(pos);
              });
            },
            markers: viewModel.markers.toSet(),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.location_on_outlined),
            backgroundColor: const Color(0xff00A1FF),
            onPressed: () {
              setState(() {
                viewModel.pinUserInMap();
              });
            },
          ),
        );
      },
    );
  }
}
