import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_strings.dart';
import '../core/constants/historical_eras.dart';
import '../data/models/chapter_progress.dart';
import '../data/providers/progress_provider.dart';
import 'quiz_screen.dart';

/// Chapter selection screen with timeline map visualization
class ChapterSelectionScreen extends StatelessWidget {
  const ChapterSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressProvider = context.watch<ProgressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.selectChapter),
      ),
      body: progressProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // Timeline header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Linha Temporal da História de Portugal',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Seleciona um capítulo para começar a aprender!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Timeline chapters
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final progress = progressProvider.chapters[index];
                        return _TimelineChapterCard(
                          progress: progress,
                          index: index,
                          onTap: () => _onChapterTap(context, progress),
                        );
                      },
                      childCount: progressProvider.chapters.length,
                    ),
                  ),
                ),

                // Bottom spacing
                const SliverToBoxAdapter(
                  child: SizedBox(height: 32),
                ),
              ],
            ),
    );
  }

  void _onChapterTap(BuildContext context, ChapterProgress progress) {
    if (!progress.isUnlocked) {
      _showLockedDialog(context, progress);
      return;
    }

    // Navigate to quiz screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => QuizScreen(era: progress.era),
      ),
    );
  }

  void _showLockedDialog(BuildContext context, ChapterProgress progress) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.locked),
        content: Text(
          'Completa o capítulo anterior para desbloquear "${progress.era.displayName}"!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(AppStrings.cancel),
          ),
        ],
      ),
    );
  }
}

/// Timeline chapter card widget
class _TimelineChapterCard extends StatelessWidget {
  final ChapterProgress progress;
  final int index;
  final VoidCallback onTap;

  const _TimelineChapterCard({
    required this.progress,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(progress.era.eraColors['primary']!);
    final secondaryColor = Color(progress.era.eraColors['secondary']!);
    final isLocked = !progress.isUnlocked;
    final isCompleted = progress.isCompleted;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLocked ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isLocked
                    ? [Colors.grey[300]!, Colors.grey[400]!]
                    : [primaryColor, secondaryColor],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isLocked
                      ? Colors.grey
                      : primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Chapter number circle
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(Icons.check,
                              color: Colors.green, size: 28)
                          : Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
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
                          progress.era.displayName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isLocked ? Colors.grey[600] : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          progress.era.timePeriod,
                          style: TextStyle(
                            fontSize: 13,
                            color: isLocked ? Colors.grey[500] : Colors.white70,
                          ),
                        ),
                        if (!isLocked && !isCompleted) ...[
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: progress.progressPercentage,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            minHeight: 6,
                          ),
                        ],
                        if (!isLocked) ...[
                          const SizedBox(height: 4),
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
                                'Melhor: ${progress.bestScore}/${progress.totalQuestions}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isLocked
                                      ? Colors.grey[500]
                                      : Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Lock icon or arrow
                  Icon(
                    isLocked ? Icons.lock : Icons.arrow_forward_ios,
                    color: isLocked ? Colors.grey[600] : Colors.white70,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
