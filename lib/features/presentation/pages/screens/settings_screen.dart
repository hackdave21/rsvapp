import 'package:flutter/material.dart';
import 'package:rvsapp/core/themes/app_themes.dart';
import 'package:rvsapp/core/themes/text_styles.dart';
import 'package:rvsapp/shared/widgets/custom_snackbar.dart'; 

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkModeEnabled = false;
  bool isNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),

              // Titre de la page
              Text(
                'Paramètres',
                style: TextStyles.headlineLarge.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 30),

              // Container des paramètres
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.grey100,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
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
                        iconColor: AppTheme.primaryColor,
                        leading: const Icon(Icons.history),
                        title: Text(
                          'Historique',
                          style: TextStyles.titleMedium.copyWith(
                            color: AppTheme.grey900,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios, 
                          size: 16,
                          color: AppTheme.grey600,
                        ),
                        onTap: () {
                          CustomSnackbar.showInfo(context, 'Historique ouvert');
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Notifications
                      ListTile(
                        iconColor: AppTheme.primaryColor,
                        leading: Icon(isNotificationEnabled
                            ? Icons.notifications_active
                            : Icons.notifications_off),
                        title: Text(
                          'Notifications',
                          style: TextStyles.titleMedium.copyWith(
                            color: AppTheme.grey900,
                          ),
                        ),
                        trailing: Switch(
                          value: isNotificationEnabled,
                          onChanged: _toggleNotifications,
                          activeColor: AppTheme.primaryColor,
                          activeTrackColor: AppTheme.primaryColor.withOpacity(0.5),
                        ),
                      ),
                      
                      _buildDivider(),
                      
                      // Langue
                      ListTile(
                        iconColor: AppTheme.primaryColor,
                        leading: const Icon(Icons.language),
                        title: Text(
                          'Langue',
                          style: TextStyles.titleMedium.copyWith(
                            color: AppTheme.grey900,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios, 
                          size: 16,
                          color: AppTheme.grey600,
                        ),
                        onTap: () {
                          _showLanguageDialog();
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Politique de confidentialité
                      ListTile(
                        iconColor: AppTheme.primaryColor,
                        leading: const Icon(Icons.privacy_tip),
                        title: Text(
                          'Politique de confidentialité',
                          style: TextStyles.titleMedium.copyWith(
                            color: AppTheme.grey900,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios, 
                          size: 16,
                          color: AppTheme.grey600,
                        ),
                        onTap: () {
                          CustomSnackbar.showInfo(context, 'Politique de confidentialité');
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Mode sombre
                      ListTile(
                        iconColor: AppTheme.primaryColor,
                        leading: Icon(
                          isDarkModeEnabled ? Icons.dark_mode : Icons.light_mode,
                        ),
                        title: Text(
                          'Mode sombre',
                          style: TextStyles.titleMedium.copyWith(
                            color: AppTheme.grey900,
                          ),
                        ),
                        trailing: Switch(
                          value: isDarkModeEnabled,
                          onChanged: _toggleDarkMode,
                          activeColor: AppTheme.primaryColor,
                          activeTrackColor: AppTheme.primaryColor.withOpacity(0.5),
                        ),
                      ),
                      
                      _buildDivider(),
                      
                      // À propos
                      ListTile(
                        iconColor: AppTheme.primaryColor,
                        leading: const Icon(Icons.info_outline),
                        title: Text(
                          'À propos',
                          style: TextStyles.titleMedium.copyWith(
                            color: AppTheme.grey900,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios, 
                          size: 16,
                          color: AppTheme.grey600,
                        ),
                        onTap: () {
                          _showAboutDialog();
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Aide et support
                      ListTile(
                        iconColor: AppTheme.primaryColor,
                        leading: const Icon(Icons.help_outline),
                        title: Text(
                          'Aide et support',
                          style: TextStyles.titleMedium.copyWith(
                            color: AppTheme.grey900,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios, 
                          size: 16,
                          color: AppTheme.grey600,
                        ),
                        onTap: () {
                          CustomSnackbar.showInfo(context, 'Page d\'aide');
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
  }

  Widget _buildDivider() {
    return Container(
      width: double.infinity,
      height: 0.5,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: AppTheme.grey400.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkModeEnabled = value;
    });
    CustomSnackbar.showSuccess(
      context, 
      value ? 'Mode sombre activé' : 'Mode sombre désactivé'
    );
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

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choisir la langue',
            style: TextStyles.headlineSmall.copyWith(
              color: AppTheme.primaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(
                  'Français',
                  style: TextStyles.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  CustomSnackbar.showSuccess(context, 'Langue: Français');
                },
              ),
              ListTile(
                title: Text(
                  'English',
                  style: TextStyles.bodyLarge,
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
    showAboutDialog(
      context: context,
      applicationName: 'Mon App',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.apps,
        color: AppTheme.primaryColor,
      ),
      children: [
        Text(
          'Cette application a été développée avec Flutter.',
          style: TextStyles.bodyMedium,
        ),
        const SizedBox(height: 10),
        Text(
          '© 2024 Mon App. Tous droits réservés.',
          style: TextStyles.bodySmall.copyWith(
            color: AppTheme.grey600,
          ),
        ),
      ],
    );
  }
}