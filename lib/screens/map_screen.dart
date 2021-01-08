import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cars.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<Cars>(context, listen: false).fetchAndSetCars();
    addMarkers();
    super.didChangeDependencies();
  }

  Future<void> _refreshCars(BuildContext context) async {
    await Provider.of<Cars>(context, listen: false).fetchAndSetCars();
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(53.5637, 9.9654);

  Set<Marker> _markers = {};

  BitmapDescriptor pinLocationIcon;
  @override
  void initState() {
    super.initState();
  }

  Future<void> addMarkers() async {
    final carProvider = Provider.of<Cars>(context, listen: false);
    await _refreshCars(context);
    setState(() {
      for (var i = 0; i < carProvider.cars.length; i++) {
        _markers.add(
          Marker(
            markerId: MarkerId(carProvider.cars[i].id.toString()),
            position: LatLng(
              carProvider.cars[i].latitude,
              carProvider.cars[i].longitude,
            ),
            infoWindow: InfoWindow(
              title: carProvider.cars[i].state,
              snippet: carProvider.cars[i].type,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet,
            ),
          ),
        );
        print(carProvider.cars.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              addMarkers();
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12,
              bearing: 15.0, // 1
              tilt: 75.0,
            ),
            markers: _markers,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.refresh),
          onPressed: () => addMarkers(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }
}
