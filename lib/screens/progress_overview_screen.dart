import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/historical_eras.dart';
import '../data/models/chapter_progress.dart';
import '../data/providers/progress_provider.dart';

/// Progress overview screen showing detailed stats
class ProgressOverviewScreen extends StatelessWidget {
  const ProgressOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.progress),
      ),
      body: progressProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Overall stats
                  _buildOverallStats(context, progressProvider),
                  const SizedBox(height: 24),

                  // Chapter-by-chapter breakdown
                  const Text(
                    'Detalhe por Capítulo',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  ...progressProvider.chapters.map((chapterProgress) {
                    return _ChapterProgressCard(progress: chapterProgress);
                  }),
                ],
              ),
            ),
    );
  }

  Widget _buildOverallStats(BuildContext context, ProgressProvider provider) {
    final completedChapters =
        provider.chapters.where((c) => c.isCompleted).length;
    final totalChapters = provider.chapters.length;
    final totalStars = provider.totalStars;
    final maxStars = totalChapters * 3;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Estatísticas Gerais',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(
                  icon: Icons.check_circle,
                  value: '$completedChapters/$totalChapters',
                  label: 'Capítulos',
                  color: Colors.green,
                ),
                _StatItem(
                  icon: Icons.star,
                  value: '$totalStars/$maxStars',
                  label: 'Estrelas',
                  color: Colors.amber,
                ),
                _StatItem(
                  icon: Icons.trending_up,
                  value: '${(provider.overallProgress * 100).toInt()}%',
                  label: 'Progresso',
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Stat item widget
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

/// Chapter progress card
class _ChapterProgressCard extends StatelessWidget {
  final ChapterProgress progress;

  const _ChapterProgressCard({required this.progress});

  @override
  Widget build(BuildContext context) {
    final era = progress.era;
    final eraColors = era.eraColors;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Chapter number
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(eraColors['primary']!),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${era.chapterNumber}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Chapter info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    era.displayName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    era.timePeriod,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),

                  // Progress bar
                  LinearProgressIndicator(
                    value: progress.progressPercentage,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(eraColors['primary']!),
                    ),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 4),

                  // Stars and score
                  Row(
                    children: [
                      ...List.generate(
                        3,
                        (i) => Icon(
                          i < progress.starRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${progress.bestScore}/${progress.totalQuestions}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status icon
            Icon(
              progress.isCompleted
                  ? Icons.check_circle
                  : progress.isUnlocked
                      ? Icons.lock_open
                      : Icons.lock,
              color: progress.isCompleted
                  ? Colors.green
                  : progress.isUnlocked
                      ? Colors.orange
                      : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
