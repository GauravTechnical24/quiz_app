# quize_app

Flutter version : 3.27.4
Dart version: 3.6.2

Core Functionality
1. Quiz Flow
    Users are presented with a series of questions one at a time.
    Each question has multiple-choice options.
    Users can select an answer and proceed to the next question using the "Next" button (or "Submit" on the last question).

2. Timer
A 30-second countdown timer is provided for each question.
    If the timer expires:
    Automatically moves to the next question.
    Skips unanswered questions without updating the score.

3. Score Calculation
    Correct answers increment the score.
    Incorrect or unanswered questions do not affect the score.
    Final score is displayed on the ResultScreen after completing all questions.

4. Progress Tracking
    Displays the current question number and total questions (e.g., "Q1: Question Text").
    Includes a visual progress indicator showing the user's progress through the quiz.

5. Navigation
    Prevents users from exiting the quiz prematurely using the back button.
    Shows a confirmation dialog if the user attempts to quit the quiz early.

6. Result Screen
    Displays the final score (e.g., "2/2").
    Provides a detailed breakdown of all questions:
    Shows the user's selected answer for each question.
    Highlights correct and incorrect answers.
    Includes a "Restart Quiz" button to reset the quiz and start over.

7. Themes
    Supports both light and dark themes.
    Dynamically adjusts colors based on the selected theme.

8. Edge Case Handling
    Handles unanswered questions gracefully:
    Automatically moves to the next question if no answer is selected.
    Does not update the score for unanswered questions.
    Ensures proper navigation even if the timer expires on the last question.
