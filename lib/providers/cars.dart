import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Car {
  final int id;
  final double latitude;
  final double longitude;
  final String state;
  final String type;
  final double heading;

  Car({
    this.id,
    this.latitude,
    this.longitude,
    this.state,
    this.type,
    this.heading,
  });
}

class Cars with ChangeNotifier {
  List<Car> _cars = [];
  List<Car> get cars {
    return [..._cars];
  }

  Future<void> fetchAndSetCars() async {
    const url =
        'https://poi-api.mytaxi.com/PoiService/poi/v1?p2Lat=53.394655&p1Lon=9.757589&p1Lat=53.694865&p2Lon=10.099891';
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final comingData = json.decode(response.body) as Map<String, dynamic>;
      print(comingData);
      final extractedData = comingData['poiList'];
      print(extractedData);
      final List<Car> loadedCars = [];
      extractedData.forEach(
        (carData) {
          var id = (carData['id']);
          var latitude = (carData['coordinate']['latitude']);
          var longitude = (carData['coordinate']['longitude']);
          var state = (carData['state']);
          var type = (carData['type']);
          var heading = (carData['heading']);
          loadedCars.add(
            Car(
              latitude: latitude,
              longitude: longitude,
              heading: heading,
              state: state,
              type: type,
              id: id,
            ),
          );
        },
      );
      _cars = loadedCars;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
