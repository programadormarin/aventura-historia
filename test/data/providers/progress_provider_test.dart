import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/providers/progress_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProgressProvider', () {
    late ProgressProvider progressProvider;

    setUp(() {
      progressProvider = ProgressProvider();
    });

    tearDown(() {
      progressProvider.dispose();
    });

    group('initial state', () {
      test('starts with empty chapters', () {
        expect(progressProvider.chapters.isEmpty, isTrue);
      });

      test('starts with isLoading false', () {
        expect(progressProvider.isLoading, isFalse);
      });

      test('starts with null error', () {
        expect(progressProvider.error, isNull);
      });
    });

    group('getProgressForEra', () {
      test('returns null when no chapters loaded', () {
        final progress =
            progressProvider.getProgressForEra(HistoricalEra.preRoman);
        expect(progress, isNull);
      });
    });

    group('overallProgress', () {
      test('returns 0 when no chapters', () {
        expect(progressProvider.overallProgress, 0.0);
      });
    });

    group('totalStars', () {
      test('returns 0 when no chapters', () {
        expect(progressProvider.totalStars, 0);
      });
    });

    group('isChapterUnlocked', () {
      test('returns false when no chapters loaded', () {
        expect(progressProvider.isChapterUnlocked(HistoricalEra.preRoman),
            isFalse);
      });
    });
  });
}
