import './providers/cars.dart';
import './screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Cars(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taxis in Hamburg',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: TabsScreen(),
      ),
    );
  }
}
