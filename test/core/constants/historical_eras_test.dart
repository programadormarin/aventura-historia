import 'package:aventura_historia/core/constants/historical_eras.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HistoricalEra', () {
    test('has 10 values', () {
      expect(HistoricalEra.values.length, 10);
    });

    group('displayName', () {
      test('preRoman', () {
        expect(HistoricalEra.preRoman.displayName, 'Povos Pre-Romanos');
      });

      test('roman', () {
        expect(HistoricalEra.roman.displayName, 'Dominio Romano');
      });

      test('suebiVisigoth', () {
        expect(HistoricalEra.suebiVisigoth.displayName, 'Suevos e Visigodos');
      });

      test('islamic', () {
        expect(HistoricalEra.islamic.displayName, 'Dominio Islamico');
      });

      test('countyPortugal', () {
        expect(
            HistoricalEra.countyPortugal.displayName, 'Condado Portucalense');
      });

      test('firstDynasty', () {
        expect(HistoricalEra.firstDynasty.displayName, 'Primeira Dinastia');
      });

      test('discoveries', () {
        expect(HistoricalEra.discoveries.displayName, 'Era dos Descobrimentos');
      });

      test('iberialUnion', () {
        expect(HistoricalEra.iberialUnion.displayName, 'Uniao Iberica');
      });

      test('restoration', () {
        expect(HistoricalEra.restoration.displayName,
            'Restauracao da Independencia');
      });

      test('modern', () {
        expect(HistoricalEra.modern.displayName, 'Portugal Moderno');
      });
    });

    group('timePeriod', () {
      test('preRoman', () {
        expect(HistoricalEra.preRoman.timePeriod, 'antes de 218 a.C.');
      });

      test('roman', () {
        expect(HistoricalEra.roman.timePeriod, '218 a.C. - 468 d.C.');
      });

      test('suebiVisigoth', () {
        expect(HistoricalEra.suebiVisigoth.timePeriod, '468 - 711');
      });

      test('islamic', () {
        expect(HistoricalEra.islamic.timePeriod, '711 - 1095');
      });

      test('countyPortugal', () {
        expect(HistoricalEra.countyPortugal.timePeriod, '1095 - 1139');
      });

      test('firstDynasty', () {
        expect(HistoricalEra.firstDynasty.timePeriod, '1139 - 1383');
      });

      test('discoveries', () {
        expect(HistoricalEra.discoveries.timePeriod, '1415 - 1580');
      });

      test('iberialUnion', () {
        expect(HistoricalEra.iberialUnion.timePeriod, '1580 - 1640');
      });

      test('restoration', () {
        expect(HistoricalEra.restoration.timePeriod, '1640 - 1820');
      });

      test('modern', () {
        expect(HistoricalEra.modern.timePeriod, '1820 - atualidade');
      });
    });

    group('chapterNumber', () {
      test('preRoman is chapter 1', () {
        expect(HistoricalEra.preRoman.chapterNumber, 1);
      });

      test('roman is chapter 2', () {
        expect(HistoricalEra.roman.chapterNumber, 2);
      });

      test('suebiVisigoth is chapter 3', () {
        expect(HistoricalEra.suebiVisigoth.chapterNumber, 3);
      });

      test('islamic is chapter 4', () {
        expect(HistoricalEra.islamic.chapterNumber, 4);
      });

      test('countyPortugal is chapter 5', () {
        expect(HistoricalEra.countyPortugal.chapterNumber, 5);
      });

      test('firstDynasty is chapter 6', () {
        expect(HistoricalEra.firstDynasty.chapterNumber, 6);
      });

      test('discoveries is chapter 7', () {
        expect(HistoricalEra.discoveries.chapterNumber, 7);
      });

      test('iberialUnion is chapter 8', () {
        expect(HistoricalEra.iberialUnion.chapterNumber, 8);
      });

      test('restoration is chapter 9', () {
        expect(HistoricalEra.restoration.chapterNumber, 9);
      });

      test('modern is chapter 10', () {
        expect(HistoricalEra.modern.chapterNumber, 10);
      });
    });

    group('eraColors', () {
      test('all eras have primary and secondary colors', () {
        for (final era in HistoricalEra.values) {
          final colors = era.eraColors;
          expect(colors.containsKey('primary'), isTrue);
          expect(colors.containsKey('secondary'), isTrue);
          expect(colors['primary'], isA<int>());
          expect(colors['secondary'], isA<int>());
        }
      });

      test('preRoman has brown color', () {
        final colors = HistoricalEra.preRoman.eraColors;
        expect(colors['primary'], 0xFF8D6E63);
        expect(colors['secondary'], 0xFF5D4037);
      });

      test('roman has red color', () {
        final colors = HistoricalEra.roman.eraColors;
        expect(colors['primary'], 0xFFD32F2F);
        expect(colors['secondary'], 0xFFB71C1C);
      });

      test('discoveries has teal color', () {
        final colors = HistoricalEra.discoveries.eraColors;
        expect(colors['primary'], 0xFF0097A7);
        expect(colors['secondary'], 0xFF006064);
      });
    });
  });
}
