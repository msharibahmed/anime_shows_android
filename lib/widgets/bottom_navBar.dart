import 'package:anime_shows_android/screens/downloads.dart';
import 'package:anime_shows_android/screens/home_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var index = 0;
  var screens = [Home(), DownloadScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (item) {
          setState(() {
            index = item;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_sharp), label: 'Downloads')
        ],
      ),
      body: screens[index],
    );
  }
}
