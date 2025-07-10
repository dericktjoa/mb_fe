import 'dart:io';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _name = 'Justin Emerson Wijaya';
  String _email = 'justin.emerson@students.mikroskil.ac.id';
  String _phone = '08241241241241';
  File? _profileImage;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  File? get profileImage => _profileImage;

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void updatePhone(String newPhone) {
    _phone = newPhone;
    notifyListeners();
  }

  void updateProfileImage(File? newImage) {
    _profileImage = newImage;
    notifyListeners();
  }

  void resetProfile() {
    _name = 'Justin Emerson Wijaya';
    _email = 'justin.emerson@students.mikroskil.ac.id';
    _phone = '08241241241241';
    _profileImage = null;
    notifyListeners();
  }
}
