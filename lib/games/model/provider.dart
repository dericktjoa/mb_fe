import 'package:flutter/material.dart';
import 'package:mb_fe/games/data/easy_question.dart';
import 'package:mb_fe/games/data/hard_question.dart';
import 'package:mb_fe/games/data/medium_question.dart';
import 'package:collection/collection.dart';

class QuizProvider with ChangeNotifier {
  String? _selectedValue; // Level game yang dipilih (Easy, Medium, Hard)
  bool _isLoading = false; // Indikator loading saat memuat soal
  List<Map<String, dynamic>> _currentQuestion = []; // Daftar soal yang aktif

  // Map untuk menyimpan jawaban pengguna
  final Map<int, int?> _radioAnswer = {}; // Jawaban radio (satu pilihan)
  final Map<int, List<int>> _checkBoxAnswer = {}; // Jawaban checkbox (multi-pilihan)

  // Set untuk menyimpan soal yang ditandai "Ragu-ragu"
  final Set<int> _doubtfulQuestions = {};

  String? get selectedValue => _selectedValue;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get currentQuestion => _currentQuestion;
  Map<int, int?> get radioAnswer => _radioAnswer;
  Map<int, List<int>> get checkBoxAnswer => _checkBoxAnswer;
  Set<int> get doubtfulQuestions => _doubtfulQuestions;

  // Getter untuk menghitung jumlah soal yang sudah dijawab
  int get answeredQuestionsCount {
    final answeredIndexes = <int>{};
    answeredIndexes.addAll(_radioAnswer.keys);
    answeredIndexes.addAll(_checkBoxAnswer.keys);
    return answeredIndexes.length;
  }

  // Getter untuk mengecek apakah sebuah soal ditandai ragu-ragu
  bool isDoubtful(int questionIndex) {
    return _doubtfulQuestions.contains(questionIndex);
  }

  void setSelectedValue(String? value) {
    _selectedValue = value;
    notifyListeners();
  }

  void loadQuestions() {
    if (_selectedValue == 'Easy') {
      _currentQuestion = easyQuestions;
    } else if (_selectedValue == 'Medium') {
      _currentQuestion = mediumQuestions;
    } else if (_selectedValue == 'Hard') {
      _currentQuestion = hardQuestions;
    } else {
      _currentQuestion = [];
    }
    notifyListeners();
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void selectedRadioAnswer(int questionIndex, int? value) {
    _radioAnswer[questionIndex] = value;
    notifyListeners();
  }

  // Menandai soal sebagai sudah dijawab
  void toggleCheckboxAnswer(int questionIndex, int answerIndex) {
    _checkBoxAnswer.putIfAbsent(questionIndex, () => []);

    if (_checkBoxAnswer[questionIndex]!.contains(answerIndex)) {
      _checkBoxAnswer[questionIndex]!.remove(answerIndex);
    } else {
      _checkBoxAnswer[questionIndex]!.add(answerIndex);
    }
    notifyListeners();
  }

  // Menandai soal sebagai "Ragu-ragu"
  void toggleDoubtful(int questionIndex) {
    if (_doubtfulQuestions.contains(questionIndex)) {
      _doubtfulQuestions.remove(questionIndex);
    } else {
      _doubtfulQuestions.add(questionIndex);
    }
    notifyListeners();
  }

  // Menghitung total skor yang benar
  int getCorrectAnswerCount() {
    int score = 0;
    for (int i = 0; i < _currentQuestion.length; i++) {
      final question = _currentQuestion[i];
      final correctAnswer = question['correctAnswerIndex'];
      final type = question['type'];

      if (type == 'radio') {
        if (_radioAnswer.containsKey(i) && _radioAnswer[i] == correctAnswer) {
          score++;
        }
      } else if (type == 'checkbox') {
        final selectedAnswers = _checkBoxAnswer[i] ?? [];
        final correctAnswers = List<int>.from(correctAnswer);

        // Membandingkan dua list tanpa memperhatikan urutan
        if (const DeepCollectionEquality().equals(
          selectedAnswers..sort(),
          correctAnswers..sort(),
        )) {
          score++;
        }
      }
    }
    return score;
  }

  // Membuat rincian hasil kuis untuk ditampilkan di halaman skor
  List<Map<String, dynamic>> getQuizResults() {
    List<Map<String, dynamic>> results = [];
    for (int i = 0; i < _currentQuestion.length; i++) {
      final question = _currentQuestion[i];
      final correctAnswer = question['correctAnswerIndex'];
      final type = question['type'];
      dynamic userAnswer;
      bool isCorrect = false;

      if (type == 'radio') {
        userAnswer = _radioAnswer[i];
        isCorrect = userAnswer == correctAnswer;
      } else if (type == 'checkbox') {
        userAnswer = _checkBoxAnswer[i] ?? [];
        final correctList = List<int>.from(correctAnswer);
        isCorrect = const DeepCollectionEquality().equals(
          List<int>.from(userAnswer)..sort(),
          correctList..sort(),
        );
      }

      results.add({
        'question_index': i,
        'question_text': question['question'],
        'user_answer': userAnswer,
        'correct_answer': correctAnswer,
        'is_correct': isCorrect,
        'options': question['options'],
        'type': type,
      });
    }
    return results;
  }

  // Reset semua data kuis untuk memulai ulang
  void resetQuiz() {
    _selectedValue = null;
    _radioAnswer.clear();
    _checkBoxAnswer.clear();
    _doubtfulQuestions.clear(); // Pastikan ini juga di-reset
    _isLoading = false;
    _currentQuestion = [];
    notifyListeners();
  }
}
