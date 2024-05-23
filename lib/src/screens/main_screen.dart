import 'package:flutter/material.dart';
import 'package:watchncook/src/helper/constants.dart';
import 'package:watchncook/src/screens/favourite_screen.dart';
import 'package:watchncook/src/screens/home_screen.dart';
import 'package:watchncook/src/screens/profile_screen.dart';
import 'package:watchncook/src/screens/search_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  int newindex;
  MainScreen({this.newindex = 0, super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentIndex = widget.newindex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.black.withOpacity(0.7),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 24,
            ),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 24,
            ),
            label: 'favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      case 2:
        return const FavouriteScreen();
      case 3:
        return  ProfileScreen();
      default:
        return const Center(child: Text('Invalid Page'));
    }
  }
}
