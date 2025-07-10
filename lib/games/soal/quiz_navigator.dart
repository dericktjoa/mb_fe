import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/games/model/provider.dart';
import 'package:mb_fe/games/soal/quiz_page.dart';

class QuizNavigatorPanel extends StatelessWidget {
  final int currentQuestionIndex;
  const QuizNavigatorPanel({super.key, required this.currentQuestionIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final total = provider.currentQuestion.length;
        return Container(
          height: 300, 
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Navigasi Soal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6, 
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: total,
                  itemBuilder: (context, index) {
                    final isAnswered =
                        provider.radioAnswer.containsKey(index) ||
                        provider.checkBoxAnswer.containsKey(index);
                    final isDoubtful = provider.isDoubtful(index);
                    final isCurrent = index == currentQuestionIndex;

                    Color buttonColor;
                    Color textColor = Colors.white;

                    if (isCurrent) {
                      buttonColor = Colors.blue.shade700;
                    } else if (isDoubtful) {
                      buttonColor = Colors.orange.shade600;
                    } else if (isAnswered) {
                      buttonColor = Colors.green.shade600;
                    } else {
                      buttonColor = Colors.grey.shade400;
                      textColor = Colors.black87;
                    }

                    return Tooltip(
                      message: "Lompat ke soal no. ${index + 1}",
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Tutup panel
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizPage(questionIndex: index),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: textColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
