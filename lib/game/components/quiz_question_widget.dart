import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

/// Simple Flame game component for quiz questions
/// This provides animated transitions and game-like effects
class QuizQuestionWidget extends PositionComponent with TapCallbacks {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final Function(int) onAnswerSelected;

  late TextComponent _questionText;
  final List<TextComponent> _optionComponents = [];
  bool _isAnswered = false;

  QuizQuestionWidget({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.onAnswerSelected,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add question text
    _questionText = TextComponent(
      text: question,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
    add(_questionText);

    // Add option buttons
    for (int i = 0; i < options.length; i++) {
      final option = TextComponent(
        text: '${String.fromCharCode(65 + i)}. ${options[i]}',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      );
      _optionComponents.add(option);
      add(option);
    }

    _layoutComponents();
  }

  void _layoutComponents() {
    // Position question at top
    _questionText.position = Vector2(20, 20);

    // Position options below
    final startY = _questionText.y + _questionText.height + 40;
    for (int i = 0; i < _optionComponents.length; i++) {
      _optionComponents[i].position = Vector2(20, startY + (i * 50));
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (_isAnswered) return;

    final touchPoint = event.localPosition;

    // Check if any option was tapped
    for (int i = 0; i < _optionComponents.length; i++) {
      if (_optionComponents[i].containsPoint(touchPoint)) {
        _selectAnswer(i);
        return;
      }
    }
  }

  void _selectAnswer(int index) {
    _isAnswered = true;
    onAnswerSelected(index);

    // Animate correct answer
    if (index == correctAnswerIndex) {
      _showSuccessEffect();
    } else {
      _showErrorEffect();
    }
  }

  void _showSuccessEffect() {
    // Add particle effect or animation for correct answer
    // This is a placeholder - in production you'd add flame particles
  }

  void _showErrorEffect() {
    // Add shake effect for wrong answer
  }
}
