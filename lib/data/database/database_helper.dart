import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/character.dart';
import '../models/chapter_progress.dart';

/// SQLite database helper for managing game progress
class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  // Table names
  static const String tableChapterProgress = 'chapter_progress';
  static const String tableCharacters = 'characters';
  static const String tableQuizResults = 'quiz_results';

  // Get database instance
  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'aventura_historia.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create tables
  Future<void> _onCreate(Database db, int version) async {
    // Chapter progress table
    await db.execute('''
      CREATE TABLE $tableChapterProgress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        era TEXT NOT NULL UNIQUE,
        isUnlocked INTEGER NOT NULL DEFAULT 0,
        isCompleted INTEGER NOT NULL DEFAULT 0,
        bestScore INTEGER NOT NULL DEFAULT 0,
        totalQuestions INTEGER NOT NULL DEFAULT 0,
        lastPlayed TEXT,
        attemptsCount INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Characters table
    await db.execute('''
      CREATE TABLE $tableCharacters (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        era TEXT NOT NULL,
        description TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        accentColor INTEGER NOT NULL,
        personalityTraits TEXT NOT NULL,
        isUnlocked INTEGER NOT NULL DEFAULT 0
      )
    ''');

    // Quiz results table (for tracking individual quiz attempts)
    await db.execute('''
      CREATE TABLE $tableQuizResults (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        era TEXT NOT NULL,
        score INTEGER NOT NULL,
        totalQuestions INTEGER NOT NULL,
        completedAt TEXT NOT NULL,
        timeSpentSeconds INTEGER
      )
    ''');

    // Insert initial data
    await _insertInitialData(db);
  }

  // Insert initial chapter and character data
  Future<void> _insertInitialData(Database db) async {
    final batch = db.batch();

    // Insert chapter progress (first chapter unlocked by default)
    for (int i = 0; i < 10; i++) {
      batch.insert(tableChapterProgress, {
        'era': _eraNameFromIndex(i),
        'isUnlocked': i == 0 ? 1 : 0, // First chapter unlocked
        'isCompleted': 0,
        'bestScore': 0,
        'totalQuestions': 0,
        'attemptsCount': 0,
      });
    }

    // Insert sample characters
    batch.insert(tableCharacters, {
      'id': 'char_lusitano',
      'name': 'Lusitano',
      'era': 'preRoman',
      'description':
          'Um jovem guerreiro Lusitano corajoso que protege as terras ancestrais.',
      'imagePath': 'assets/images/characters/lusitano.png',
      'accentColor': 0xFF8D6E63,
      'personalityTraits': 'Corajoso,Leal,Protetor',
      'isUnlocked': 1,
    });

    batch.insert(tableCharacters, {
      'id': 'char_viriato',
      'name': 'Viriato',
      'era': 'roman',
      'description': 'O lendário líder que desafiou o Império Romano.',
      'imagePath': 'assets/images/characters/viriato.png',
      'accentColor': 0xFFD32F2F,
      'personalityTraits': 'Estrategista,Valente,Líder',
      'isUnlocked': 0,
    });

    await batch.commit();
  }

  String _eraNameFromIndex(int index) {
    const eras = [
      'preRoman',
      'roman',
      'suebiVisigoth',
      'islamic',
      'countyPortugal',
      'firstDynasty',
      'discoveries',
      'iberialUnion',
      'restoration',
      'modern',
    ];
    return eras[index];
  }

  // ========== Chapter Progress Methods ==========

  /// Get all chapter progress records
  Future<List<ChapterProgress>> getAllChapterProgress() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(tableChapterProgress);
    return List.generate(maps.length, (i) {
      return ChapterProgress.fromMap(maps[i]);
    });
  }

  /// Get chapter progress by era
  Future<ChapterProgress?> getChapterProgress(String era) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableChapterProgress,
      where: 'era = ?',
      whereArgs: [era],
    );
    if (maps.isNotEmpty) {
      return ChapterProgress.fromMap(maps.first);
    }
    return null;
  }

  /// Update chapter progress
  Future<void> updateChapterProgress(ChapterProgress progress) async {
    final db = await database;
    await db.update(
      tableChapterProgress,
      progress.toMap(),
      where: 'era = ?',
      whereArgs: [progress.era.name],
    );
  }

  /// Unlock next chapter
  Future<void> unlockNextChapter(String completedEra) async {
    final db = await database;
    final currentIndex = _eraNameFromIndexList.indexOf(completedEra);
    if (currentIndex >= 0 && currentIndex < 9) {
      final nextEra = _eraNameFromIndexList[currentIndex + 1];
      await db.update(
        tableChapterProgress,
        {'isUnlocked': 1},
        where: 'era = ?',
        whereArgs: [nextEra],
      );
    }
  }

  // ========== Character Methods ==========

  /// Get all characters
  Future<List<Character>> getAllCharacters() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableCharacters);
    return List.generate(maps.length, (i) {
      return Character.fromMap(maps[i]);
    });
  }

  /// Get character by ID
  Future<Character?> getCharacter(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableCharacters,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Character.fromMap(maps.first);
    }
    return null;
  }

  /// Unlock a character
  Future<void> unlockCharacter(String characterId) async {
    final db = await database;
    await db.update(
      tableCharacters,
      {'isUnlocked': 1},
      where: 'id = ?',
      whereArgs: [characterId],
    );
  }

  // ========== Quiz Results Methods ==========

  /// Save quiz result
  Future<int> insertQuizResult({
    required String era,
    required int score,
    required int totalQuestions,
    required DateTime completedAt,
    int? timeSpentSeconds,
  }) async {
    final db = await database;
    return await db.insert(tableQuizResults, {
      'era': era,
      'score': score,
      'totalQuestions': totalQuestions,
      'completedAt': completedAt.toIso8601String(),
      'timeSpentSeconds': timeSpentSeconds,
    });
  }

  /// Get quiz results for a chapter
  Future<List<Map<String, dynamic>>> getQuizResults(String era) async {
    final db = await database;
    return await db.query(
      tableQuizResults,
      where: 'era = ?',
      whereArgs: [era],
      orderBy: 'completedAt DESC',
    );
  }

  // Utility
  static const List<String> _eraNameFromIndexList = [
    'preRoman',
    'roman',
    'suebiVisigoth',
    'islamic',
    'countyPortugal',
    'firstDynasty',
    'discoveries',
    'iberialUnion',
    'restoration',
    'modern',
  ];

  /// Initialize database (called from main)
  Future<void> initialize() async {
    await database;
  }

  /// Close database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
