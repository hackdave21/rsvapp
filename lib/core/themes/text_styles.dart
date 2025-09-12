import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // police principale (Roboto)
  static TextStyle get _baseStyle => GoogleFonts.roboto();
  
  // police secondaire (Poppins)
  static TextStyle get _secondaryStyle => GoogleFonts.poppins();
  
  // poppins pour les titres importants
  static TextStyle get displayLarge => _secondaryStyle.copyWith(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
  );
  
  static TextStyle get displayMedium => _secondaryStyle.copyWith(
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
  );
  
  static TextStyle get displaySmall => _secondaryStyle.copyWith(
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
  );
  
  //  pour les en-têtes
  static TextStyle get headlineLarge => _secondaryStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.25,
  );
  
  static TextStyle get headlineMedium => _secondaryStyle.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.29,
  );
  
  static TextStyle get headlineSmall => _secondaryStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
  );
  
  // pour les titre (Poppins)
  static TextStyle get titleLarge => _secondaryStyle.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.27,
  );
  
  static TextStyle get titleMedium => _secondaryStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
  );
  
  static TextStyle get titleSmall => _secondaryStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  // roboto pour le contenu dans le body 
  static TextStyle get bodyLarge => _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
  );
  
  static TextStyle get bodyMedium => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );
  
  static TextStyle get bodySmall => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  // roboto pour les labels des textfield
  static TextStyle get labelLarge => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  static TextStyle get labelMedium => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );
  
  static TextStyle get labelSmall => _baseStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );
  
  // styles personnalisés
  static TextStyle get caption => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  static TextStyle get overline => _baseStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    height: 1.6,
  );
  
  // styles pour les boutons
  static TextStyle get buttonLarge => _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
  
  static TextStyle get buttonMedium => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.25,
  );
  
  static TextStyle get buttonSmall => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
  );
  
  // styles pour les erreurs
  static TextStyle get error => _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );
  
  // styles pour les liens avec roboto
  static TextStyle get link => _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    decoration: TextDecoration.underline,
  );
  
  // compatibilité
  static TextStyle get headline1 => displayLarge;
  static TextStyle get headline2 => displayMedium;
  static TextStyle get headline3 => displaySmall;
  static TextStyle get headline4 => headlineMedium;
  static TextStyle get headline5 => headlineSmall;
  static TextStyle get headline6 => titleLarge;
  static TextStyle get subtitle1 => titleMedium;
  static TextStyle get subtitle2 => titleSmall;
  static TextStyle get bodyText1 => bodyLarge;
  static TextStyle get bodyText2 => bodyMedium;
  static TextStyle get button => labelLarge;
}