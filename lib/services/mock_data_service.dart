import 'package:quize_app/model/question_model.dart';

class MockDataService {
  static List<Question> getQuestions() {
    return [
      Question(
        text: "What is the capital of India?",
        options: ["Mumbai", "New Delhi", "Kolkata", "Chennai"],
        correctAnswer: "New Delhi",
      ),
      Question(
        text: "Who is known as the 'Father of the Indian Constitution'?",
        options: [
          "Jawaharlal Nehru",
          "B.R. Ambedkar",
          "Mahatma Gandhi",
          "Sardar Patel"
        ],
        correctAnswer: "B.R. Ambedkar",
      ),
      Question(
        text: "Which Indian state is known as the 'Land of Five Rivers'?",
        options: ["Punjab", "Rajasthan", "Gujarat", "Uttar Pradesh"],
        correctAnswer: "Punjab",
      ),
      Question(
        text: "The Indian rupee (₹) is pegged to the US dollar.",
        options: ["True", "False"],
        correctAnswer: "False",
      ),
      Question(
        text: "What is the name of the first satellite launched by India?",
        options: ["INSAT-1A", "Aryabhata", "Chandrayaan-1", "Mangalyaan"],
        correctAnswer: "Aryabhata",
      ),
      Question(
        text:
            "Which programming language is primarily used for Android app development?",
        options: ["Python", "Java", "C++", "Ruby"],
        correctAnswer: "Java",
      ),
      Question(
        text: "India is the largest democracy in the world.",
        options: ["True", "False"],
        correctAnswer: "True",
      ),
      Question(
        text: "Which cricketer has the nickname 'The Wall'?",
        options: [
          "Sachin Tendulkar",
          "Virat Kohli",
          "Rahul Dravid",
          "MS Dhoni"
        ],
        correctAnswer: "Rahul Dravid",
      ),
      Question(
        text: "Which of the following is NOT a primary color?",
        options: ["Red", "Blue", "Green", "Yellow"],
        correctAnswer: "Yellow",
      ),
      Question(
        text: "The Taj Mahal is made entirely of marble.",
        options: ["True", "False"],
        correctAnswer: "False",
      ),
    ];
  }
}
