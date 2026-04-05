import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';
import '../models/chapter_progress.dart';
import '../../core/constants/historical_eras.dart';

/// Provider for managing and tracking player progress across chapters
class ProgressProvider extends ChangeNotifier {
  List<ChapterProgress> _chapters = [];
  bool _isLoading = false;
  String? _error;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  List<ChapterProgress> get chapters => List.unmodifiable(_chapters);
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load all chapter progress from database
  Future<void> loadProgress() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _chapters = await DatabaseHelper.instance.getAllChapterProgress();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Erro ao carregar progresso: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get progress for specific era
  ChapterProgress? getProgressForEra(HistoricalEra era) {
    try {
      return _chapters.firstWhere((cp) => cp.era == era);
    } catch (e) {
      return null;
    }
  }

  /// Update chapter progress after quiz completion
  Future<void> completeChapter({
    required HistoricalEra era,
    required int score,
    required int totalQuestions,
  }) async {
    final currentIndex = _chapters.indexWhere((cp) => cp.era == era);
    if (currentIndex == -1) return;

    final currentProgress = _chapters[currentIndex];
    final newBestScore =
        score > currentProgress.bestScore ? score : currentProgress.bestScore;
    final isCompleted = score / totalQuestions >= 0.5; // 50% to pass

    final updatedProgress = currentProgress.copyWith(
      isCompleted: isCompleted,
      bestScore: newBestScore,
      totalQuestions: totalQuestions,
      lastPlayed: DateTime.now(),
      attemptsCount: currentProgress.attemptsCount + 1,
    );

    // Update database
    await DatabaseHelper.instance.updateChapterProgress(updatedProgress);

    // Update local state
    _chapters[currentIndex] = updatedProgress;

    // Unlock next chapter if completed
    if (isCompleted) {
      await DatabaseHelper.instance.unlockNextChapter(era.name);

      // Reload to get updated unlock states
      await loadProgress();
      return;
    }

    notifyListeners();
  }

  /// Get overall progress percentage
  double get overallProgress {
    if (_chapters.isEmpty) return 0.0;
    final completedChapters = _chapters.where((cp) => cp.isCompleted).length;
    return completedChapters / _chapters.length;
  }

  /// Get total stars earned
  int get totalStars {
    return _chapters.fold(0, (sum, cp) => sum + cp.starRating);
  }

  /// Check if a chapter is unlocked
  bool isChapterUnlocked(HistoricalEra era) {
    try {
      final progress = _chapters.firstWhere((cp) => cp.era == era);
      return progress.isUnlocked;
    } catch (e) {
      return false;
    }
  }
}
