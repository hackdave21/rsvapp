import 'package:flutter/material.dart';
import 'package:rvsapp/presentation/themes/app_themes.dart';
import 'package:rvsapp/presentation/themes/text_styles.dart';
import 'package:rvsapp/presentation/pages/mainhome_screen.dart';
import 'package:rvsapp/presentation/pages/screens/home_screen.dart';
import 'package:rvsapp/presentation/widgets/custom_snackbar.dart';
import 'package:rvsapp/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simuler un appel API
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      // Navigation vers l'écran principal
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainhomeScreen()),
      );

      CustomSnackbar.showSuccess(context, 'Connexion réussie!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Titre
                Text(
                  'Connexion',
                  style: TextStyles.headlineLarge.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Connectez-vous à votre compte',
                  style: TextStyles.bodyLarge.copyWith(
                    color: AppTheme.grey600,
                  ),
                ),
                const SizedBox(height: 40),
                // Email
                CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Entrez votre email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: AppTheme.grey500,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // Mot de passe
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',
                  obscureText: _obscurePassword,
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppTheme.grey500,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                           ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppTheme.grey500,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre mot de passe';
                    }
                    if (value.length < 6) {
                      return 'Le mot de passe doit contenir au moins 6 caractères';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Mot de passe oublié
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      CustomSnackbar.showInfo(
                          context, 'Fonctionnalité à venir');
                    },
                    child: Text(
                      'Mot de passe oublié?',
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Bouton de connexion
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    // onPressed: _isLoading ? null : _login,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainhomeScreen(),
                          ),
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
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : Text(
                            'Se connecter',
                            style: TextStyles.buttonLarge.copyWith(
                              color: AppTheme.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                // Séparateur
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppTheme.grey300,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Ou',
                        style: TextStyles.bodyMedium.copyWith(
                          color: AppTheme.grey500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppTheme.grey300,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Lien vers l'inscription
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous n'avez pas de compte? ",
                      style: TextStyles.bodyMedium.copyWith(
                        color: AppTheme.grey600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainhomeScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "S'inscrire",
                        style: TextStyles.bodyMedium.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}