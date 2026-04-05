import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/models/character.dart';
import 'package:aventura_historia/data/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharacterProvider', () {
    late CharacterProvider characterProvider;

    setUp(() {
      characterProvider = CharacterProvider();
    });

    tearDown(() {
      characterProvider.dispose();
    });

    group('initial state', () {
      test('starts with empty characters', () {
        expect(characterProvider.characters.isEmpty, isTrue);
      });

      test('starts with null active character', () {
        expect(characterProvider.activeCharacter, isNull);
      });

      test('starts with isLoading false', () {
        expect(characterProvider.isLoading, isFalse);
      });

      test('starts with null error', () {
        expect(characterProvider.error, isNull);
      });
    });

    group('setActiveCharacter', () {
      const testCharacter = Character(
        id: 'char_test',
        name: 'Test',
        era: HistoricalEra.preRoman,
        description: 'Test character',
        imagePath: 'path.png',
        accentColor: Color(0xFF8D6E63),
        personalityTraits: ['Brave'],
        isUnlocked: true,
      );

      const lockedCharacter = Character(
        id: 'char_locked',
        name: 'Locked',
        era: HistoricalEra.roman,
        description: 'Locked character',
        imagePath: 'path.png',
        accentColor: Color(0xFFD32F2F),
        personalityTraits: ['Strong'],
        isUnlocked: false,
      );

      test('sets active character when unlocked', () {
        characterProvider.setActiveCharacter(testCharacter);
        expect(characterProvider.activeCharacter, testCharacter);
      });

      test('does not set locked character as active', () {
        characterProvider.setActiveCharacter(lockedCharacter);
        expect(characterProvider.activeCharacter, isNull);
      });

      test('notifies listeners when setting active character', () {
        var notified = false;
        characterProvider.addListener(() {
          notified = true;
        });

        characterProvider.setActiveCharacter(testCharacter);

        expect(notified, isTrue);
      });
    });

    group('getCharacterForEra', () {
      test('returns null when no characters loaded', () {
        final character =
            characterProvider.getCharacterForEra(HistoricalEra.preRoman);
        expect(character, isNull);
      });
    });

    group('unlockedCharacters', () {
      test('returns empty list when no characters', () {
        expect(characterProvider.unlockedCharacters.isEmpty, isTrue);
      });
    });

    group('isCharacterUnlocked', () {
      test('returns false when no characters loaded', () {
        expect(characterProvider.isCharacterUnlocked('char_test'), isFalse);
      });
    });

    group('getCharacterById', () {
      test('returns null when no characters loaded', () {
        expect(characterProvider.getCharacterById('char_test'), isNull);
      });
    });
  });
}
