import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // <-- nécessaire pour SystemUiOverlayStyle
import 'package:rvsapp/presentation/themes/app_themes.dart';
import 'package:rvsapp/presentation/pages/screens/calendar_screen.dart';
import 'package:rvsapp/presentation/pages/screens/home_screen.dart';
import 'package:rvsapp/presentation/pages/screens/profile_screen.dart';
import 'package:rvsapp/presentation/pages/screens/settings_screen.dart';

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
    final navColor = AppTheme.white;

    // SystemUiOverlayStyle pour status bar et navigation bar
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent pour voir ton background
      statusBarIconBrightness: Brightness.dark, // icônes sombres (Android)
      statusBarBrightness: Brightness.light,    // texte noir (iOS)
      systemNavigationBarColor: navColor,       // couleur du bottom nav
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SafeArea(
        top: false,
        bottom: true,
        child: BottomNavigationBar(
          backgroundColor: navColor,
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
      ),
    );
  }
}