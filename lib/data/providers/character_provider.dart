import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';
import '../models/character.dart';
import '../../core/constants/historical_eras.dart';

/// Provider for managing companion characters
class CharacterProvider extends ChangeNotifier {
  List<Character> _characters = [];
  Character? _activeCharacter;
  bool _isLoading = false;
  String? _error;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  List<Character> get characters => List.unmodifiable(_characters);
  Character? get activeCharacter => _activeCharacter;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Load all characters from database
  Future<void> loadCharacters() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _characters = await DatabaseHelper.instance.getAllCharacters();
      _isLoading = false;

      // Set first unlocked character as active if none selected
      _activeCharacter ??= _characters.firstWhere(
        (c) => c.isUnlocked,
        orElse: () => _characters.first,
      );

      notifyListeners();
    } catch (e) {
      _error = 'Erro ao carregar personagens: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Get character for specific era
  Character? getCharacterForEra(HistoricalEra era) {
    try {
      return _characters.firstWhere((c) => c.era == era);
    } catch (e) {
      return null;
    }
  }

  /// Get unlocked characters
  List<Character> get unlockedCharacters {
    return _characters.where((c) => c.isUnlocked).toList();
  }

  /// Check if character is unlocked
  bool isCharacterUnlocked(String characterId) {
    try {
      final character = _characters.firstWhere((c) => c.id == characterId);
      return character.isUnlocked;
    } catch (e) {
      return false;
    }
  }

  /// Unlock a character
  Future<void> unlockCharacter(String characterId) async {
    await DatabaseHelper.instance.unlockCharacter(characterId);

    final index = _characters.indexWhere((c) => c.id == characterId);
    if (index != -1) {
      _characters[index] = _characters[index].copyWith(isUnlocked: true);
      notifyListeners();
    }
  }

  /// Set active character
  void setActiveCharacter(Character character) {
    if (!character.isUnlocked) return;
    _activeCharacter = character;
    notifyListeners();
  }

  /// Get character by ID
  Character? getCharacterById(String id) {
    try {
      return _characters.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}
