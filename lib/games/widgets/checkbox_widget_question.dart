import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/games/model/provider.dart';

class CheckBoxWidgetQuestion extends StatelessWidget {
  final int questionIndex;

  const CheckBoxWidgetQuestion({super.key, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    // Consumer akan 'mendengarkan' perubahan pada QuizProvider dan membangun ulang UI
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final question = provider.currentQuestion[questionIndex];
        final options = List<String>.from(question['options']);
        
        // Mengambil daftar jawaban yang sudah dipilih untuk soal ini
        final selectedAnswers = provider.checkBoxAnswer[questionIndex] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(options.length, (optionIndex) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              child: CheckboxListTile(
                
                title: Text(options[optionIndex]),
                controlAffinity: ListTileControlAffinity.leading,
                // Mengecek apakah opsi ini ada di dalam daftar jawaban yang dipilih
                value: selectedAnswers.contains(optionIndex),
                onChanged: (bool? value) {
                
                  // Saat pengguna mencentang atau menghapus centang,
                  // panggil method di provider
                  provider.toggleCheckboxAnswer(questionIndex, optionIndex);
                },
                activeColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.green
                    : Colors.indigo,
              ),
            );
          }),
        );
      },
    );
  }
}
