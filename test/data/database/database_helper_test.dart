import 'package:aventura_historia/data/database/database_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DatabaseHelper', () {
    test('is a singleton', () {
      expect(
        DatabaseHelper.instance,
        same(DatabaseHelper.instance),
      );
    });

    test('can be accessed', () {
      expect(DatabaseHelper.instance, isNotNull);
    });

    test('has correct table names', () {
      expect(DatabaseHelper.tableChapterProgress, 'chapter_progress');
      expect(DatabaseHelper.tableCharacters, 'characters');
      expect(DatabaseHelper.tableQuizResults, 'quiz_results');
    });

    test('has close method', () async {
      // This test verifies that the close method exists and is callable
      // Actual database operations require a real database connection
      expect(DatabaseHelper.instance.close, isA<Function>());
    });

    test('has initialize method', () async {
      // This test verifies that the initialize method exists and is callable
      expect(DatabaseHelper.instance.initialize, isA<Function>());
    });
  });
}
