import 'package:mb_fe/games/soal/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/games/model/provider.dart';
// import 'package:belajar_1/activity/soal/number1.dart';


class StartGameButton extends StatelessWidget {
  const StartGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, _) {
        final isChoiceSelected = quizProvider.selectedValue != null &&
            quizProvider.selectedValue!.isNotEmpty;

        return ElevatedButton(
          onPressed: isChoiceSelected
              ? () {
                  final navigator = Navigator.of(context);
                  quizProvider.loadQuestions();
                  quizProvider.startLoading();
                  Future.delayed(const Duration(seconds: 2)).then((_) {
                    quizProvider.stopLoading();
                    navigator.pushReplacement( // Gunakan pushReplacement
                      MaterialPageRoute(
                        builder: (_) => const QuizPage(questionIndex: 0),
                      ),
                    );
                  });
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isChoiceSelected ? Colors.greenAccent : Colors.grey,
            foregroundColor: Colors.white,
            elevation: isChoiceSelected ? 6 : 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
          child: const Text('Play Game',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        );
      },
    );
  }
}

