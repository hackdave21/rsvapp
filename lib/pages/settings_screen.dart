import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),

              // Titre
              const Text(
                'Paramètres',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              
              const SizedBox(height: 30),

              // Container des paramètres
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // Historique
                      ListTile(
                        iconColor: Colors.blue,
                        leading: const Icon(Icons.history),
                        title: const Text(
                          'Historique',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Navigation vers l'historique
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Historique ouvert'))
                          );
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Notifications
                      ListTile(
                        iconColor: Colors.blue,
                        leading: Icon(isNotificationEnabled
                            ? Icons.notifications_active
                            : Icons.notifications_off),
                        title: const Text(
                          'Notifications',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Switch(
                          value: isNotificationEnabled,
                          onChanged: _toggleNotifications,
                          activeColor: Colors.blue,
                        ),
                      ),
                      
                      _buildDivider(),
                      
                      // Langue
                      ListTile(
                        iconColor: Colors.blue,
                        leading: const Icon(Icons.language),
                        title: const Text(
                          'Langue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          _showLanguageDialog();
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Politique de confidentialité
                      ListTile(
                        iconColor: Colors.blue,
                        leading: const Icon(Icons.privacy_tip),
                        title: const Text(
                          'Politique de confidentialité',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Politique de confidentialité'))
                          );
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Mode sombre
                      ListTile(
                        iconColor: Colors.blue,
                        leading: Icon(
                          isDarkModeEnabled ? Icons.dark_mode : Icons.light_mode,
                        ),
                        title: const Text(
                          'Mode sombre',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: Switch(
                          value: isDarkModeEnabled,
                          onChanged: _toggleDarkMode,
                          activeColor: Colors.blue,
                        ),
                      ),
                      
                      _buildDivider(),
                      
                      // À propos
                      ListTile(
                        iconColor: Colors.blue,
                        leading: const Icon(Icons.info_outline),
                        title: const Text(
                          'À propos',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          _showAboutDialog();
                        },
                      ),
                      
                      _buildDivider(),
                      
                      // Aide et support
                      ListTile(
                        iconColor: Colors.blue,
                        leading: const Icon(Icons.help_outline),
                        title: const Text(
                          'Aide et support',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Page d\'aide'))
                          );
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
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkModeEnabled = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? 'Mode sombre activé' : 'Mode sombre désactivé'),
      ),
    );
  }

  void _toggleNotifications(bool value) {
    setState(() {
      isNotificationEnabled = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? 'Notifications activées' : 'Notifications désactivées'),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choisir la langue'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Français'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Langue: Français'))
                  );
                },
              ),
              ListTile(
                title: const Text('English'),
                onTap: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Language: English'))
                  );
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
      applicationIcon: const Icon(Icons.apps),
      children: [
        const Text('Cette application a été développée avec Flutter.'),
        const SizedBox(height: 10),
        const Text('© 2024 Mon App. Tous droits réservés.'),
      ],
    );
  }
}