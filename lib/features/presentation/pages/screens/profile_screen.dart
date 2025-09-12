import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rvsapp/core/themes/text_styles.dart';
import 'package:rvsapp/features/presentation/widgets/custom_snackbar.dart';
import 'package:rvsapp/features/presentation/widgets/edit_profile_dialog.dart';
import 'package:rvsapp/shared/providers/theme_provider.dart';

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

  Future<bool> _requestPermission(ImageSource source) async {
    if (source == ImageSource.camera) {
      return await Permission.camera.request().isGranted;
    } else {
      if (Platform.isAndroid) {
        if (await Permission.photos.isGranted || await Permission.storage.isGranted) {
          return true;
        }
        final photos = await Permission.photos.request();
        final storage = await Permission.storage.request();
        return photos.isGranted || storage.isGranted;
      } else {
        return await Permission.photos.request().isGranted;
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final granted = await _requestPermission(source);
      if (!granted) {
        CustomSnackbar.showError(context, "Permission refusée");
        return;
      }

      final XFile? pickedFile = await _imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        final File? croppedFile = await _cropImage(File(pickedFile.path));
        if (croppedFile != null) {
          setState(() {
            _profileImage = croppedFile;
          });
          CustomSnackbar.showSuccess(context, 'Photo de profil mise à jour');
        }
      }
    } catch (e) {
      CustomSnackbar.showError(context, "Erreur : $e");
    }
  }

  Future<File?> _cropImage(File imageFile) async {
    final colorScheme = Theme.of(context).colorScheme;
    
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Rogner l'image",
          toolbarColor: colorScheme.primary,
          toolbarWidgetColor: colorScheme.onPrimary,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          backgroundColor: colorScheme.surface,
          activeControlsWidgetColor: colorScheme.primary,
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
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            children: <Widget>[
              Center(
                child: Text(
                  'Changer la photo de profil',
                  style: TextStyles.titleMedium.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ),
              Divider(color: colorScheme.outlineVariant),
              ListTile(
                leading: Icon(
                  Icons.photo_library,
                  color: colorScheme.primary,
                ),
                title: Text(
                  'Choisir dans la galerie',
                  style: TextStyles.bodyMedium.copyWith(
                    color: colorScheme.onSurface,
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
                  color: colorScheme.primary,
                ),
                title: Text(
                  'Prendre une photo',
                  style: TextStyles.bodyMedium.copyWith(
                    color: colorScheme.onSurface,
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final isDark = themeProvider.isDarkMode;
        
        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Mon Profil',
              style: TextStyles.titleLarge.copyWith(
                color: colorScheme.primary,
              ),
            ),
            backgroundColor: colorScheme.surface,
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            iconTheme: IconThemeData(color: colorScheme.onSurface),
            actions: [
              IconButton(
                icon: HeroIcon(
                  HeroIcons.pencil,
                  color: colorScheme.primary,
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
                          color: colorScheme.primary,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 58,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : const AssetImage('assets/user.png') as ImageProvider,
                        child: _profileImage == null 
                            ? Icon(
                                Icons.person,
                                size: 60,
                                color: colorScheme.onSurfaceVariant,
                              )
                            : null,
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
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.surface,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: colorScheme.onPrimary,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informations personnelles',
                        style: TextStyles.titleMedium.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInfoRow(Icons.person, 'Nom complet', _fullName, colorScheme),
                      const SizedBox(height: 15),
                      _buildInfoRow(Icons.email, 'Email', _email, colorScheme),
                      const SizedBox(height: 15),
                      _buildInfoRow(Icons.phone, 'Téléphone', _phone, colorScheme),
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
                      backgroundColor: colorScheme.error,
                      foregroundColor: colorScheme.onError,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Se déconnecter',
                      style: TextStyles.buttonMedium.copyWith(
                        color: colorScheme.onError,
                      ),
                    ),
                  ),
                ),
                
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: colorScheme.primary,
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
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyles.bodyLarge.copyWith(
                  color: colorScheme.onSurface,
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