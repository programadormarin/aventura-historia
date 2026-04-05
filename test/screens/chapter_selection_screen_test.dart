import 'package:aventura_historia/screens/chapter_selection_screen.dart';
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
}

void main() {
  group('ChapterSelectionScreen', () {
    late TestProgressProvider mockProvider;

    setUp(() {
      mockProvider = TestProgressProvider();
    });

    Widget buildScreen() {
      return ChangeNotifierProvider<ProgressProvider>.value(
        value: mockProvider,
        child: const MaterialApp(
          home: ChapterSelectionScreen(),
        ),
      );
    }

    testWidgets('displays loading indicator when loading',
        (WidgetTester tester) async {
      mockProvider.testIsLoading = true;

      await tester.pumpWidget(buildScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays chapter list when loaded',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          isCompleted: false,
          bestScore: 50,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Povos Pre-Romanos'), findsOneWidget);
      expect(find.text('antes de 218 a.C.'), findsOneWidget);
    });

    testWidgets('displays timeline header', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(era: HistoricalEra.preRoman, isUnlocked: true),
      ];

      await tester.pumpWidget(buildScreen());

      expect(
          find.text('Linha Temporal da História de Portugal'), findsOneWidget);
      expect(find.text('Seleciona um capítulo para começar a aprender!'),
          findsOneWidget);
    });

    testWidgets('shows locked chapter with lock icon',
        (WidgetTester tester) async {
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
          isUnlocked: false,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Dominio Romano'), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('shows unlocked chapter with arrow icon',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          isCompleted: false,
          bestScore: 50,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.byIcon(Icons.arrow_forward_ios), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsNothing);
    });

    testWidgets('shows stars for unlocked chapters',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          bestScore: 80,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.byIcon(Icons.star), findsWidgets);
    });

    testWidgets('shows best score for unlocked chapters',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          bestScore: 75,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Melhor: 75/100'), findsOneWidget);
    });

    testWidgets('shows progress bar for incomplete chapters',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          isCompleted: false,
          bestScore: 60,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows checkmark for completed chapters',
        (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          isCompleted: true,
          bestScore: 90,
          totalQuestions: 100,
        ),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('displays app bar with title', (WidgetTester tester) async {
      mockProvider.testChapters = [
        const ChapterProgress(era: HistoricalEra.preRoman, isUnlocked: true),
      ];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Selecionar Capítulo'), findsOneWidget);
    });
  });
}
