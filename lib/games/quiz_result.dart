import 'package:mb_fe/games/widgets/result_detail.dart';
import 'package:mb_fe/games/widgets/score_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/games/model/provider.dart';
import 'package:mb_fe/bottom_nav.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class QuizResultsPage extends StatelessWidget {
  const QuizResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final score = quizProvider.getCorrectAnswerCount();
    final totalQuestions = quizProvider.currentQuestion.length;
    final results = quizProvider.getQuizResults();

    return Scaffold(
      appBar: CustomAppBar(title: 'Hasil Quiz', showMenu: false),
      body: Container(
        child: Column(
          children: [
            // Bagian Atas: Kartu Skor
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ScoreCardWidget(score: score, total: totalQuestions),
            ),

            // Judul untuk Rincian Jawaban
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Rincian Jawaban',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Divider(
              thickness: 1.5,
              color: Colors.white70,
              indent: 16,
              endIndent: 16,
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return ResultDetailCardWidget(result: results[index]);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                bottom: 80.0,
                left: 16.0,
                right: 16.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.replay, color: Colors.white),
                        label: const Text('again'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFF333739)
                                  : const Color(0xFF60B28C),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          quizProvider.resetQuiz();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder:
                                  (context) => const bottomNav(initialIndex: 2),
                            ),
                            // (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.home, color: Colors.white),
                        label: const Text('Home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? const Color(0xFF333739)
                                  : const Color(0xFF60B28C),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          quizProvider.resetQuiz();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder:
                                  (context) => const bottomNav(initialIndex: 0),
                            ),
                            // (Route<dynamic> route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
