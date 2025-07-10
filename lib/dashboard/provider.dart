// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
//
// class providerDashboard extends ChangeNotifier {
//   String _selectedPeriod = 'day';
//   String _quizTime = 'Day';
//   int _scoreHigh = 90;
//   int _scoreLow = 50;
//
//   String get selectedPeriod => _selectedPeriod;
//   String get quizTime => _quizTime;
//   String get scoreHigh => _scoreHigh.toString();
//   String get scoreLow => _scoreLow.toString();
//
//   setSelectedPeriodDay(String? value) {
//     _selectedPeriod = 'day';
//     _quizTime = 'Daily';
//     _scoreHigh = 90;
//     _scoreLow = 50;
//     notifyListeners();
//   }
//
//   setSelectedPeriodWeek(String? value) {
//     _selectedPeriod = 'week';
//     _quizTime = 'Weekly';
//     _scoreHigh = 80;
//     _scoreLow = 60;
//     notifyListeners();
//   }
//
//   setSelectedPeriodMonth(String? value) {
//     _selectedPeriod = 'month';
//     _quizTime = 'Monthly';
//     _scoreHigh = 75;
//     _scoreLow = 54;
//
//     notifyListeners();
//   }
// }

// quiz_statistics_provider.dart

import 'package:flutter/material.dart';

class providerDashboard extends ChangeNotifier {
  String _selectedPeriod = 'day';

  String get selectedPeriod => _selectedPeriod;

  void setSelectedPeriod(String? period) {
    if (period != null && _selectedPeriod != period) {
      _selectedPeriod = period;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> get filteredChartData {
    if (_selectedPeriod == 'day') {
      return [
        {'day': 'Mon', 'score': 70},
        {'day': 'Tue', 'score': 80},
        {'day': 'Wed', 'score': 60},
        {'day': 'Thu', 'score': 75},
        {'day': 'Fri', 'score': 90},
      ];
    } else if (_selectedPeriod == 'week') {
      return [
        {'day': 'W1', 'score': 90},
        {'day': 'W2', 'score': 80},
        {'day': 'W3', 'score': 65},
        {'day': 'W4', 'score': 75},
      ];
    } else {
      return [
        {'day': 'Jan', 'score': 85},
        {'day': 'Feb', 'score': 80},
        {'day': 'Mar', 'score': 90},
      ];
    }
  }
}

