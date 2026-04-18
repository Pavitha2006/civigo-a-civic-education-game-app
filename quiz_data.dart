import 'dart:math';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

final List<QuizQuestion> quizQuestions = [
  QuizQuestion(
    question: 'At what age can a citizen vote in India?',
    options: ['16', '18', '21', '25'],
    correctIndex: 1,
  ),
  QuizQuestion(
    question: 'What does a red traffic light mean?',
    options: ['Stop', 'Go', 'Slow down', 'Turn'],
    correctIndex: 0,
  ),
];

List<QuizQuestion> getShuffledQuestions() {
  final shuffled = List<QuizQuestion>.from(quizQuestions);
  shuffled.shuffle(Random());
  return shuffled;
}
