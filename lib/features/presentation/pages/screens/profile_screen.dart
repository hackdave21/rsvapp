import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:rvsapp/core/themes/app_themes.dart';
import 'package:rvsapp/core/themes/text_styles.dart';
import 'package:rvsapp/features/presentation/widgets/custom_snackbar.dart';
import 'package:rvsapp/features/presentation/widgets/edit_profile_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  String _fullName = 'ALAWI L. David';
  String _email = 'flutterdave8@exemple.com';
  String _phone = '+228 93 61 71 32';

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      
      if (pickedFile != null) {
        // Rogner l'image
        final File? croppedFile = await _cropImage(File(pickedFile.path));
        
        if (croppedFile != null) {
          setState(() {
            _profileImage = croppedFile;
          });
          CustomSnackbar.showSuccess(context, 'Photo de profil mise à jour');
        }
      }
    } catch (e) {
      CustomSnackbar.showError(context, 'Erreur lors de la sélection de l\'image');
    }
  }

Future<File?> _cropImage(File imageFile) async {
  final CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: "Rogner l'image",
        toolbarColor: AppTheme.primaryColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: true,
      ),
      IOSUiSettings(
        title: "Rogner l'image",
        aspectRatioLockEnabled: true,
        aspectRatioPickerButtonHidden: true,
        resetAspectRatioEnabled: false,
        aspectRatioLockDimensionSwapEnabled: true,
        rotateButtonsHidden: true,
        rotateClockwiseButtonHidden: true,
        doneButtonTitle: 'Valider',
        cancelButtonTitle: 'Annuler',
      ),
    ],
  );

  return croppedFile != null ? File(croppedFile.path) : null;
}

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: <Widget>[
              Center(
                child: Text(
                  'Changer la photo de profil',
                  style: TextStyles.titleMedium.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: AppTheme.primaryColor,
                ),
                title: Text(
                  'Choisir dans la galerie',
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.grey800,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  color: AppTheme.primaryColor,
                ),
                title: Text(
                  'Prendre une photo',
                  style: TextStyles.bodyMedium.copyWith(
                    color: AppTheme.grey800,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditProfileDialog(
          currentName: _fullName,
          currentEmail: _email,
          currentPhone: _phone,
          onSave: (newName, newEmail, newPhone) {
            setState(() {
              _fullName = newName;
              _email = newEmail;
              _phone = newPhone;
            });
            CustomSnackbar.showSuccess(context, 'Profil mis à jour avec succès');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: Text(
          'Mon Profil',
          style: TextStyles.titleLarge.copyWith(
            color: AppTheme.primaryColor,
          ),
        ),
        backgroundColor: AppTheme.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: HeroIcon(
              HeroIcons.pencil,
              color: AppTheme.primaryColor,
            ),
            onPressed: _showEditProfileDialog,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            // Photo de profil
            Stack(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 58,
                    backgroundColor: AppTheme.grey200,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : const AssetImage('assets/user.png') as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _showImagePickerOptions,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.white,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: AppTheme.white,
                        size: 20,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informations personnelles',
                    style: TextStyles.titleMedium.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoRow(Icons.person, 'Nom complet', _fullName),
                  const SizedBox(height: 15),
                  _buildInfoRow(Icons.email, 'Email', _email),
                  const SizedBox(height: 15),
                  _buildInfoRow(Icons.phone, 'Téléphone', _phone),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Bouton de déconnexion
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  CustomSnackbar.showInfo(context, 'Déconnexion');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.errorColor,
                  foregroundColor: AppTheme.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Se déconnecter',
                  style: TextStyles.buttonMedium.copyWith(
                    color: AppTheme.white,
                  ),
                ),
              ),
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyles.bodySmall.copyWith(
                  color: AppTheme.grey600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyles.bodyLarge.copyWith(
                  color: AppTheme.grey800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}