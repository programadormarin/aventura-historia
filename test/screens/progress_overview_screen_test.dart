import 'package:aventura_historia/screens/progress_overview_screen.dart';
import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/models/chapter_progress.dart';
import 'package:aventura_historia/data/providers/progress_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class TestProgressProvider extends ProgressProvider {
  List<ChapterProgress> testChapters = [];
  bool testIsLoading = false;

  @override
  List<ChapterProgress> get chapters => testChapters;
  @override
  bool get isLoading => testIsLoading;
  @override
  int get totalStars => testChapters.fold(0, (sum, cp) => sum + cp.starRating);
  @override
  double get overallProgress => testChapters.isEmpty
      ? 0.0
      : testChapters.where((c) => c.isCompleted).length / testChapters.length;
}

void main() {
  group('ProgressOverviewScreen', () {
    late TestProgressProvider mockProvider;

    setUp(() {
      mockProvider = TestProgressProvider();
    });

    Widget buildScreen() {
      return ChangeNotifierProvider<ProgressProvider>.value(
        value: mockProvider,
        child: const MaterialApp(
          home: ProgressOverviewScreen(),
        ),
      );
    }

    testWidgets('displays loading indicator when loading',
        (WidgetTester tester) async {
      mockProvider.testIsLoading = true;

      await tester.pumpWidget(buildScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays overall stats when loaded',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isCompleted: true,
          bestScore: 90,
          totalQuestions: 100,
        ),
        const ChapterProgress(
          era: HistoricalEra.roman,
          isCompleted: false,
          bestScore: 50,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Estatísticas Gerais'), findsOneWidget);
      expect(find.text('Progresso'), findsNWidgets(2));
      expect(find.text('Capítulos'), findsOneWidget);
      expect(find.text('Estrelas'), findsOneWidget);
    });

    testWidgets('displays correct chapter count', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(era: HistoricalEra.preRoman, isCompleted: true),
        const ChapterProgress(era: HistoricalEra.roman, isCompleted: false),
        const ChapterProgress(era: HistoricalEra.islamic, isCompleted: true),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('2/3'), findsOneWidget);
    });

    testWidgets('displays chapter detail cards', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          isCompleted: true,
          bestScore: 90,
          totalQuestions: 100,
        ),
        const ChapterProgress(
          era: HistoricalEra.roman,
          isUnlocked: true,
          isCompleted: false,
          bestScore: 50,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Povos Pre-Romanos'), findsOneWidget);
      expect(find.text('Dominio Romano'), findsOneWidget);
    });

    testWidgets('displays progress bars for chapters',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 75,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.byType(LinearProgressIndicator), findsWidgets);
    });

    testWidgets('displays score information', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 80,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('80/100'), findsOneWidget);
    });

    testWidgets('displays era time period', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(era: HistoricalEra.preRoman),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('antes de 218 a.C.'), findsOneWidget);
    });

    testWidgets('displays overall progress percentage',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(era: HistoricalEra.preRoman, isCompleted: true),
        const ChapterProgress(era: HistoricalEra.roman, isCompleted: false),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('50%'), findsOneWidget);
    });

    testWidgets('displays total stars count', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 90,
          totalQuestions: 100,
        ),
        const ChapterProgress(
          era: HistoricalEra.roman,
          bestScore: 75,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('5/6'), findsOneWidget);
    });

    testWidgets('shows chapter status icons', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isCompleted: true,
          isUnlocked: true,
        ),
        const ChapterProgress(
          era: HistoricalEra.roman,
          isCompleted: false,
          isUnlocked: true,
        ),
        const ChapterProgress(
          era: HistoricalEra.islamic,
          isCompleted: false,
          isUnlocked: false,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.byIcon(Icons.check_circle), findsNWidgets(2)); // One in stats, one in card
      expect(find.byIcon(Icons.lock_open), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('displays detail section title', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(era: HistoricalEra.preRoman),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Detalhe por Capítulo'), findsOneWidget);
    });

    testWidgets('has scrollable content', (WidgetTester tester) async {
      mockProvider.testChapters = List.generate(
        10,
        (index) => ChapterProgress(
          era: HistoricalEra.values[index],
          bestScore: index * 10,
          totalQuestions: 100,
        ),
      );

      await tester.pumpWidget(buildScreen());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
