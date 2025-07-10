import 'package:flutter/material.dart';
class providerSetting extends ChangeNotifier {
  String _message = "";
  bool _showBanner = false;

  String get message => _message;
  bool get showBanner => _showBanner;

  void showingBanner() {
    _message = "App is Up to Date"; // or other messages
    _showBanner = true;
    notifyListeners();
  }

  void hidingBanner() {
    _showBanner = false;
    _message = "";
    notifyListeners();
  }

  //Dark Mode
  var light = ThemeData(brightness: Brightness.light);

  var dark = ThemeData(brightness: Brightness.dark);

  bool _enableLocation = false;
  bool _enableDarkMode = false;

  bool get enableLocation => _enableLocation;
  bool get enableDarkMode => _enableDarkMode;

  void setBrightness(val) {
    _enableDarkMode = val;
    notifyListeners();
  }

  //Notification
  void setLocation(val) {
    _enableLocation = val;
    notifyListeners();
  }

  double _notificationVolume = 50.0;
  bool _notificationEnabled = true;

  double get notificationVolume => _notificationVolume;
  bool get notificationEnabled => _notificationEnabled;

// Notification methods
  void setNotificationVolume(double volume) {
    _notificationVolume = volume;
    notifyListeners();
  }

  void toggleNotification(bool enabled) {
    _notificationEnabled = enabled;
    notifyListeners();
  }

}

