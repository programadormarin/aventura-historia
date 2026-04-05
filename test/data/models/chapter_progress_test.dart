import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/models/chapter_progress.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChapterProgress', () {
    test('default constructor sets correct defaults', () {
      const progress = ChapterProgress(era: HistoricalEra.preRoman);

      expect(progress.era, HistoricalEra.preRoman);
      expect(progress.isUnlocked, isFalse);
      expect(progress.isCompleted, isFalse);
      expect(progress.bestScore, 0);
      expect(progress.totalQuestions, 0);
      expect(progress.lastPlayed, isNull);
      expect(progress.attemptsCount, 0);
    });

    test('constructor with custom values', () {
      final now = DateTime.now();
      final progress = ChapterProgress(
        era: HistoricalEra.roman,
        isUnlocked: true,
        isCompleted: true,
        bestScore: 90,
        totalQuestions: 10,
        lastPlayed: now,
        attemptsCount: 3,
      );

      expect(progress.era, HistoricalEra.roman);
      expect(progress.isUnlocked, isTrue);
      expect(progress.isCompleted, isTrue);
      expect(progress.bestScore, 90);
      expect(progress.totalQuestions, 10);
      expect(progress.lastPlayed, now);
      expect(progress.attemptsCount, 3);
    });

    group('progressPercentage', () {
      test('returns 0 when no questions', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 0,
          totalQuestions: 0,
        );
        expect(progress.progressPercentage, 0.0);
      });

      test('calculates correct percentage', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 80,
          totalQuestions: 100,
        );
        expect(progress.progressPercentage, 0.8);
      });

      test('handles 100% score', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 100,
          totalQuestions: 100,
        );
        expect(progress.progressPercentage, 1.0);
      });

      test('handles low score', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 25,
          totalQuestions: 100,
        );
        expect(progress.progressPercentage, 0.25);
      });
    });

    group('starRating', () {
      test('returns 0 stars for less than 50%', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 40,
          totalQuestions: 100,
        );
        expect(progress.starRating, 0);
      });

      test('returns 1 star for 50-69%', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 50,
          totalQuestions: 100,
        );
        expect(progress.starRating, 1);

        const progress69 = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 69,
          totalQuestions: 100,
        );
        expect(progress69.starRating, 1);
      });

      test('returns 2 stars for 70-89%', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 70,
          totalQuestions: 100,
        );
        expect(progress.starRating, 2);

        const progress89 = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 89,
          totalQuestions: 100,
        );
        expect(progress89.starRating, 2);
      });

      test('returns 3 stars for 90%+', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 90,
          totalQuestions: 100,
        );
        expect(progress.starRating, 3);

        const progress100 = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 100,
          totalQuestions: 100,
        );
        expect(progress100.starRating, 3);
      });

      test('returns 0 stars when no questions', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 0,
          totalQuestions: 0,
        );
        expect(progress.starRating, 0);
      });
    });

    group('copyWith', () {
      test('returns same object when no parameters', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          bestScore: 50,
        );

        final copied = progress.copyWith();

        expect(copied.era, progress.era);
        expect(copied.isUnlocked, progress.isUnlocked);
        expect(copied.bestScore, progress.bestScore);
      });

      test('updates only specified fields', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: false,
          isCompleted: false,
          bestScore: 50,
          totalQuestions: 10,
          attemptsCount: 1,
        );

        final copied = progress.copyWith(
          isCompleted: true,
          bestScore: 80,
          attemptsCount: 2,
        );

        expect(copied.era, HistoricalEra.preRoman);
        expect(copied.isUnlocked, isFalse);
        expect(copied.isCompleted, isTrue);
        expect(copied.bestScore, 80);
        expect(copied.totalQuestions, 10);
        expect(copied.attemptsCount, 2);
      });
    });

    group('toMap and fromMap', () {
      test('should serialize and deserialize correctly', () {
        final now = DateTime.now();
        final progress = ChapterProgress(
          era: HistoricalEra.roman,
          isUnlocked: true,
          isCompleted: true,
          bestScore: 90,
          totalQuestions: 10,
          lastPlayed: now,
          attemptsCount: 3,
        );

        final map = progress.toMap();
        expect(map['era'], 'roman');
        expect(map['isUnlocked'], 1);
        expect(map['isCompleted'], 1);
        expect(map['bestScore'], 90);
        expect(map['totalQuestions'], 10);
        expect(map['attemptsCount'], 3);

        final restored = ChapterProgress.fromMap(map);
        expect(restored.era, HistoricalEra.roman);
        expect(restored.isUnlocked, isTrue);
        expect(restored.isCompleted, isTrue);
        expect(restored.bestScore, 90);
        expect(restored.totalQuestions, 10);
        expect(restored.attemptsCount, 3);
      });

      test('should handle null lastPlayed', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          lastPlayed: null,
        );

        final map = progress.toMap();
        expect(map['lastPlayed'], isNull);

        final restored = ChapterProgress.fromMap(map);
        expect(restored.lastPlayed, isNull);
      });

      test('should handle unlocked/completed as integers', () {
        const progress = ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: false,
          isCompleted: false,
        );

        final map = progress.toMap();
        expect(map['isUnlocked'], 0);
        expect(map['isCompleted'], 0);
      });
    });
  });
}
