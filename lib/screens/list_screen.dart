import '../widgets/car_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cars.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) {
        Provider.of<Cars>(context, listen: false).fetchAndSetCars();
      },
    );
    super.initState();
  }

  Future<void> _refreshCars(BuildContext context) async {
    await Provider.of<Cars>(context, listen: false).fetchAndSetCars();
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<Cars>(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return _refreshCars(context);
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight,
                  child: ListView.builder(
                    itemCount: carProvider.cars.length,
                    itemBuilder: (context, index) {
                      return CarItem(
                        state: carProvider.cars[index].state,
                        heading: carProvider.cars[index].heading,
                        longitude: carProvider.cars[index].longitude,
                        latitude: carProvider.cars[index].latitude,
                        id: carProvider.cars[index].id,
                        type: carProvider.cars[index].type,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
