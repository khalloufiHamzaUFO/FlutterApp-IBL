import 'package:auth_app/InteriorViews/Chart.dart';
import 'package:auth_app/InteriorViews/ListPage.dart';
import 'package:auth_app/InteriorViews/NotesPage.dart';
import 'package:auth_app/InteriorViews/Setting.dart';
import 'package:flutter/material.dart';

import '../InteriorViews/HomePage.dart';



const TextStyle _textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  int _CurrentIndex = 0 ;
  final List<Widget> pages =[
    HomePage(),
    HistoryData(),
    NotesPage(),
    GraphScreen(),
    SettingsScreen()
  ];

  void onTappedBar(int index){
    setState(() {
      _CurrentIndex= index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Center(
          child: pages[_CurrentIndex],
        ),


        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.teal.withOpacity(0.5),
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ), child: NavigationBar(
          backgroundColor: Colors.white,
          animationDuration: const Duration(seconds: 1),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 60,
          selectedIndex: _CurrentIndex,
          onDestinationSelected: (int newIndex){
            setState(() {
              _CurrentIndex = newIndex;
            });
          },
          destinations: const[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon (Icons.list),
              icon: Icon(Icons.list_outlined),
              label: 'List',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_comment_rounded),
              label: 'Notes',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bar_chart),
              icon: Icon(Icons.bar_chart_outlined),
              label: 'Chart',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
        ),
        )

    );
  }
}

