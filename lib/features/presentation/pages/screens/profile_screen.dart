import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color.fromARGB(255, 2, 70, 125),
              ),
              title: const Text(
                'Choisir dans la galerie',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 2, 70, 125),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Fonction pour sélectionner depuis la galerie
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Galerie sélectionnée'))
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.photo_camera,
                color: Color.fromARGB(255, 2, 70, 125),
              ),
              title: const Text(
                'Prendre une photo',
                style: TextStyle(
                  fontSize: 15,
                  color:  Color.fromARGB(255, 2, 70, 125),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Fonction pour prendre une photo
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Appareil photo ouvert'))
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 200),
            Stack(
              children: [
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 212, 209, 209),
                  radius: 50,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: HeroIcon(
                          HeroIcons.camera,
                          size: 20,
                          color: Color.fromARGB(255, 2, 70, 125),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Informations utilisateur
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  Text(
                    'ALAWI L. David',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'flutterdave8@exemple.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '+228 93 61 71 32',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
          ],
        ),
      ),
    );
  }
}