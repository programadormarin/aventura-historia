import 'package:aventura_historia/screens/quiz_result_screen.dart';
import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/models/quiz_question.dart';
import 'package:aventura_historia/screens/chapter_selection_screen.dart';
import 'package:aventura_historia/data/providers/progress_provider.dart';
import 'package:aventura_historia/data/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('QuizResultScreen', () {
    const questions = [
      QuizQuestion(
        id: 'q1',
        question: 'Question 1',
        options: ['A', 'B', 'C'],
        correctAnswerIndex: 0,
        explanation: 'Explanation 1',
        difficulty: DifficultyLevel.easy,
      ),
      QuizQuestion(
        id: 'q2',
        question: 'Question 2',
        options: ['A', 'B', 'C', 'D'],
        correctAnswerIndex: 1,
        explanation: 'Explanation 2',
        difficulty: DifficultyLevel.medium,
      ),
    ];

    late MockProgressProvider mockProgress;
    late MockCharacterProvider mockCharacter;

    setUp(() {
      mockProgress = MockProgressProvider();
      mockCharacter = MockCharacterProvider();
    });

    Widget buildScreen(Widget child) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProgressProvider>.value(value: mockProgress),
          ChangeNotifierProvider<CharacterProvider>.value(value: mockCharacter),
        ],
        child: MaterialApp(
          home: child,
          navigatorObservers: [TestNavigatorObserver()], // Use a fresh one if needed
        ),
      );
    }

    testWidgets('displays passing result correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 30,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      expect(find.text('Capítulo Concluído!'), findsOneWidget);
      expect(find.text('30 / 30 pontos'), findsOneWidget);
      expect(find.text('100%'), findsOneWidget);
      expect(find.byIcon(Icons.emoji_events), findsOneWidget);
    });

    testWidgets('displays failing result correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 0,
            totalPoints: 30,
            questions: questions,
            answers: {0: 1, 1: 0},
          ),
        ),
      );

      expect(find.text('Tenta Novamente!'), findsOneWidget);
      expect(find.text('0 / 30 pontos'), findsOneWidget);
      expect(find.text('0%'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('shows 3 stars for 90%+ score', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 27,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      final starIcons = find.byIcon(Icons.star);
      expect(starIcons, findsNWidgets(3));
    });

    testWidgets('shows 2 stars for 70-89% score', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 21,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(seconds: 1)); // Wait for star animations

      await tester.pumpAndSettle();

      final amberStars = find.byWidgetPredicate(
        (widget) =>
            widget is Icon &&
            widget.icon == Icons.star &&
            widget.color == Colors.amber,
      );
      expect(amberStars, findsNWidgets(2));
    });

    testWidgets('shows 1 star for 50-69% score', (WidgetTester tester) async {
      // 15/30 = 50%
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 15,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      await tester.pumpAndSettle();
    });

    testWidgets('shows 0 stars for <50% score', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 10,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      await tester.pumpAndSettle();
    });

    testWidgets('shows character unlock notification when passed with 2+ stars',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 25,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Personagem Desbloqueado!'), findsOneWidget);
      expect(find.text('Desbloqueaste uma nova personagem!'), findsOneWidget);
      expect(find.byIcon(Icons.person_add), findsOneWidget);
    });

    testWidgets('does not show character unlock when failed',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 5,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      expect(find.text('Personagem Desbloqueado!'), findsNothing);
    });

    testWidgets('continue button navigates to chapter selection',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 30,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      await tester.pumpAndSettle();

      final continueButton = find.text('Continuar');
      expect(continueButton, findsOneWidget);

      await tester.ensureVisible(continueButton);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(find.byType(ChapterSelectionScreen), findsOneWidget);
    });

    testWidgets('retry button pops navigation', (WidgetTester tester) async {
      final observer = TestNavigatorObserver();
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ProgressProvider>.value(value: mockProgress),
            ChangeNotifierProvider<CharacterProvider>.value(value: mockCharacter),
          ],
          child: MaterialApp(
            home: const Scaffold(body: Text('Base')),
            navigatorObservers: [observer],
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Push QuizResultScreen
      tester.state<NavigatorState>(find.byType(Navigator)).push(
            MaterialPageRoute(
              builder: (_) => const QuizResultScreen(
                era: HistoricalEra.preRoman,
                score: 0,
                totalPoints: 30,
                questions: questions,
                answers: {0: 1, 1: 0},
              ),
            ),
          );

      await tester.pumpAndSettle();

      final retryButton = find.text('Tentar Novamente');
      expect(retryButton, findsOneWidget);

      await tester.tap(retryButton);
      await tester.pumpAndSettle();

      expect(observer.popped, isTrue);
    });

    testWidgets('displays ScrollView for scrollable content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 30,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('has safe area', (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 30,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      expect(find.byType(SafeArea), findsOneWidget);
    });

    testWidgets('percentage text has correct color for passing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 30,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      await tester.pumpAndSettle();

      final percentageText = find.text('100%');
      final textWidget = tester.widget<Text>(percentageText);
      expect(textWidget.style!.color, Colors.green);
    });

    testWidgets('percentage text has correct color for failing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 0,
            totalPoints: 30,
            questions: questions,
            answers: {0: 0, 1: 1},
          ),
        ),
      );

      await tester.pumpAndSettle();

      final percentageText = find.text('0%');
      final textWidget = tester.widget<Text>(percentageText);
      expect(textWidget.style!.color, Colors.orange);
    });

    testWidgets('handles zero total points gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        buildScreen(
          const QuizResultScreen(
            era: HistoricalEra.preRoman,
            score: 0,
            totalPoints: 0,
            questions: [],
            answers: {},
          ),
        ),
      );

      expect(find.text('0%'), findsOneWidget);
    });
  });
}

class MockProgressProvider extends ProgressProvider {
  @override
  Future<void> loadProgress() async {}
}

class MockCharacterProvider extends CharacterProvider {
  @override
  Future<void> loadCharacters() async {}
}

class TestNavigatorObserver extends NavigatorObserver {
  bool popped = false;
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    popped = true;
    super.didPop(route, previousRoute);
  }
}
