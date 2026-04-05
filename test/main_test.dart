import 'package:aventura_historia/main.dart';
import 'package:aventura_historia/screens/splash_screen.dart';
import 'package:aventura_historia/data/providers/progress_provider.dart';
import 'package:aventura_historia/data/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  group('AventuraHistoriaApp', () {
    late MockProgressProvider mockProgress;
    late MockCharacterProvider mockCharacter;

    setUp(() {
      mockProgress = MockProgressProvider();
      mockCharacter = MockCharacterProvider();
    });

    Widget buildApp() {
      return AventuraHistoriaApp(
        progressProvider: mockProgress,
        characterProvider: mockCharacter,
      );
    }

    testWidgets('renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump();
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('displays splash screen initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());

      expect(find.byType(SplashScreen), findsOneWidget);
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer
    });

    testWidgets('has no debug banner', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.debugShowCheckedModeBanner, isFalse);
    });

    testWidgets('uses portuguese locale', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.locale, const Locale('pt', 'PT'));
    });

    testWidgets('supports pt-PT locale', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.supportedLocales, contains(const Locale('pt', 'PT')));
    });

    testWidgets('has localization delegates', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.localizationsDelegates, isNotNull);
      expect(
          materialApp.localizationsDelegates!.length, greaterThanOrEqualTo(3));
    });

    testWidgets('has providers configured', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      expect(find.byType(MultiProvider), findsOneWidget);
    });

    testWidgets('progress provider is available', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());

      final context = tester.element(find.byType(SplashScreen));
      expect(context.read<ProgressProvider>(), isNotNull);
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer
    });

    testWidgets('character provider is available', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());

      final context = tester.element(find.byType(SplashScreen));
      expect(context.read<CharacterProvider>(), isNotNull);
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer
    });

    testWidgets('uses system theme mode', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp).first);
      expect(materialApp.themeMode, ThemeMode.system);
    });

    testWidgets('has light and dark themes configured',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp).first);
      expect(materialApp.theme, isNotNull);
      expect(materialApp.darkTheme, isNotNull);
    });

    testWidgets('app title is set correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());
      await tester.pump(const Duration(seconds: 4)); // Clear splash timer

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp).first);
      expect(materialApp.title, 'Aventura da História');
    });
  });
}

class MockProgressProvider extends ProgressProvider {
  @override
  Future<void> loadProgress() async {
    // No-op
  }
}

class MockCharacterProvider extends CharacterProvider {
  @override
  Future<void> loadCharacters() async {
    // No-op
  }
}
