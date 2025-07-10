import 'package:flutter/material.dart';

class ScoreCardWidget extends StatelessWidget {
  final int score;
  final int total;

  const ScoreCardWidget({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    double percentage = total > 0 ? (score / total) * 100 : 0;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Skor Akhir Kamu', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 10),
            Text(
              '$score / $total',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : const Color(0xFF60B28C),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '${percentage.toStringAsFixed(1)}% Benar',
              style: TextStyle(
                fontSize: 18,
                color:
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey
                        : Color(0xFF333739),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
