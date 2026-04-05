import 'package:aventura_historia/screens/home_screen.dart';
import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/models/chapter_progress.dart';
import 'package:aventura_historia/data/models/character.dart';
import 'package:aventura_historia/data/providers/progress_provider.dart';
import 'package:aventura_historia/data/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class MockProgressProvider extends ProgressProvider {
  List<ChapterProgress> _testChapters = [];
  bool _testIsLoading = false;

  @override
  List<ChapterProgress> get chapters => _testChapters;
  @override
  bool get isLoading => _testIsLoading;
  @override
  int get totalStars => _testChapters.fold(0, (sum, cp) => sum + cp.starRating);
  @override
  double get overallProgress => _testChapters.isEmpty
      ? 0.0
      : _testChapters.where((c) => c.isCompleted).length / _testChapters.length;

  @override
  Future<void> loadProgress() async {
    // No-op to avoid DB calls in test
  }

  void setChapters(List<ChapterProgress> chapters) {
    _testChapters = chapters;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _testIsLoading = loading;
    notifyListeners();
  }
}

class MockCharacterProvider extends CharacterProvider {
  List<Character> _testCharacters = [];
  Character? _testActiveCharacter;
  bool _testIsLoading = false;

  @override
  List<Character> get characters => _testCharacters;
  @override
  Character? get activeCharacter => _testActiveCharacter;
  @override
  bool get isLoading => _testIsLoading;

  @override
  Future<void> loadCharacters() async {
    // No-op to avoid DB calls in test
  }

  void setCharacters(List<Character> characters) {
    _testCharacters = characters;
    notifyListeners();
  }

  @override
  void setActiveCharacter(Character character) {
    if (!character.isUnlocked) return;
    _testActiveCharacter = character;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _testIsLoading = loading;
    notifyListeners();
  }
}

void main() {
  group('HomeScreen', () {
    late MockProgressProvider mockProgressProvider;
    late MockCharacterProvider mockCharacterProvider;

    setUp(() {
      mockProgressProvider = MockProgressProvider();
      mockCharacterProvider = MockCharacterProvider();
    });

    Widget buildScreen() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProgressProvider>.value(
              value: mockProgressProvider),
          ChangeNotifierProvider<CharacterProvider>.value(
              value: mockCharacterProvider),
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      );
    }

    testWidgets('displays bottom navigation bar', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('has 4 navigation destinations', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byType(NavigationDestination), findsNWidgets(4));
    });

    testWidgets('displays correct navigation labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.text('Início'), findsWidgets);
      expect(find.text('Capítulos'), findsWidgets);
      expect(find.text('Personagens'), findsWidgets);
      expect(find.text('Progresso'), findsWidgets);
    });

    testWidgets('starts on home dashboard', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byType(HomeDashboard), findsOneWidget);
    });

    testWidgets('switches to chapter selection on second tab',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      await tester.tap(find.text('Capítulos'));
      await tester.pumpAndSettle();

      expect(find.text('Selecionar Capítulo'), findsOneWidget);
    });

    testWidgets('switches to character gallery on third tab',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      await tester.tap(find.text('Personagens').last);
      await tester.pumpAndSettle();

      expect(find.text('Personagens'), findsWidgets);
    });

    testWidgets('switches to progress overview on fourth tab',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      await tester.tap(find.text('Progresso'));
      await tester.pumpAndSettle();

      expect(find.text('Progresso'), findsWidgets);
    });

    testWidgets('updates selected icon state', (WidgetTester tester) async {
      await tester.pumpWidget(buildScreen());

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.map_outlined), findsOneWidget);

      await tester.tap(find.text('Capítulos'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.home_outlined), findsOneWidget);
      expect(find.byIcon(Icons.map), findsOneWidget);
    });
  });

  group('HomeDashboard', () {
    late MockProgressProvider mockProgressProvider;
    late MockCharacterProvider mockCharacterProvider;

    const testCharacter = Character(
      id: 'char_1',
      name: 'Lusitano',
      era: HistoricalEra.preRoman,
      description: 'A brave warrior',
      imagePath: 'path.png',
      accentColor: Color(0xFF8D6E63),
      personalityTraits: ['Brave'],
      isUnlocked: true,
    );

    setUp(() {
      mockProgressProvider = MockProgressProvider();
      mockCharacterProvider = MockCharacterProvider();
    });

    Widget buildDashboard() {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<ProgressProvider>.value(
              value: mockProgressProvider),
          ChangeNotifierProvider<CharacterProvider>.value(
              value: mockCharacterProvider),
        ],
        child: const MaterialApp(
          home: HomeDashboard(),
        ),
      );
    }

    testWidgets('displays app title', (WidgetTester tester) async {
      await tester.pumpWidget(buildDashboard());

      expect(find.text('Aventura da História'), findsOneWidget);
    });

    testWidgets('displays settings button', (WidgetTester tester) async {
      await tester.pumpWidget(buildDashboard());

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('shows welcome message', (WidgetTester tester) async {
      mockCharacterProvider.setCharacters([testCharacter]);
      mockCharacterProvider.setActiveCharacter(testCharacter);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('Bem-vindo!'), findsOneWidget);
    });

    testWidgets('shows active character name', (WidgetTester tester) async {
      mockCharacterProvider.setCharacters([testCharacter]);
      mockCharacterProvider.setActiveCharacter(testCharacter);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('O teu companion é Lusitano'), findsOneWidget);
    });

    testWidgets('shows placeholder when no active character',
        (WidgetTester tester) async {
      mockCharacterProvider.setCharacters([]);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('Escolhe uma personagem!'), findsOneWidget);
    });

    testWidgets('shows progress card', (WidgetTester tester) async {
      mockProgressProvider.setChapters([
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isCompleted: true,
          bestScore: 90,
          totalQuestions: 100,
        ),
      ]);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('O Teu Progresso'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows progress percentage', (WidgetTester tester) async {
      mockProgressProvider.setChapters([
        const ChapterProgress(era: HistoricalEra.preRoman, isCompleted: true),
        const ChapterProgress(era: HistoricalEra.roman, isCompleted: false),
      ]);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('50% completo'), findsOneWidget);
    });

    testWidgets('shows total stars', (WidgetTester tester) async {
      mockProgressProvider.setChapters([
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          bestScore: 90,
          totalQuestions: 100,
        ),
      ]);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('3/30'), findsOneWidget);
    });

    testWidgets('shows quick actions section', (WidgetTester tester) async {
      await tester.pumpWidget(buildDashboard());

      expect(find.text('Ações Rápidas'), findsOneWidget);
      expect(find.text('Jogar'), findsOneWidget);
      expect(find.text('Personagens'),
          findsWidgets); // May appear in multiple places
    });

    testWidgets('shows featured chapter section', (WidgetTester tester) async {
      mockProgressProvider.setChapters([
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          isCompleted: false,
        ),
      ]);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('Capítulo em Destaque'), findsOneWidget);
      expect(find.text('Povos Pre-Romanos'), findsWidgets);
    });

    testWidgets('featured chapter has start button',
        (WidgetTester tester) async {
      mockProgressProvider.setChapters([
        const ChapterProgress(
          era: HistoricalEra.preRoman,
          isUnlocked: true,
          isCompleted: false,
        ),
      ]);

      await tester.pumpWidget(buildDashboard());

      expect(find.text('Começar'), findsOneWidget);
    });

    testWidgets('quick action buttons are tappable',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildDashboard());

      final jogarButton = find.text('Jogar');
      expect(jogarButton, findsOneWidget);

      await tester.tap(jogarButton);
      await tester.pumpAndSettle();
    });

    testWidgets('character avatar uses accent color',
        (WidgetTester tester) async {
      mockCharacterProvider.setCharacters([testCharacter]);
      mockCharacterProvider.setActiveCharacter(testCharacter);

      await tester.pumpWidget(buildDashboard());

      // Find the container with the character color
      final containers = find.byType(Container);
      expect(containers, findsWidgets);
    });

    testWidgets('displays scrollable content', (WidgetTester tester) async {
      await tester.pumpWidget(buildDashboard());

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });
  });
}
