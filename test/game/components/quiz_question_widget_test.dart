import 'package:aventura_historia/game/components/quiz_question_widget.dart';
import 'package:aventura_historia/game/components/placeholder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flame/components.dart';

void main() {
  group('QuizQuestionWidget', () {
    test('can be instantiated', () {
      final component = QuizQuestionWidget(
        question: 'Test question?',
        options: ['A', 'B', 'C'],
        correctAnswerIndex: 0,
        onAnswerSelected: (index) {},
      );

      expect(component.question, 'Test question?');
      expect(component.options, ['A', 'B', 'C']);
      expect(component.correctAnswerIndex, 0);
    });

    test('stores callback function', () {
      final component = QuizQuestionWidget(
        question: 'What is 2+2?',
        options: ['3', '4', '5'],
        correctAnswerIndex: 1,
        onAnswerSelected: (index) {},
      );

      expect(component.onAnswerSelected, isNotNull);
    });

    test('has default position and size', () {
      final component = QuizQuestionWidget(
        question: 'Test?',
        options: ['A'],
        correctAnswerIndex: 0,
        onAnswerSelected: (index) {},
      );

      expect(component.position, Vector2.zero());
      expect(component.size, Vector2.zero());
    });

    test('accepts different numbers of options', () {
      final component3 = QuizQuestionWidget(
        question: 'Test?',
        options: ['A', 'B', 'C'],
        correctAnswerIndex: 0,
        onAnswerSelected: (index) {},
      );

      final component5 = QuizQuestionWidget(
        question: 'Test?',
        options: ['A', 'B', 'C', 'D', 'E'],
        correctAnswerIndex: 2,
        onAnswerSelected: (index) {},
      );

      expect(component3.options.length, 3);
      expect(component5.options.length, 5);
    });
  });

  group('PlaceholderComponent', () {
    test('can be instantiated', () {
      final component = PlaceholderComponent();
      expect(component, isNotNull);
    });

    test('has default size', () {
      final component = PlaceholderComponent();
      expect(component.size, Vector2.zero());
    });
  });
}
