import 'package:aventura_historia/screens/character_gallery_screen.dart';
import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/models/character.dart';
import 'package:aventura_historia/data/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class TestCharacterProvider extends CharacterProvider {
  List<Character> testCharacters = [];
  Character? testActiveCharacter;
  bool testIsLoading = false;

  @override
  List<Character> get characters => testCharacters;
  @override
  Character? get activeCharacter => testActiveCharacter;
  @override
  bool get isLoading => testIsLoading;

  @override
  void setActiveCharacter(Character character) {
    if (!character.isUnlocked) return;
    testActiveCharacter = character;
    notifyListeners();
  }
}

void main() {
  group('CharacterGalleryScreen', () {
    late TestCharacterProvider mockProvider;

    const unlockedChar = Character(
      id: 'char_1',
      name: 'Lusitano',
      era: HistoricalEra.preRoman,
      description: 'A brave warrior',
      imagePath: 'path.png',
      accentColor: Color(0xFF8D6E63),
      personalityTraits: ['Brave', 'Loyal'],
      isUnlocked: true,
    );

    const lockedChar = Character(
      id: 'char_2',
      name: 'Viriato',
      era: HistoricalEra.roman,
      description: 'A legendary leader',
      imagePath: 'path.png',
      accentColor: Color(0xFFD32F2F),
      personalityTraits: ['Strategist'],
      isUnlocked: false,
    );

    setUp(() {
      mockProvider = TestCharacterProvider();
    });

    Widget buildScreen() {
      return ChangeNotifierProvider<CharacterProvider>.value(
        value: mockProvider,
        child: const MaterialApp(
          home: CharacterGalleryScreen(),
        ),
      );
    }

    testWidgets('displays loading indicator when loading',
        (WidgetTester tester) async {
      mockProvider.testIsLoading = true;

      await tester.pumpWidget(buildScreen());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays character grid when loaded',
        (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar, lockedChar];

      await tester.pumpWidget(buildScreen());

      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('displays character names', (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar, lockedChar];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Lusitano'), findsOneWidget);
      expect(find.text('Viriato'), findsOneWidget);
    });

    testWidgets('displays era names for characters',
        (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Povos Pre-Romanos'), findsOneWidget);
    });

    testWidgets('shows lock icon for locked characters',
        (WidgetTester tester) async {
      mockProvider.testCharacters = [lockedChar];

      await tester.pumpWidget(buildScreen());

      expect(find.byIcon(Icons.lock), findsOneWidget);
    });

    testWidgets('shows person icon for unlocked characters',
        (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar];

      await tester.pumpWidget(buildScreen());

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.lock), findsNothing);
    });

    testWidgets('shows active indicator for active character',
        (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar];
      mockProvider.testActiveCharacter = unlockedChar;

      await tester.pumpWidget(buildScreen());

      expect(find.text('Ativo'), findsOneWidget);
    });

    testWidgets('does not show active indicator for inactive character',
        (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar, lockedChar];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Ativo'), findsNothing);
    });

    testWidgets('displays app bar with title', (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar];

      await tester.pumpWidget(buildScreen());

      expect(find.text('Personagens'), findsOneWidget);
    });

    testWidgets('uses grid layout with 2 columns', (WidgetTester tester) async {
      mockProvider.testCharacters = [unlockedChar, lockedChar];

      await tester.pumpWidget(buildScreen());

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
    });
  });
}
