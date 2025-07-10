import 'package:mb_fe/games/widgets/level_selector.dart';
import 'package:mb_fe/games/widgets/start_game_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/games/model/provider.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class gamesPage extends StatelessWidget {
  const gamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Quiz Page'),
      body: Container(
        child: Center(
          child:
              quizProvider.isLoading
                  ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 6.0,
                  )
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'My Games',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const LevelSelector(),

                      const SizedBox(height: 24),
                      Consumer<QuizProvider>(
                        builder: (context, provider, child) {
                          if (provider.currentQuestion.isEmpty) {
                            // Jangan tampilkan apa-apa jika kuis belum dimulai
                            return const SizedBox.shrink();
                          }

                          final total = provider.currentQuestion.length;
                          final answered = provider.answeredQuestionsCount;
                          final progress = total > 0 ? answered / total : 0.0;

                          return Column(
                            children: [
                              Text(
                                '$answered dari $total Soal Telah Dilihat/Dijawab',
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: progress,
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              const SizedBox(height: 40),
                            ],
                          );
                        },
                      ),

                      const StartGameButton(),
                    ],
                  ),
        ),
      ),
    );
  }
}
