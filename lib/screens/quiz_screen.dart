import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/historical_eras.dart';
import '../data/models/quiz_question.dart';
import '../data/providers/progress_provider.dart';
import '../data/providers/character_provider.dart';
import '../game/services/quiz_service.dart';
import 'quiz_result_screen.dart';

/// Quiz screen with multiple-choice questions
class QuizScreen extends StatefulWidget {
  final HistoricalEra era;

  const QuizScreen({super.key, required this.era});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late QuizService _quizService;
  late AnimationController _animationController;

  List<QuizQuestion> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _selectedAnswer = -1;
  bool _answered = false;
  bool _isLoading = true;

  final Map<int, int> _answers = {}; // question index -> selected answer

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _quizService = QuizService();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      _questions = await _quizService.getQuestionsForEra(widget.era);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar perguntas: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectAnswer(int answerIndex) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = answerIndex;
      _answered = true;
      _answers[_currentQuestionIndex] = answerIndex;

      final currentQuestion = _questions[_currentQuestionIndex];
      if (currentQuestion.isCorrect(answerIndex)) {
        _score += currentQuestion.points;
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
      }
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = -1;
        _answered = false;
      });
    } else {
      _completeQuiz();
    }
  }

  Future<void> _completeQuiz() async {
    final progressProvider = context.read<ProgressProvider>();

    await progressProvider.completeChapter(
      era: widget.era,
      score: _score,
      totalQuestions: _questions.fold(0, (sum, q) => sum + q.points),
    );

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            era: widget.era,
            score: _score,
            totalPoints: _questions.fold(0, (sum, q) => sum + q.points),
            questions: _questions,
            answers: _answers,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text(AppStrings.question)),
        body: const Center(
          child: Text('Sem perguntas disponíveis para este capítulo.'),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final characterProvider = context.watch<CharacterProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.era.displayName),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_currentQuestionIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Pontos: $_score',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active character hint (if available)
              if (characterProvider.activeCharacter?.era == widget.era) ...[
                _buildCharacterHint(characterProvider.activeCharacter!),
                const SizedBox(height: 16),
              ],

              // Difficulty badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(currentQuestion.difficulty),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  currentQuestion.difficulty.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Question text
              Text(
                currentQuestion.question,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Answer options
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    return _AnswerOption(
                      option: currentQuestion.options[index],
                      index: index,
                      isSelected: _selectedAnswer == index,
                      isAnswered: _answered,
                      isCorrect: currentQuestion.isCorrect(index),
                      onTap: () => _selectAnswer(index),
                    );
                  },
                ),
              ),

              // Next button
              if (_answered)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _nextQuestion,
                      icon: Icon(
                        _currentQuestionIndex < _questions.length - 1
                            ? Icons.arrow_forward
                            : Icons.check,
                      ),
                      label: Text(
                        _currentQuestionIndex < _questions.length - 1
                            ? AppStrings.next
                            : AppStrings.quizComplete,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacterHint(character) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: character.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: character.accentColor),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: character.accentColor,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${character.name}: "Boa sorte! Lembra-te do que aprendeste!"',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return Colors.green;
      case DifficultyLevel.medium:
        return Colors.orange;
      case DifficultyLevel.hard:
        return Colors.red;
    }
  }
}

/// Answer option widget
class _AnswerOption extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final bool isAnswered;
  final bool isCorrect;
  final VoidCallback onTap;

  const _AnswerOption({
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isAnswered,
    required this.isCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.grey[300]!;
    Color backgroundColor = Colors.white;

    if (isAnswered) {
      if (isCorrect) {
        borderColor = Colors.green;
        backgroundColor = Colors.green[50]!;
      } else if (isSelected && !isCorrect) {
        borderColor = Colors.red;
        backgroundColor = Colors.red[50]!;
      }
    } else if (isSelected) {
      borderColor = Theme.of(context).colorScheme.primary;
      backgroundColor =
          Theme.of(context).colorScheme.primary.withOpacity(0.1);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: isAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: borderColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index), // A, B, C, D...
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    option,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                if (isAnswered)
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
