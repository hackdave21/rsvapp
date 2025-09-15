import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rvsapp/presentation/themes/app_themes.dart';
import 'text_styles.dart';

class DarkTheme {
  static ThemeData get theme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppTheme.primaryColor,
      scaffoldBackgroundColor: AppTheme.grey900,
      cardColor: AppTheme.grey800,
      dividerColor: AppTheme.grey600,

      // theme de l'appbar
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.grey900,
        foregroundColor: AppTheme.white,
        elevation: 2,
        titleTextStyle: TextStyles.headline6.copyWith(color: AppTheme.white),
        iconTheme: IconThemeData(color: AppTheme.white),
      ),

      // thème pour les textes
      textTheme: GoogleFonts.robotoTextTheme().copyWith(
        displayLarge: TextStyles.displayLarge.copyWith(color: AppTheme.white),
        displayMedium: TextStyles.displayMedium.copyWith(color: AppTheme.white),
        displaySmall: TextStyles.displaySmall.copyWith(color: AppTheme.white),
        headlineLarge: TextStyles.headlineLarge.copyWith(color: AppTheme.white),
        headlineMedium: TextStyles.headlineMedium.copyWith(
          color: AppTheme.white,
        ),
        headlineSmall: TextStyles.headlineSmall.copyWith(color: AppTheme.white),
        titleLarge: TextStyles.titleLarge.copyWith(color: AppTheme.white),
        titleMedium: TextStyles.titleMedium.copyWith(color: AppTheme.white),
        titleSmall: TextStyles.titleSmall.copyWith(color: AppTheme.grey300),
        bodyLarge: TextStyles.bodyLarge.copyWith(color: AppTheme.grey200),
        bodyMedium: TextStyles.bodyMedium.copyWith(color: AppTheme.grey300),
        bodySmall: TextStyles.bodySmall.copyWith(color: AppTheme.grey400),
        labelLarge: TextStyles.labelLarge.copyWith(color: AppTheme.white),
        labelMedium: TextStyles.labelMedium.copyWith(color: AppTheme.grey300),
        labelSmall: TextStyles.labelSmall.copyWith(color: AppTheme.grey400),
      ),

      // thème pour les boutons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: AppTheme.white,
          elevation: 2,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: TextStyles.labelLarge,
        ),
      ),

      //thème des input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppTheme.grey800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.grey600),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppTheme.grey600),
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
        labelStyle: TextStyles.bodyMedium.copyWith(color: AppTheme.grey300),
      ),

      // thème de la card
       cardTheme: CardThemeData(
        color: AppTheme.grey800,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.all(8),
      ),

      // theme de Bottom Navigation Bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppTheme.grey900,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.grey500,
        selectedLabelStyle: TextStyles.labelSmall,
        unselectedLabelStyle: TextStyles.labelSmall,
        type: BottomNavigationBarType.fixed,
      ),
     colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
  background: AppTheme.grey900, // ou votre couleur de fond sombre
  surface: AppTheme.grey800,
),
    );
  }
}
