import 'package:flutter/material.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/historical_eras.dart';
import '../data/models/quiz_question.dart';
import 'chapter_selection_screen.dart';

/// Quiz result screen showing score and achievements
class QuizResultScreen extends StatelessWidget {
  final HistoricalEra era;
  final int score;
  final int totalPoints;
  final List<QuizQuestion> questions;
  final Map<int, int> answers;

  const QuizResultScreen({
    super.key,
    required this.era,
    required this.score,
    required this.totalPoints,
    required this.questions,
    required this.answers,
  });

  double get percentage => totalPoints > 0 ? score / totalPoints : 0;
  int get starCount {
    if (percentage >= 0.9) return 3;
    if (percentage >= 0.7) return 2;
    if (percentage >= 0.5) return 1;
    return 0;
  }

  bool get passed => percentage >= 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Result icon
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0, end: 1),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: passed ? Colors.green : Colors.orange,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (passed ? Colors.green : Colors.orange)
                                .withOpacity(0.3),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Icon(
                        passed ? Icons.emoji_events : Icons.refresh,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                passed ? AppStrings.chapterComplete : 'Tenta Novamente!',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Score
              Text(
                '$score / $totalPoints pontos',
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 8),

              Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: passed ? Colors.green : Colors.orange,
                ),
              ),

              const SizedBox(height: 24),

              // Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 500 + (index * 200)),
                    tween: Tween(begin: 0, end: index < starCount ? 1 : 0.3),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Icon(
                          Icons.star,
                          size: 48,
                          color: index < starCount
                              ? Colors.amber
                              : Colors.grey[300],
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Character unlock notification
              if (passed && starCount >= 2)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple),
                  ),
                  child: const Column(
                    children: [
                      Icon(Icons.person_add, size: 48, color: Colors.purple),
                      SizedBox(height: 8),
                      Text(
                        AppStrings.unlockCharacter,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('Desbloqueaste uma nova personagem!'),
                    ],
                  ),
                ),

              if (passed && starCount >= 2) const SizedBox(height: 24),

              // Action buttons
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const ChapterSelectionScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.map),
                      label: const Text(AppStrings.continue_),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.replay),
                      label: const Text(AppStrings.retry),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
