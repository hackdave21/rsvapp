import 'package:flutter/material.dart';
import 'package:rvsapp/core/themes/app_themes.dart';
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
        backgroundColor: AppTheme.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.grey600,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 0 
                  ? AppTheme.primaryColor
                  : AppTheme.grey600,
            ),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/calendar.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 1
                  ? AppTheme.primaryColor
                  : AppTheme.grey600,
            ),
            label: 'Calendrier',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/user.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 2
                  ? AppTheme.primaryColor
                  : AppTheme.grey600,
            ),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/setting.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 3
                  ? AppTheme.primaryColor
                  : AppTheme.grey600,
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