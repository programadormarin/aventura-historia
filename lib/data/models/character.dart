import 'package:flutter/material.dart';
import '../../core/constants/historical_eras.dart';

/// Companion character model
/// Each era has one anime-style companion character
@immutable
class Character {
  final String id;
  final String name;
  final HistoricalEra era;
  final String description;
  final String imagePath;
  final Color accentColor;
  final List<String> personalityTraits;
  final bool isUnlocked;

  const Character({
    required this.id,
    required this.name,
    required this.era,
    required this.description,
    required this.imagePath,
    required this.accentColor,
    required this.personalityTraits,
    this.isUnlocked = false,
  });

  Character copyWith({bool? isUnlocked}) {
    return Character(
      id: id,
      name: name,
      era: era,
      description: description,
      imagePath: imagePath,
      accentColor: accentColor,
      personalityTraits: personalityTraits,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'era': era.name,
      'description': description,
      'imagePath': imagePath,
      'accentColor': accentColor.value,
      'personalityTraits': personalityTraits.join(','),
      'isUnlocked': isUnlocked ? 1 : 0,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id'] as String,
      name: map['name'] as String,
      era: HistoricalEra.values.byName(map['era'] as String),
      description: map['description'] as String,
      imagePath: map['imagePath'] as String,
      accentColor: Color(map['accentColor'] as int),
      personalityTraits: (map['personalityTraits'] as String).split(','),
      isUnlocked: (map['isUnlocked'] as int) == 1,
    );
  }

  @override
  String toString() {
    return 'Character(id: $id, name: $name, era: $era, isUnlocked: $isUnlocked)';
  }
}
