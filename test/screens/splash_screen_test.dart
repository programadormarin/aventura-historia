import 'package:aventura_historia/screens/splash_screen.dart';
import 'package:aventura_historia/screens/home_screen.dart';
import 'package:aventura_historia/data/providers/progress_provider.dart';
import 'package:aventura_historia/data/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('SplashScreen', () {
    Widget buildScreen() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProgressProvider>(
              create: (_) => TestProgressProvider()),
          ChangeNotifierProvider<CharacterProvider>(
              create: (_) => TestCharacterProvider()),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
        ),
      );
    }

    testWidgets('displays app title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.text('Aventura da História'), findsOneWidget);
      expect(find.text('História de Portugal'), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('displays loading indicator', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('displays icon in circle', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byType(Container), findsWidgets);
      expect(find.byIcon(Icons.auto_stories), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('navigates to home screen after delay',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      // Wait for the navigation delay (3 seconds) + animation
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('has gradient background', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      final containerFinder = find.byWidgetPredicate(
        (widget) => widget is Container && widget.decoration is BoxDecoration,
      );
      expect(containerFinder, findsWidgets);
      await tester.pump(const Duration(seconds: 4));
    });

    testWidgets('uses animated builder for entrance animation',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byType(AnimatedBuilder), findsWidgets);
      expect(find.byType(FadeTransition), findsWidgets);
      expect(find.byType(ScaleTransition), findsWidgets);
      
      // Clear timers
      await tester.pump(const Duration(seconds: 4));
    });
  });
}

class TestProgressProvider extends ProgressProvider {
  @override
  Future<void> loadProgress() async {}
}

class TestCharacterProvider extends CharacterProvider {
  @override
  Future<void> loadCharacters() async {}
}
