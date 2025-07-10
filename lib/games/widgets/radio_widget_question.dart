import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/games/model/provider.dart';

class RadioWidgetQuestion extends StatelessWidget {
  final int questionIndex;

  const RadioWidgetQuestion({super.key, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    // Consumer akan 'mendengarkan' perubahan pada QuizProvider dan membangun ulang UI
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        final question = provider.currentQuestion[questionIndex];
        final options = List<String>.from(question['options']);
        
        // Mengambil jawaban yang sudah disimpan untuk soal ini
        final groupValue = provider.radioAnswer[questionIndex];

        // Menggunakan Column untuk menampilkan daftar opsi
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(options.length, (optionIndex) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 6.0),
              child: RadioListTile<int>(
                title: Text(options[optionIndex]),
                value: optionIndex, // Nilai dari opsi ini adalah indeksnya
                groupValue: groupValue, // Jawaban yang sedang dipilih
                onChanged: (int? value) {
                  // Saat pengguna memilih opsi, panggil method di provider
                  if (value != null) {
                    provider.selectedRadioAnswer(questionIndex, value);
                  }
                },
                activeColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.green
                    : Colors.indigo, // Warna saat dipilih
              ),
            );
          }),
        );
      },
    );
  }
}
