import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rvsapp/presentation/themes/app_themes.dart';
import 'text_styles.dart';

class LightTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppTheme.primaryColor,
      scaffoldBackgroundColor: AppTheme.white,
      cardColor: AppTheme.white,
      dividerColor: AppTheme.grey300,
      
      // theme de l'appbar
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: AppTheme.white,
        elevation: 2,
        titleTextStyle: TextStyles.headline6.copyWith(color: AppTheme.white),
        iconTheme: IconThemeData(color: AppTheme.white),
      ),
      
      // thème pour les textes
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        displayLarge: TextStyles.displayLarge.copyWith(color: AppTheme.grey900),
        displayMedium: TextStyles.displayMedium.copyWith(color: AppTheme.grey900),
        displaySmall: TextStyles.displaySmall.copyWith(color: AppTheme.grey900),
        headlineLarge: TextStyles.headlineLarge.copyWith(color: AppTheme.grey900),
        headlineMedium: TextStyles.headlineMedium.copyWith(color: AppTheme.grey900),
        headlineSmall: TextStyles.headlineSmall.copyWith(color: AppTheme.grey900),
        titleLarge: TextStyles.titleLarge.copyWith(color: AppTheme.grey900),
        titleMedium: TextStyles.titleMedium.copyWith(color: AppTheme.grey900),
        titleSmall: TextStyles.titleSmall.copyWith(color: AppTheme.grey700),
        bodyLarge: TextStyles.bodyLarge.copyWith(color: AppTheme.grey800),
        bodyMedium: TextStyles.bodyMedium.copyWith(color: AppTheme.grey700),
        bodySmall: TextStyles.bodySmall.copyWith(color: AppTheme.grey600),
        labelLarge: TextStyles.labelLarge.copyWith(color: AppTheme.grey900),
        labelMedium: TextStyles.labelMedium.copyWith(color: AppTheme.grey700),
        labelSmall: TextStyles.labelSmall.copyWith(color: AppTheme.grey600),
      ),
      
      // thème pour les boutons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.white,
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: TextStyles.labelLarge,
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(color: AppTheme.primaryColor),
          textStyle: TextStyles.labelLarge,
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppTheme.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: TextStyles.labelLarge,
        ),
      ),
      
      //thème des input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppTheme.grey100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.grey300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.errorColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: TextStyles.bodyMedium.copyWith(color: AppTheme.grey500),
        labelStyle: TextStyles.bodyMedium.copyWith(color: AppTheme.grey700),
      ),
      
      // theme de la card
      cardTheme: CardThemeData(
        color: AppTheme.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(8),
        
      ),
      
      //theme de Bottom Navigation Bar 
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppTheme.white,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.grey500,
        selectedLabelStyle: TextStyles.labelSmall,
        unselectedLabelStyle: TextStyles.labelSmall,
        type: BottomNavigationBarType.fixed,
      ),
       colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        background: AppTheme.white,
        surface: AppTheme.white,
      ),
    );
  }
}