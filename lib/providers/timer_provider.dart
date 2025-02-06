import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quize_app/providers/quiz_provider.dart';
import 'package:quize_app/screens/result_screen.dart';
import 'package:quize_app/services/navigator_service.dart';
import 'package:quize_app/utils/sound_effects.dart';

final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier(ref);
});

class TimerNotifier extends StateNotifier<int> {
  final Ref _ref;
  Timer? _timer;

  TimerNotifier(this._ref) : super(30);

  void startTimer() {
    _timer?.cancel();
    state = 30; 
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--; 
      } else {
        _timer?.cancel();
        _moveToNextQuestion();
      }
    });
  }

  /// Restart the timer immediately after resetting
  void resetTimer() {
    _timer?.cancel();
    state = 30; 
    startTimer(); 
  }

 Future<void> _moveToNextQuestion() async {
  final quizState = _ref.read(quizProvider);

 /// If the user has selected an answer but not clicked "Next," store the answer
  if (quizState.selectedAnswer != null) {
    _ref.read(quizProvider.notifier).answerQuestion();
  }

  /// Check if the user is on the last question
  if (quizState.currentQuestionIndex == quizState.questions.length - 1) {
    await SoundEffects.soundOne();
    /// Navigate to the result screen if on the last question
    NavigationService.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => ResultScreen(score: quizState.score),
      ),
    );
    return;
  }

  /// Move to the next question if not on the last question
  if (quizState.selectedAnswer == null) {
    /// If no answer is selected, proceed without updating the score
    _ref.read(quizProvider.notifier).answerQuestion();
    
  }
/// Restart the timer for the next question
    startTimer();
  
}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}