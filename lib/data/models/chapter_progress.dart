import 'package:flutter/material.dart';
import '../../core/constants/historical_eras.dart';

/// Chapter progress model
@immutable
class ChapterProgress {
  final HistoricalEra era;
  final bool isUnlocked;
  final bool isCompleted;
  final int bestScore;
  final int totalQuestions;
  final DateTime? lastPlayed;
  final int attemptsCount;

  const ChapterProgress({
    required this.era,
    this.isUnlocked = false,
    this.isCompleted = false,
    this.bestScore = 0,
    this.totalQuestions = 0,
    this.lastPlayed,
    this.attemptsCount = 0,
  });

  /// Calculate progress percentage
  double get progressPercentage {
    if (totalQuestions == 0) return 0.0;
    return bestScore / totalQuestions;
  }

  /// Get star rating (0-3 stars)
  int get starRating {
    final percentage = progressPercentage;
    if (percentage >= 0.9) return 3;
    if (percentage >= 0.7) return 2;
    if (percentage >= 0.5) return 1;
    return 0;
  }

  ChapterProgress copyWith({
    bool? isUnlocked,
    bool? isCompleted,
    int? bestScore,
    int? totalQuestions,
    DateTime? lastPlayed,
    int? attemptsCount,
  }) {
    return ChapterProgress(
      era: era,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isCompleted: isCompleted ?? this.isCompleted,
      bestScore: bestScore ?? this.bestScore,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      attemptsCount: attemptsCount ?? this.attemptsCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'era': era.name,
      'isUnlocked': isUnlocked ? 1 : 0,
      'isCompleted': isCompleted ? 1 : 0,
      'bestScore': bestScore,
      'totalQuestions': totalQuestions,
      'lastPlayed': lastPlayed?.toIso8601String(),
      'attemptsCount': attemptsCount,
    };
  }

  factory ChapterProgress.fromMap(Map<String, dynamic> map) {
    return ChapterProgress(
      era: HistoricalEra.values.byName(map['era'] as String),
      isUnlocked: (map['isUnlocked'] as int) == 1,
      isCompleted: (map['isCompleted'] as int) == 1,
      bestScore: map['bestScore'] as int,
      totalQuestions: map['totalQuestions'] as int,
      lastPlayed: map['lastPlayed'] != null
          ? DateTime.parse(map['lastPlayed'] as String)
          : null,
      attemptsCount: map['attemptsCount'] as int,
    );
  }
}
