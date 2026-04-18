import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game_with_quiz.dart';
import 'quiz/quiz_overlay.dart';

void main() {
  final game = CivigoGameWithQuiz();

  runApp(
    GameWidget<CivigoGameWithQuiz>(
      game: game,
      overlayBuilderMap: {
        'QuizOverlay': (context, game) => QuizOverlay(game: game),
      },
    ),
  );
}
