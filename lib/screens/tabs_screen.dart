import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../screens/list_screen.dart';
import '../screens/map_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {
      'page': MapScreen(),
      'title': 'Map',
    },
    {
      'page': ListScreen(),
      'title': 'List',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
//      appBar: AppBar(
//        title: Text(_pages[_selectedPageIndex]['title']),
//      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        selectedFontSize: 20,
        unselectedFontSize: 15,
        backgroundColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
//            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              Icons.location_pin,
              size: 25,
            ),
            title: Text(
              'Map',
            ),
          ),
          BottomNavigationBarItem(
//            backgroundColor: Theme.of(context).accentColor,
            icon: Icon(
              Icons.list,
              size: 25,
            ),
            title: Text(
              'List',
            ),
          ),
        ],
      ),
    );
  }
}
