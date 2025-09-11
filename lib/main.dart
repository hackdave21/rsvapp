import 'package:flutter/material.dart';
import 'package:rvsapp/core/themes/app_themes.dart';
import 'package:rvsapp/features/presentation/pages/onboarding_screen.dart';
import 'package:provider/provider.dart';
import 'package:rvsapp/shared/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'KING DAVE APP',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          home: OnboardingScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}