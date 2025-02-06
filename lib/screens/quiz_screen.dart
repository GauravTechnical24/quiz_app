import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quize_app/providers/theme_provider.dart';
import 'package:quize_app/utils/sound_effects.dart';
import '../widgets/answer_button.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/progress_indicator.dart';
import '../providers/quiz_provider.dart';
import '../providers/timer_provider.dart';
import 'result_screen.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  @override
  void initState() {
    super.initState();

    /// Start the timer when the screen loads
    Future.microtask(() {
      ref.read(timerProvider.notifier).startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final currentQuestion = quizState.questions[quizState.currentQuestionIndex];
    final timeLeft = ref.watch(timerProvider);

    return PopScope(
      canPop: false, // Prevent default back button behavior
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          // Show a confirmation dialog when the user presses the back button
          await _showExitConfirmationDialog(
              context, ref.read(quizProvider).score);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ref.watch(themeProvider) == ThemeMode.light
                  ? [Colors.blue.shade200, Colors.purple.shade300]
                  : [Colors.grey.shade900, Colors.black87],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                CountdownTimer(),
                ProgressIndicatorWidget(
                  current: quizState.currentQuestionIndex + 1,
                  total: quizState.questions.length,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Question Container with Shadow Effect
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ref.watch(themeProvider) == ThemeMode.light
                                ? Colors.white
                                : Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            "Q${quizState.currentQuestionIndex + 1}: ${currentQuestion.text}", // Add question number
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ref.watch(themeProvider) == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...currentQuestion.options.map((option) {
                          final isSelected = quizState.selectedAnswer == option;
                          final isCorrect =
                              option == currentQuestion.correctAnswer;
                          return AnswerButton(
                            option: option,
                            onTap: () {
                              /// Highlight the selected option but don't navigate yet
                              ref
                                  .read(quizProvider.notifier)
                                  .selectAnswer(option);
                            },
                            isSelected: isSelected,
                            isCorrect: isCorrect,
                          );
                        }).toList(),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () async {
                            /// Prevent multiple navigations
                            if (quizState.currentQuestionIndex <
                                quizState.questions.length) {
                              ref.read(quizProvider.notifier).answerQuestion();
                              ref.read(timerProvider.notifier).resetTimer();
                              if (quizState.currentQuestionIndex >=
                                  quizState.questions.length - 1) {
                                await SoundEffects.soundOne();
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ResultScreen(
                                        score: ref.read(quizProvider).score),
                                  ),
                                  (route) => false,
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor:
                                ref.watch(themeProvider) == ThemeMode.light
                                    ? Colors.blue
                                    : Colors.tealAccent,
                          ),
                          child: Text(
                            quizState.currentQuestionIndex >=
                                    quizState.questions.length - 1
                                ? "Submit"
                                : "Next",
                            style: TextStyle(
                              fontSize: 20,
                              color: ref.watch(themeProvider) == ThemeMode.light
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Show Exit Confirmation Dialog
  Future<void> _showExitConfirmationDialog(
      BuildContext context, int currentScore) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Exit Quiz"),
        content: Text("Do you want to continue the quiz or quit?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Continue the quiz
            },
            child: Text("Continue"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Quit the quiz
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => ResultScreen(
                      score: currentScore), // Pass the current score
                ),
                (route) => false, // Remove all previous screens
              );
            },
            child: Text("Quit"),
          ),
        ],
      ),
    );
  }
}
