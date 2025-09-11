import 'package:flutter/material.dart';
import 'package:rvsapp/features/presentation/pages/screens/calendar_screen.dart';
import 'package:rvsapp/features/presentation/pages/screens/home_screen.dart';
import 'package:rvsapp/features/presentation/pages/screens/profile_screen.dart';
import 'package:rvsapp/features/presentation/pages/screens/settings_screen.dart';

class MainhomeScreen extends StatefulWidget {
  const MainhomeScreen({super.key});

  @override
  State<MainhomeScreen> createState() => _MainhomeScreenState();
}

class _MainhomeScreenState extends State<MainhomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> widgetOptions = [
    HomeScreen(),
    CalendarScreen(),
    ProfileScreen(),
    SettingsScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 2, 70, 125),
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 0 
                  ? const Color.fromARGB(255, 2, 70, 125)
                  : Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/calendar.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 1
                  ? const Color.fromARGB(255, 2, 70, 125)
                  : Colors.black,
            ),
            label: 'Calendrier',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/user.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 2
                  ? const Color.fromARGB(255, 2, 70, 125)
                  : Colors.black,
            ),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/setting.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 3
                  ? const Color.fromARGB(255, 2, 70, 125)
                  : Colors.black,
            ),
            label: 'Paramètres',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}