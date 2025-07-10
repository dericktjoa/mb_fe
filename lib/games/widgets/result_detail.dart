import 'package:flutter/material.dart';

class ResultDetailCardWidget extends StatelessWidget {
  final Map<String, dynamic> result;

  const ResultDetailCardWidget({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = result['is_correct'];
    final options = List<String>.from(result['options']);

    String getAnswerText(dynamic answerIndex) {
      if (answerIndex == null) return "Tidak dijawab";
      if (answerIndex is int) return options[answerIndex];
      if (answerIndex is List<int>) {
        if (answerIndex.isEmpty) return "Tidak dijawab";
        return answerIndex.map((i) => options[i]).join(', ');
      }
      return "Tidak valid";
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
          width: Theme.of(context).brightness == Brightness.dark
              ? 3.5
              : 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soal: ${result['question_text']}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF333739)
                  : Theme.of(context).textTheme.bodyMedium?.color),
            ),
            const Divider(),
            Text('Jawaban Kamu: ${getAnswerText(result['user_answer'])}',
              style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF333739)
                  : Theme.of(context).textTheme.bodyMedium?.color),),
            Text(
              'Jawaban Benar: ${getAnswerText(result['correct_answer'])}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF333739)
                    : Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ],
        ),
      ),
    );
  }
}
