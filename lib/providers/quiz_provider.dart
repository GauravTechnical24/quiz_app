import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/question_model.dart';
import '../services/mock_data_service.dart';

final quizProvider = StateNotifierProvider<QuizStateNotifier, QuizState>((ref) {
  return QuizStateNotifier();
});

class QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int score;
  final String? selectedAnswer;
  final Map<Question, String?> answers; 

  QuizState({
    required this.questions,
    required this.currentQuestionIndex,
    required this.score,
    this.selectedAnswer,
    required this.answers,
  });

  QuizState copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    int? score,
    String? selectedAnswer,
    Map<Question, String?>? answers,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      answers: answers ?? this.answers,
    );
  }
}

class QuizStateNotifier extends StateNotifier<QuizState> {
  QuizStateNotifier()
      : super(QuizState(
          questions: MockDataService.getQuestions(),
          currentQuestionIndex: 0,
          score: 0,
          selectedAnswer: null,
          answers: {}, 
        ));

void selectAnswer(String option) {
  final currentQuestion = state.questions[state.currentQuestionIndex];
  state = state.copyWith(
    selectedAnswer: option,
    answers: {
      ...state.answers, 
      currentQuestion: option, 
    },
  );
}

void answerQuestion() {
  final currentQuestion = state.questions[state.currentQuestionIndex];

  /// Ensure the selected answer is stored in the answers map
  final updatedAnswers = {
    ...state.answers,
    currentQuestion: state.selectedAnswer,
  };

  // Check if the selected answer is correct
  final selectedAnswer = updatedAnswers[currentQuestion];
  final isCorrect = selectedAnswer == currentQuestion.correctAnswer;
  print("Selected Answer: $selectedAnswer");
  print("Correct Answer: ${currentQuestion.correctAnswer}");
  print("Is Correct: $isCorrect");

  /// Update the score based on correctness
  final newScore = isCorrect ? state.score + 1 : state.score;

  if (state.currentQuestionIndex + 1 < state.questions.length) {
    /// Move to the next question
    state = state.copyWith(
      currentQuestionIndex: state.currentQuestionIndex + 1,
      score: newScore, 
      selectedAnswer: null, 
      answers: updatedAnswers, 
    );
  } else {
    /// Finalize the score for the last question
    state = state.copyWith(
      score: newScore, 
      selectedAnswer: null, 
      answers: updatedAnswers,
    );
  }
}
 void resetQuiz() {
  state = QuizState(
    questions: MockDataService.getQuestions(),
    currentQuestionIndex: 0,
    score: 0,
    selectedAnswer: null, 
    answers: {}, 
  );
}}