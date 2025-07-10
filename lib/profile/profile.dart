import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';
import 'package:mb_fe/profile/provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nama;
  late TextEditingController gmail;
  late TextEditingController telephone;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    nama = TextEditingController(text: profile.name);
    gmail = TextEditingController(text: profile.email);
    telephone = TextEditingController(text: profile.phone);
    _loadSavedImage();
  }


  Future<void> _loadSavedImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final savedImagePath = '${directory.path}/profile_image.png';
    final imageFile = File(savedImagePath);

    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    if (await imageFile.exists()) {
      setState(() {
        _imageFile = imageFile;
      });
      profileProvider.updateProfileImage(imageFile);
    } else {
      profileProvider.updateProfileImage(null);
      setState(() {
        _imageFile = null;
      });
    }
  }


  Future<void> _saveImage(File image) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/profile_image.png';
    await image.copy(path);
    Provider.of<ProfileProvider>(context, listen: false).updateProfileImage(File(path));
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source, imageQuality: 80, maxWidth: 800);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        await _saveImage(file);
        setState(() {
          _imageFile = file;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil gambar: $e')),
        );
      }
    }
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeri'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Kamera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              if (_imageFile != null)
                ListTile(
                  leading: const Icon(Icons.delete_outline, color: Colors.red),
                  title: const Text('Hapus Foto', style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    final directory = await getApplicationDocumentsDirectory();
                    final path = '${directory.path}/profile_image.png';
                    await File(path).delete();
                    Provider.of<ProfileProvider>(context, listen: false).updateProfileImage(null);
                    setState(() {
                      _imageFile = null;
                    });
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Halaman Profil', showMenu: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: profile.profileImage != null
                      ? FileImage(profile.profileImage!)
                      : const AssetImage('lib/assets/images/user.png') as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: FloatingActionButton(
                    onPressed: _showImageSourceActionSheet,
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey
                        : Colors.greenAccent,
                    shape: CircleBorder(
                      side: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
                          width: 2),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            _buildProfileTextField(controller: nama, label: 'Nama', icon: Icons.person),
            const SizedBox(height: 20),
            _buildProfileTextField(controller: gmail, label: 'Email', icon: Icons.email, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            _buildProfileTextField(controller: telephone, label: 'Telepon', icon: Icons.phone, keyboardType: TextInputType.number),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                profile.updateName(nama.text);
                profile.updateEmail(gmail.text);
                profile.updatePhone(telephone.text);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Perubahan profil disimpan')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[800]
                    : Colors.green, // Hijau untuk light mode
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: const Text(
                'Simpan',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildProfileTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey, // warna default saat tidak aktif
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? Colors.white : Colors.green, // sesuai dark/light mode
            width: 2,
          ),
        ),
      ),
      keyboardType: keyboardType,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
      ),
    );
  }

}