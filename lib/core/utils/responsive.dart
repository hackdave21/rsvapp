import 'package:flutter/material.dart';

class Responsive {
  static const double mobileMaxWidth = 600;
  static const double tabletMaxWidth = 1024;
  static const double desktopMinWidth = 1025;
  
  // Breakpoints
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWidth;
  
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMaxWidth &&
      MediaQuery.of(context).size.width < desktopMinWidth;
  
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopMinWidth;
  
  // Obtenir la largeur de l'écran
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;
  
  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
  
  // Obtenir un pourcentage de la largeur/hauteur
  static double widthPercent(BuildContext context, double percent) =>
      width(context) * (percent / 100);
  
  static double heightPercent(BuildContext context, double percent) =>
      height(context) * (percent / 100);
  
  // Padding/Margin adaptatifs
  static EdgeInsets padding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }
  
  static EdgeInsets horizontalPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 32.0);
    } else {
      return const EdgeInsets.symmetric(horizontal: 64.0);
    }
  }
  
  static EdgeInsets verticalPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(vertical: 16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(vertical: 24.0);
    } else {
      return const EdgeInsets.symmetric(vertical: 32.0);
    }
  }
  
  // Tailles de police adaptatives
  static double fontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) {
      return baseSize;
    } else if (isTablet(context)) {
      return baseSize * 1.1;
    } else {
      return baseSize * 1.2;
    }
  }
  
  // Espacement adaptatif
  static double spacing(BuildContext context) {
    if (isMobile(context)) {
      return 8.0;
    } else if (isTablet(context)) {
      return 12.0;
    } else {
      return 16.0;
    }
  }
  
  // Taille d'icône adaptive
  static double iconSize(BuildContext context, {double base = 24.0}) {
    if (isMobile(context)) {
      return base;
    } else if (isTablet(context)) {
      return base * 1.2;
    } else {
      return base * 1.4;
    }
  }
  
  // Hauteur de bouton adaptive
  static double buttonHeight(BuildContext context) {
    if (isMobile(context)) {
      return 48.0;
    } else if (isTablet(context)) {
      return 52.0;
    } else {
      return 56.0;
    }
  }
  
  // Largeur maximale pour le contenu
  static double maxContentWidth(BuildContext context) {
    final screenWidth = width(context);
    if (isMobile(context)) {
      return screenWidth;
    } else if (isTablet(context)) {
      return screenWidth * 0.9;
    } else {
      return 1200.0; // Largeur fixe pour desktop
    }
  }
  
  // Grid columns adaptatif
  static int gridColumns(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 3}) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }
  
  // Card width adaptive
  static double cardWidth(BuildContext context) {
    final screenWidth = width(context);
    if (isMobile(context)) {
      return screenWidth - 32; // Padding des deux côtés
    } else if (isTablet(context)) {
      return (screenWidth - 96) / 2; // 2 cartes par ligne
    } else {
      return (screenWidth - 128) / 3; // 3 cartes par ligne
    }
  }
}

// Extension pour utilisation plus facile
extension ResponsiveExtension on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  
  double get screenWidth => Responsive.width(this);
  double get screenHeight => Responsive.height(this);
  
  EdgeInsets get responsivePadding => Responsive.padding(this);
  EdgeInsets get responsiveHorizontalPadding => Responsive.horizontalPadding(this);
  EdgeInsets get responsiveVerticalPadding => Responsive.verticalPadding(this);
  
  double responsiveFontSize(double baseSize) => Responsive.fontSize(this, baseSize);
  double get responsiveSpacing => Responsive.spacing(this);
  double responsiveIconSize({double base = 24.0}) => Responsive.iconSize(this, base: base);
  double get responsiveButtonHeight => Responsive.buttonHeight(this);
  double get maxContentWidth => Responsive.maxContentWidth(this);
}