import 'package:flutter/material.dart';

/// Quiz question model with difficulty levels
@immutable
class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;
  final DifficultyLevel difficulty;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.difficulty,
  });

  /// Check if the answer is correct
  bool isCorrect(int answerIndex) {
    return answerIndex == correctAnswerIndex;
  }

  /// Get points based on difficulty
  int get points {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return 10;
      case DifficultyLevel.medium:
        return 20;
      case DifficultyLevel.hard:
        return 30;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'options': options.join('|||'),
      'correctAnswerIndex': correctAnswerIndex,
      'explanation': explanation,
      'difficulty': difficulty.name,
    };
  }

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      id: map['id'] as String,
      question: map['question'] as String,
      options: (map['options'] as String).split('|||'),
      correctAnswerIndex: map['correctAnswerIndex'] as int,
      explanation: map['explanation'] as String,
      difficulty: DifficultyLevel.values.byName(map['difficulty'] as String),
    );
  }
}

/// Difficulty levels for quiz questions
enum DifficultyLevel {
  easy, // 3 options (for younger players)
  medium, // 4 options (standard)
  hard, // 5 options (challenging)
}

extension DifficultyLevelExtension on DifficultyLevel {
  String get displayName {
    switch (this) {
      case DifficultyLevel.easy:
        return 'Fácil';
      case DifficultyLevel.medium:
        return 'Médio';
      case DifficultyLevel.hard:
        return 'Difícil';
    }
  }

  /// Number of options for this difficulty
  int get optionCount {
    switch (this) {
      case DifficultyLevel.easy:
        return 3;
      case DifficultyLevel.medium:
        return 4;
      case DifficultyLevel.hard:
        return 5;
    }
  }
}
