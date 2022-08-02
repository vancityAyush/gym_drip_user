import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twsuser/apiService/apimanager.dart';
import 'package:twsuser/screen/account.dart';
import 'package:twsuser/screen/homes.dart';
import 'package:twsuser/screen/mycheckin.dart';
import 'package:twsuser/screen/mytrainer.dart';

import 'feedlist.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _widgetOptios = [
    Homes(),
    MyCheckin(),
    FeedList(),
    MyTrainer(),
    AccountFragment()
  ];

  @override
  void initState() {
    Provider.of<ApiManager>(context, listen: false).fetchProfileApi();
    super.initState();
  }

  @override
  Widget build(Object context) {
    return Scaffold(
      body: Center(
        child: _widgetOptios.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/gallery.png",
              color: Colors.white,
              width: 34,
              height: 31,
            ),
            label: "Gallery",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/chekc.png",
              color: Colors.white,
              width: 34,
              height: 31,
            ),
            label: "Checkin",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/feeds.png",
              color: Colors.white,
              width: 34,
              height: 31,
            ),
            label: "Feeds",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/trainer.png",
              color: Colors.white,
              width: 34,
              height: 31,
            ),
            label: "Trainer",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/account.png",
              color: Colors.white,
              width: 34,
              height: 31,
            ),
            label: "Account",
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.black87,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
