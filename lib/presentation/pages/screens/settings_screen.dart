import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rvsapp/presentation/themes/text_styles.dart';
import 'package:rvsapp/presentation/widgets/custom_snackbar.dart';
import 'package:rvsapp/shared/providers/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = Theme.of(context);
        final isDark = themeProvider.isDarkMode;
        final colorScheme = theme.colorScheme;
        
        return Scaffold(
          backgroundColor: colorScheme.surface,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),

                  // Titre de la page
                  Text(
                    'Paramètres',
                    style: TextStyles.headlineLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Container des paramètres
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          // Historique
                          ListTile(
                            iconColor: colorScheme.primary,
                            leading: const Icon(Icons.history),
                            title: Text(
                              'Historique',
                              style: TextStyles.titleMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios, 
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onTap: () {
                              CustomSnackbar.showInfo(context, 'Historique ouvert');
                            },
                          ),
                          
                          _buildDivider(colorScheme),
                          
                          // Notifications
                          ListTile(
                            iconColor: colorScheme.primary,
                            leading: Icon(isNotificationEnabled
                                ? Icons.notifications_active
                                : Icons.notifications_off),
                            title: Text(
                              'Notifications',
                              style: TextStyles.titleMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            trailing: Switch(
                              value: isNotificationEnabled,
                              onChanged: _toggleNotifications,
                              activeColor: colorScheme.primary,
                              activeTrackColor: colorScheme.primary.withOpacity(0.5),
                            ),
                          ),
                          
                          _buildDivider(colorScheme),
                          
                          // Langue
                          ListTile(
                            iconColor: colorScheme.primary,
                            leading: const Icon(Icons.language),
                            title: Text(
                              'Langue',
                              style: TextStyles.titleMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios, 
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onTap: () {
                              _showLanguageDialog();
                            },
                          ),
                          
                          _buildDivider(colorScheme),
                          
                          // Politique de confidentialité
                          ListTile(
                            iconColor: colorScheme.primary,
                            leading: const Icon(Icons.privacy_tip),
                            title: Text(
                              'Politique de confidentialité',
                              style: TextStyles.titleMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios, 
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onTap: () {
                              CustomSnackbar.showInfo(context, 'Politique de confidentialité');
                            },
                          ),
                          
                          _buildDivider(colorScheme),
                          
                          // Thème avec options multiples
                          ListTile(
                            iconColor: colorScheme.primary,
                            leading: Icon(
                              _getThemeIcon(themeProvider.themeMode),
                            ),
                            title: Text(
                              'Thème',
                              style: TextStyles.titleMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            subtitle: Text(
                              themeProvider.themeModeString,
                              style: TextStyles.bodySmall.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios, 
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onTap: () {
                              _showThemeDialog(themeProvider);
                            },
                          ),
                          
                          _buildDivider(colorScheme),
                          
                          // À propos
                          ListTile(
                            iconColor: colorScheme.primary,
                            leading: const Icon(Icons.info_outline),
                            title: Text(
                              'À propos',
                              style: TextStyles.titleMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios, 
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onTap: () {
                              _showAboutDialog();
                            },
                          ),
                          
                          _buildDivider(colorScheme),
                          
                          // Aide et support
                          ListTile(
                            iconColor: colorScheme.primary,
                            leading: const Icon(Icons.help_outline),
                            title: Text(
                              'Aide et support',
                              style: TextStyles.titleMedium.copyWith(
                                color: colorScheme.onSurface,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios, 
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onTap: () {
                              CustomSnackbar.showInfo(context, "Page d'aide");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      height: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.outlineVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  IconData _getThemeIcon(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  void _toggleNotifications(bool value) {
    setState(() {
      isNotificationEnabled = value;
    });
    CustomSnackbar.showSuccess(
      context, 
      value ? 'Notifications activées' : 'Notifications désactivées'
    );
  }

  void _showThemeDialog(ThemeProvider themeProvider) {
    final colorScheme = Theme.of(context).colorScheme;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          title: Text(
            'Choisir le thème',
            style: TextStyles.headlineSmall.copyWith(
              color: colorScheme.primary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Option Clair
              ListTile(
                leading: Icon(
                  Icons.light_mode,
                  color: colorScheme.onSurface,
                ),
                title: Text(
                  'Clair',
                  style: TextStyles.bodyLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                trailing: themeProvider.themeMode == ThemeMode.light 
                    ? Icon(Icons.check, color: colorScheme.primary)
                    : null,
                onTap: () {
                  themeProvider.setLightTheme();
                  Navigator.of(context).pop();
                  CustomSnackbar.showSuccess(context, 'Thème clair activé');
                },
              ),
              
              // Option Sombre
              ListTile(
                leading: Icon(
                  Icons.dark_mode,
                  color: colorScheme.onSurface,
                ),
                title: Text(
                  'Sombre',
                  style: TextStyles.bodyLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                trailing: themeProvider.themeMode == ThemeMode.dark 
                    ? Icon(Icons.check, color: colorScheme.primary)
                    : null,
                onTap: () {
                  themeProvider.setDarkTheme();
                  Navigator.of(context).pop();
                  CustomSnackbar.showSuccess(context, 'Thème sombre activé');
                },
              ),
              
              // Option Système
              ListTile(
                leading: Icon(
                  Icons.brightness_auto,
                  color: colorScheme.onSurface,
                ),
                title: Text(
                  'Suivre le système',
                  style: TextStyles.bodyLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                trailing: themeProvider.themeMode == ThemeMode.system 
                    ? Icon(Icons.check, color: colorScheme.primary)
                    : null,
                onTap: () {
                  themeProvider.setSystemTheme();
                  Navigator.of(context).pop();
                  CustomSnackbar.showSuccess(context, 'Thème automatique activé');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLanguageDialog() {
    final colorScheme = Theme.of(context).colorScheme;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorScheme.surface,
          title: Text(
            'Choisir la langue',
            style: TextStyles.headlineSmall.copyWith(
              color: colorScheme.primary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Français',
                  style: TextStyles.bodyLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  CustomSnackbar.showSuccess(context, 'Langue: Français');
                },
              ),
              ListTile(
                title: Text(
                  'English',
                  style: TextStyles.bodyLarge.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  CustomSnackbar.showSuccess(context, 'Language: English');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutDialog() {
    final colorScheme = Theme.of(context).colorScheme;
    
    showAboutDialog(
      context: context,
      applicationName: 'KING DAVE APP',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.apps,
        color: colorScheme.primary,
      ),
      children: [
        Text(
          'Cette application a été développée avec Flutter.',
          style: TextStyles.bodyMedium.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '© 2024 KING DAVE APP. Tous droits réservés.',
          style: TextStyles.bodySmall.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}