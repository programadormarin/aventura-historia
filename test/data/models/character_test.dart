import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:aventura_historia/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Character', () {
    const testCharacter = Character(
      id: 'char_test',
      name: 'Lusitano',
      era: HistoricalEra.preRoman,
      description: 'A brave warrior',
      imagePath: 'assets/images/characters/lusitano.png',
      accentColor: Color(0xFF8D6E63),
      personalityTraits: ['Brave', 'Loyal', 'Protector'],
      isUnlocked: true,
    );

    const lockedCharacter = Character(
      id: 'char_locked',
      name: 'Viriato',
      era: HistoricalEra.roman,
      description: 'A legendary leader',
      imagePath: 'assets/images/characters/viriato.png',
      accentColor: Color(0xFFD32F2F),
      personalityTraits: ['Strategist', 'Brave'],
      isUnlocked: false,
    );

    group('constructor', () {
      test('default isUnlocked is false', () {
        const char = Character(
          id: 'char1',
          name: 'Test',
          era: HistoricalEra.preRoman,
          description: 'Test',
          imagePath: 'path.png',
          accentColor: Colors.red,
          personalityTraits: ['trait'],
        );
        expect(char.isUnlocked, isFalse);
      });

      test('sets all fields correctly', () {
        expect(testCharacter.id, 'char_test');
        expect(testCharacter.name, 'Lusitano');
        expect(testCharacter.era, HistoricalEra.preRoman);
        expect(testCharacter.description, 'A brave warrior');
        expect(
            testCharacter.imagePath, 'assets/images/characters/lusitano.png');
        expect(testCharacter.accentColor, const Color(0xFF8D6E63));
        expect(
            testCharacter.personalityTraits, ['Brave', 'Loyal', 'Protector']);
        expect(testCharacter.isUnlocked, isTrue);
      });
    });

    group('copyWith', () {
      test('returns same object when no parameters', () {
        final copied = testCharacter.copyWith();
        expect(copied.id, testCharacter.id);
        expect(copied.name, testCharacter.name);
        expect(copied.isUnlocked, testCharacter.isUnlocked);
      });

      test('updates isUnlocked field', () {
        final unlocked = lockedCharacter.copyWith(isUnlocked: true);
        expect(unlocked.isUnlocked, isTrue);
        expect(unlocked.id, lockedCharacter.id);
        expect(unlocked.name, lockedCharacter.name);
      });

      test('preserves immutability', () {
        final copied = testCharacter.copyWith(isUnlocked: false);
        expect(copied.isUnlocked, isFalse);
        expect(testCharacter.isUnlocked, isTrue);
      });
    });

    group('toMap and fromMap', () {
      test('should serialize and deserialize correctly', () {
        final map = testCharacter.toMap();
        expect(map['id'], 'char_test');
        expect(map['name'], 'Lusitano');
        expect(map['era'], 'preRoman');
        expect(map['description'], 'A brave warrior');
        expect(map['imagePath'], 'assets/images/characters/lusitano.png');
        expect(map['accentColor'], 0xFF8D6E63);
        expect(map['personalityTraits'], 'Brave,Loyal,Protector');
        expect(map['isUnlocked'], 1);

        final restored = Character.fromMap(map);
        expect(restored.id, 'char_test');
        expect(restored.name, 'Lusitano');
        expect(restored.era, HistoricalEra.preRoman);
        expect(restored.description, 'A brave warrior');
        expect(restored.imagePath, 'assets/images/characters/lusitano.png');
        expect(restored.accentColor, const Color(0xFF8D6E63));
        expect(restored.personalityTraits, ['Brave', 'Loyal', 'Protector']);
        expect(restored.isUnlocked, isTrue);
      });

      test('should handle locked character', () {
        final map = lockedCharacter.toMap();
        expect(map['isUnlocked'], 0);

        final restored = Character.fromMap(map);
        expect(restored.isUnlocked, isFalse);
      });

      test('should handle single trait', () {
        const singleTraitChar = Character(
          id: 'char_single',
          name: 'Single',
          era: HistoricalEra.islamic,
          description: 'Single trait',
          imagePath: 'path.png',
          accentColor: Colors.green,
          personalityTraits: ['Brave'],
        );

        final map = singleTraitChar.toMap();
        expect(map['personalityTraits'], 'Brave');

        final restored = Character.fromMap(map);
        expect(restored.personalityTraits, ['Brave']);
      });

      test('color value is stored as int', () {
        final map = testCharacter.toMap();
        expect(map['accentColor'], isA<int>());
        expect(map['accentColor'], const Color(0xFF8D6E63).value);
      });
    });

    group('toString', () {
      test('returns correct string representation', () {
        final str = testCharacter.toString();
        expect(str, contains('char_test'));
        expect(str, contains('Lusitano'));
        expect(str, contains('HistoricalEra.preRoman'));
        expect(str, contains('true'));
      });

      test('includes locked status', () {
        final str = lockedCharacter.toString();
        expect(str, contains('char_locked'));
        expect(str, contains('Viriato'));
        expect(str, contains('false'));
      });
    });
  });
}
