import 'package:flutter/material.dart';
import 'package:rvsapp/core/themes/app_themes.dart';
import 'package:rvsapp/core/themes/text_styles.dart';
import 'package:rvsapp/features/presentation/pages/auth/registerpage.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(color: AppTheme.white),
                ),
                
                Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/onboarding.png',
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
                
                // Contenu textuel
                Positioned(
                  top: 420,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Text(
                          "Bienvenue sur RVS App",
                          style: TextStyles.headlineMedium.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Découvrez toutes les fonctionnalités de notre application "
                          "pour gérer vos rendez-vous et services en toute simplicité.",
                          style: TextStyles.bodyLarge.copyWith(
                            color: AppTheme.grey700,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Bouton en bas de l'écran
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      // Bouton principal
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: AppTheme.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            'Commencer',
                            style: TextStyles.buttonLarge.copyWith(
                              color: AppTheme.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Indicateur de page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppTheme.grey400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppTheme.grey400,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}