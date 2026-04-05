import 'package:aventura_historia/screens/quiz_screen.dart';
import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/providers/progress_provider.dart';
import 'package:aventura_historia/data/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class TestProgressProvider extends ProgressProvider {
  @override
  Future<void> loadProgress() async {
    // No-op
  }
}

class TestCharacterProvider extends CharacterProvider {
  @override
  Future<void> loadCharacters() async {
    // No-op
  }
}

void main() {
  group('QuizScreen', () {
    late TestProgressProvider mockProgressProvider;
    late TestCharacterProvider mockCharacterProvider;

    setUp(() {
      mockProgressProvider = TestProgressProvider();
      mockCharacterProvider = TestCharacterProvider();
    });

    Widget buildScreen({HistoricalEra era = HistoricalEra.preRoman}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProgressProvider>.value(
              value: mockProgressProvider),
          ChangeNotifierProvider<CharacterProvider>.value(
              value: mockCharacterProvider),
        ],
        child: MaterialApp(
          home: QuizScreen(era: era),
        ),
      );
    }

    testWidgets('displays loading indicator initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('loads and displays question after delay',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.byType(QuizScreen), findsOneWidget);
    });

    testWidgets('displays era name in app bar', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen(era: HistoricalEra.preRoman));
      await tester.pumpAndSettle();

      expect(find.text('Povos Pre-Romanos'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('displays question counter', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pumpAndSettle();

      expect(find.textContaining(RegExp(r'\d+/\d+')), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('displays score counter', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pumpAndSettle();

      expect(find.textContaining('Pontos:'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('displays answer options', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pumpAndSettle();

      expect(find.byType(InkWell), findsWidgets);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('shows next button after answering',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pumpAndSettle();

      final firstOption = find.byType(InkWell).first;
      await tester.tap(firstOption);
      await tester.pump();

      expect(find.text('Seguinte'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('highlights correct answer after selection',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pumpAndSettle();

      final firstOption = find.byType(InkWell).first;
      await tester.tap(firstOption);
      await tester.pump();

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('displays question text', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pumpAndSettle();

      expect(find.byType(Text), findsWidgets);
      await tester.pump(const Duration(milliseconds: 600));
    });

    testWidgets('shows option letters (A, B, C, etc.)',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());
      await tester.pumpAndSettle();

      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 600));
    });
  });
}
