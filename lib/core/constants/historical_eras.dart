/// Historical eras/periods of Portugal
/// Each era corresponds to a chapter in the game
enum HistoricalEra {
  preRoman, // Pre-Romano (antes de 218 a.C.)
  roman, // Dominio Romano (218 a.C. - 468 d.C.)
  suebiVisigoth, // Suevos e Visigodos (468 - 711)
  islamic, // Dominio Islamico (711 - 1095)
  countyPortugal, // Condado Portucalense (1095 - 1139)
  firstDynasty, // Primeira Dinastia (1139 - 1383)
  discoveries, // Descobrimentos (1415 - 1580)
  iberialUnion, // Uniao Iberica (1580 - 1640)
  restoration, // Restauracao (1640 - 1820)
  modern, // Portugal Moderno (1820 - atualidade)
}

/// Extension to add useful methods to HistoricalEra
extension HistoricalEraExtension on HistoricalEra {
  /// Display name in Portuguese
  String get displayName {
    switch (this) {
      case HistoricalEra.preRoman:
        return 'Povos Pre-Romanos';
      case HistoricalEra.roman:
        return 'Dominio Romano';
      case HistoricalEra.suebiVisigoth:
        return 'Suevos e Visigodos';
      case HistoricalEra.islamic:
        return 'Dominio Islamico';
      case HistoricalEra.countyPortugal:
        return 'Condado Portucalense';
      case HistoricalEra.firstDynasty:
        return 'Primeira Dinastia';
      case HistoricalEra.discoveries:
        return 'Era dos Descobrimentos';
      case HistoricalEra.iberialUnion:
        return 'Uniao Iberica';
      case HistoricalEra.restoration:
        return 'Restauracao da Independencia';
      case HistoricalEra.modern:
        return 'Portugal Moderno';
    }
  }

  /// Time period description
  String get timePeriod {
    switch (this) {
      case HistoricalEra.preRoman:
        return 'antes de 218 a.C.';
      case HistoricalEra.roman:
        return '218 a.C. - 468 d.C.';
      case HistoricalEra.suebiVisigoth:
        return '468 - 711';
      case HistoricalEra.islamic:
        return '711 - 1095';
      case HistoricalEra.countyPortugal:
        return '1095 - 1139';
      case HistoricalEra.firstDynasty:
        return '1139 - 1383';
      case HistoricalEra.discoveries:
        return '1415 - 1580';
      case HistoricalEra.iberialUnion:
        return '1580 - 1640';
      case HistoricalEra.restoration:
        return '1640 - 1820';
      case HistoricalEra.modern:
        return '1820 - atualidade';
    }
  }

  /// Chapter number (1-indexed)
  int get chapterNumber => HistoricalEra.values.indexOf(this) + 1;

  /// Color associated with each era for UI theming
  Map<String, int> get eraColors {
    final Map<HistoricalEra, Map<String, int>> colors = {
      HistoricalEra.preRoman: {'primary': 0xFF8D6E63, 'secondary': 0xFF5D4037},
      HistoricalEra.roman: {'primary': 0xFFD32F2F, 'secondary': 0xFFB71C1C},
      HistoricalEra.suebiVisigoth: {
        'primary': 0xFFFF8F00,
        'secondary': 0xFFFF6F00
      },
      HistoricalEra.islamic: {'primary': 0xFF388E3C, 'secondary': 0xFF1B5E20},
      HistoricalEra.countyPortugal: {
        'primary': 0xFF1976D2,
        'secondary': 0xFF0D47A1
      },
      HistoricalEra.firstDynasty: {
        'primary': 0xFF7B1FA2,
        'secondary': 0xFF4A148C
      },
      HistoricalEra.discoveries: {
        'primary': 0xFF0097A7,
        'secondary': 0xFF006064
      },
      HistoricalEra.iberialUnion: {
        'primary': 0xFFF57C00,
        'secondary': 0xFFE65100
      },
      HistoricalEra.restoration: {
        'primary': 0xFFC62828,
        'secondary': 0xFF8E0000
      },
      HistoricalEra.modern: {'primary': 0xFF1565C0, 'secondary': 0xFF0D47A1},
    };
    return colors[this] ?? {'primary': 0xFF000000, 'secondary': 0xFF424242};
  }
}
