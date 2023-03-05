import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_solution/screens/contact_options_screen.dart';
import 'package:google_solution/screens/profile_screen.dart';
import 'package:google_solution/screens/settings_screen.dart';
import 'package:google_solution/utilities/constants.dart';

class MainPage extends StatefulWidget {
  static const String id = 'Main';
  @override
  // TODO: implement key
  Key? get key => super.key;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;
  final screens = [ProfileScreen(), ContactOptionsScreen(), SettingsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 450),
        transitionBuilder: (Widget child, Animation<double> primaryAnimation,
                Animation<double> secondaryAnimation) =>
            SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          fillColor: kBackgroundColor,
          child: child,
        ),
        child: screens[_currentIndex],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: kBackgroundColor),
        child: BottomNavigationBar(
          elevation: 100,
          iconSize: kBottomIconSize,
          type: BottomNavigationBarType.shifting,
          backgroundColor: kBackgroundColor,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_2_outlined,
                  color: kCirclesColor,
                ),
                activeIcon: Icon(
                  Icons.person_2_sharp,
                  color: kCirclesColor,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: kCirclesColor,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: kCirclesColor,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  color: kCirclesColor,
                ),
                activeIcon: Icon(
                  Icons.settings,
                  color: kCirclesColor,
                ),
                label: ""),
          ],
        ),
      ),
    );
  }
}
