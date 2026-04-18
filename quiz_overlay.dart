import 'package:flutter/material.dart';
import '../game_with_quiz.dart';
import 'quiz_data.dart';

class QuizOverlay extends StatefulWidget {
  final CivigoGameWithQuiz game;

  const QuizOverlay({Key? key, required this.game}) : super(key: key);

  @override
  _QuizOverlayState createState() => _QuizOverlayState();
}

class _QuizOverlayState extends State<QuizOverlay> {
  late List<QuizQuestion> questions;
  int current = 0;

  @override
  void initState() {
    super.initState();
    questions = getShuffledQuestions();
  }

  void answer(int index) {
    setState(() {
      current++;
      if (current >= questions.length) {
        widget.game.removeQuiz();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (current >= questions.length) return const SizedBox();

    final q = questions[current];

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white.withOpacity(0.9),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(q.question, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 15),
            ...List.generate(q.options.length, (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ElevatedButton(
                  onPressed: () => answer(i),
                  child: Text(q.options[i]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
