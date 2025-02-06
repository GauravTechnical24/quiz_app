import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/quiz_provider.dart';
import 'welcome_screen.dart';

class ResultScreen extends ConsumerWidget {
  final int score;
  const ResultScreen({required this.score, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final themeMode = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: themeMode == Brightness.light ? Colors.white : Colors.black,
      appBar: AppBar(
        title: Text(
          "Quiz Results",
          style: TextStyle(color: themeMode == Brightness.light ? Colors.black : Colors.white),
        ),
        backgroundColor: themeMode == Brightness.light ? Colors.blue.shade200 : Colors.grey.shade900,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Score Display with Animation
              FadeInAnimation(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Your Score",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: themeMode == Brightness.light ? Colors.black : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${ref.read(quizProvider).score} / ${quizState.questions.length}",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: themeMode == Brightness.light ? Colors.green : Colors.tealAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// Detailed Question Breakdown
              Text(
                "Attempted Questions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeMode == Brightness.light ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ...quizState.questions.map((question) {
                final selectedAnswer = quizState.answers[question];
                final isCorrect = selectedAnswer == question.correctAnswer;
                return QuestionSummaryTile(
                  question: question.text,
                  selectedAnswer: selectedAnswer ?? "Not Answered",
                  correctAnswer: question.correctAnswer,
                  isCorrect: isCorrect,
                );
              }).toList(),
              const SizedBox(height: 20),

              /// Restart Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(quizProvider.notifier).resetQuiz();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    backgroundColor: themeMode == Brightness.light ? Colors.blue : Colors.tealAccent,
                  ),
                  child: Text(
                    "Restart Quiz",
                    style: TextStyle(
                      fontSize: 20,
                      color: themeMode == Brightness.light ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Animation for Smooth Entry
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  const FadeInAnimation({required this.child, super.key});

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacityAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: widget.child,
        );
      },
    );
  }
}

/// Question Summary Tile for Attempted Questions
class QuestionSummaryTile extends StatelessWidget {
  final String question;
  final String selectedAnswer;
  final String correctAnswer;
  final bool isCorrect;

  const QuestionSummaryTile({
    required this.question,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeMode = Theme.of(context).brightness;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeMode == Brightness.light ? Colors.white : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question: $question",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: themeMode == Brightness.light ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Your Answer: $selectedAnswer",
            style: TextStyle(
              fontSize: 14,
              color: isCorrect ? Colors.green : Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Correct Answer: $correctAnswer",
            style: TextStyle(
              fontSize: 14,
              color: themeMode == Brightness.light ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}