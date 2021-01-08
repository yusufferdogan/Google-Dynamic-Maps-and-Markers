import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarItem extends StatelessWidget {
  final int id;
  final double latitude;
  final double longitude;
  final String state;
  final String type;
  final double heading;

  const CarItem(
      {Key key,
      this.id,
      this.latitude,
      this.longitude,
      this.state,
      this.type,
      this.heading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.black,
          height: 25,
        ),
        Text('id:$id \n'),
        Text('coordinates: { $latitude $longitude } \n'),
        Text('state: $state \n'),
        Text('type: $type \n'),
        Text('heading: $heading'),
      ],
    );
  }
}
