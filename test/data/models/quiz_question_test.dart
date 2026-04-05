import 'package:aventura_historia/data/models/quiz_question.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QuizQuestion', () {
    const easyQuestion = QuizQuestion(
      id: 'q1',
      question: 'What is 1+1?',
      options: ['1', '2', '3'],
      correctAnswerIndex: 1,
      explanation: 'Basic math',
      difficulty: DifficultyLevel.easy,
    );

    const mediumQuestion = QuizQuestion(
      id: 'q2',
      question: 'What is the capital of Portugal?',
      options: ['Porto', 'Lisbon', 'Faro', 'Braga'],
      correctAnswerIndex: 1,
      explanation: 'Geography',
      difficulty: DifficultyLevel.medium,
    );

    const hardQuestion = QuizQuestion(
      id: 'q3',
      question: 'In what year did the Battle of Ourique occur?',
      options: ['1139', '1147', '1385', '1415', '1580'],
      correctAnswerIndex: 0,
      explanation: 'Portuguese history',
      difficulty: DifficultyLevel.hard,
    );

    group('isCorrect', () {
      test('returns true for correct answer', () {
        expect(easyQuestion.isCorrect(1), isTrue);
        expect(mediumQuestion.isCorrect(1), isTrue);
        expect(hardQuestion.isCorrect(0), isTrue);
      });

      test('returns false for incorrect answers', () {
        expect(easyQuestion.isCorrect(0), isFalse);
        expect(easyQuestion.isCorrect(2), isFalse);
        expect(mediumQuestion.isCorrect(0), isFalse);
        expect(hardQuestion.isCorrect(1), isFalse);
      });
    });

    group('points', () {
      test('easy questions give 10 points', () {
        expect(easyQuestion.points, 10);
      });

      test('medium questions give 20 points', () {
        expect(mediumQuestion.points, 20);
      });

      test('hard questions give 30 points', () {
        expect(hardQuestion.points, 30);
      });
    });

    group('toMap and fromMap', () {
      test('should serialize and deserialize correctly', () {
        final map = easyQuestion.toMap();
        expect(map['id'], 'q1');
        expect(map['question'], 'What is 1+1?');
        expect(map['options'], '1|||2|||3');
        expect(map['correctAnswerIndex'], 1);
        expect(map['explanation'], 'Basic math');
        expect(map['difficulty'], 'easy');

        final restored = QuizQuestion.fromMap(map);
        expect(restored.id, 'q1');
        expect(restored.question, 'What is 1+1?');
        expect(restored.options, ['1', '2', '3']);
        expect(restored.correctAnswerIndex, 1);
        expect(restored.explanation, 'Basic math');
        expect(restored.difficulty, DifficultyLevel.easy);
      });

      test('should handle medium difficulty', () {
        final map = mediumQuestion.toMap();
        expect(map['difficulty'], 'medium');
        final restored = QuizQuestion.fromMap(map);
        expect(restored.difficulty, DifficultyLevel.medium);
        expect(restored.options, ['Porto', 'Lisbon', 'Faro', 'Braga']);
      });

      test('should handle hard difficulty', () {
        final map = hardQuestion.toMap();
        expect(map['difficulty'], 'hard');
        final restored = QuizQuestion.fromMap(map);
        expect(restored.difficulty, DifficultyLevel.hard);
        expect(restored.options, ['1139', '1147', '1385', '1415', '1580']);
      });
    });
  });

  group('DifficultyLevel', () {
    test('easy has correct displayName', () {
      expect(DifficultyLevel.easy.displayName, 'Fácil');
    });

    test('medium has correct displayName', () {
      expect(DifficultyLevel.medium.displayName, 'Médio');
    });

    test('hard has correct displayName', () {
      expect(DifficultyLevel.hard.displayName, 'Difícil');
    });

    test('easy has 3 options', () {
      expect(DifficultyLevel.easy.optionCount, 3);
    });

    test('medium has 4 options', () {
      expect(DifficultyLevel.medium.optionCount, 4);
    });

    test('hard has 5 options', () {
      expect(DifficultyLevel.hard.optionCount, 5);
    });
  });
}
