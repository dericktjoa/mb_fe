import 'package:mb_fe/games/quiz_result.dart';
import 'package:mb_fe/games/soal/quiz_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mb_fe/games/model/provider.dart';
import 'package:mb_fe/games/widgets/radio_widget_question.dart';
import 'package:mb_fe/games/widgets/checkbox_widget_question.dart';
import 'package:mb_fe/appbar/custom_appbar.dart';

class QuizPage extends StatelessWidget {
  final int questionIndex;

  const QuizPage({super.key, required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context, listen: false);
    final question = quizProvider.currentQuestion[questionIndex];
    final totalQuestions = quizProvider.currentQuestion.length;
    final themeColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Number ${questionIndex + 1}",
        showMenu: false,
        action: Consumer<QuizProvider>(
          builder: (context, provider, child) {
            final bool allQuestionsAnswered =
                provider.answeredQuestionsCount >= totalQuestions && totalQuestions > 0;

            return AnimatedOpacity(
              opacity: allQuestionsAnswered ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: allQuestionsAnswered
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check_circle_outline, size: 18, color: Colors.white,),
                  label: const Text('Selesai'),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Selesaikan Kuis?'),
                        content: const Text(
                            'Apakah Anda yakin ingin menyelesaikan sesi kuis ini?'),
                        actions: [
                          TextButton(
                            child: const Text('Batal'),
                            onPressed: () => Navigator.of(ctx).pop(),
                            style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.blueGrey
                                  : Color(0xFF60B28C),
                            ),
                          ),
                          FilledButton(
                            child: const Text('Ya, Selesaikan'),
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => const QuizResultsPage()),
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.blueGrey
                                  : Color(0xFF60B28C),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey
                        : Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            );
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Consumer<QuizProvider>(
                  builder: (context, provider, child) {
                    final progress = totalQuestions > 0
                        ? provider.answeredQuestionsCount / totalQuestions
                        : 0.0;
                    return LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(6),
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.green
                          : Colors.indigo),
                    );
                  },
                ),
              ),
        
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 4.0,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      question['question'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Consumer<QuizProvider>(
                                    builder: (context, provider, child) {
                                      final isMarkedDoubtful =
                                          provider.isDoubtful(questionIndex);
                                      return IconButton(
                                        icon: Icon(isMarkedDoubtful
                                            ? Icons.flag
                                            : Icons.flag_outlined),
                                        color: isMarkedDoubtful
                                            ? Colors.orange
                                            : Colors.grey,
                                        tooltip: 'Tandai Ragu-ragu',
                                        onPressed: () =>
                                            provider.toggleDoubtful(questionIndex),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              if (question['type'] == 'radio')
                                RadioWidgetQuestion(questionIndex: questionIndex)
                              else
                                CheckBoxWidgetQuestion(
                                    questionIndex: questionIndex),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Tombol navigasi utama
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          // tombol sebelumnya
                          ElevatedButton.icon(
                            icon: const Icon(Icons.arrow_back, color: Colors.white,),
                            label: const Text('Sebelumnya'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Color(0xFF333739)
                                  : Color(0xFF60B28C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onPressed: questionIndex > 0
                                ? () {
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            QuizPage(questionIndex: questionIndex - 1),
                                        transitionsBuilder: (_, a, __, c) =>
                                            FadeTransition(opacity: a, child: c),
                                      ),
                                    );
                                  }
                                : null, 
                          ),

                          // tombol selanjutnya
                          ElevatedButton.icon(
                            label: const Text('Selanjutnya'),
                            icon: const Icon(Icons.arrow_forward, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).brightness == Brightness.dark
                                  ? Color(0xFF333739)
                                  : Color(0xFF60B28C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            onPressed: questionIndex < totalQuestions - 1
                                ? () {
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            QuizPage(questionIndex: questionIndex + 1),
                                        transitionsBuilder: (_, a, __, c) =>
                                            FadeTransition(opacity: a, child: c),
                                      ),
                                    );
                                  }
                                : null, 
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Tombol Navigasi Grid
      floatingActionButton: FloatingActionButton(
        tooltip: 'Lihat Semua Soal',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => QuizNavigatorPanel(
              currentQuestionIndex: questionIndex,
            ),
          );
        },
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Color(0xFF333739)
            : Color(0xFF60B28C),
        foregroundColor: Colors.white,
        child: const Icon(Icons.grid_view_rounded),
      ),
    );
  }
}
