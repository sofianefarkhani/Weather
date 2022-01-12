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
        return const Scaffold(
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(45.833619, 1.261105),
              zoom: 15,
            ),
            compassEnabled: false,
            tiltGesturesEnabled: false,
            myLocationEnabled: true,
          ),
        );
      },
    );
  }
}
