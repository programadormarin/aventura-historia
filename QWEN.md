# Aventura da Historia - Project Context

## Project Overview

**Aventura da Historia** is an educational Flutter + Flame game that teaches Portuguese History to children aged 10–13. The app covers 10 historical chapters spanning from Pre-Roman peoples to Modern Portugal, using interactive quizzes, companion characters (anime-style), and a visual timeline.

- **Language**: Portuguese (Portugal, pt-PT)
- **Target Platform**: Android
- **Target Audience**: Children aged 10–13
- **Version**: 1.0.0+1

## Tech Stack

| Layer            | Technology                              |
| ---------------- | --------------------------------------- |
| UI Framework     | Flutter >= 3.16.0                       |
| Language         | Dart >= 3.2.0                           |
| Game Engine      | Flame ^1.16.0                           |
| Local Database   | SQLite (sqflite ^2.3.2)                 |
| State Management | Provider ^6.1.2                         |
| Design System    | Material 3                              |
| Localization     | flutter_localizations (pt-PT)           |
| Audio            | audioplayers ^5.2.1                     |
| Animations       | animated_text_kit ^4.2.2, lottie ^3.1.0 |

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── constants/
│   │   ├── app_strings.dart           # Portuguese (pt-PT) strings
│   │   └── historical_eras.dart       # 10 historical eras enum
│   └── theme/
│       └── app_theme.dart             # Light/dark themes
├── data/
│   ├── database/
│   │   └── database_helper.dart       # SQLite database layer
│   ├── models/
│   │   ├── character.dart             # Companion character model
│   │   ├── chapter_progress.dart      # Chapter progress model
│   │   └── quiz_question.dart         # Quiz question model
│   └── providers/
│       ├── progress_provider.dart     # Progress state management
│       └── character_provider.dart    # Character state management
├── game/
│   ├── components/
│   │   ├── quiz_question_widget.dart  # Flame quiz component
│   │   └── placeholder.dart           # Placeholder component
│   └── services/
│       └── quiz_service.dart          # Quiz question service
├── screens/
│   ├── splash_screen.dart             # App splash screen
│   ├── home_screen.dart               # Main dashboard
│   ├── chapter_selection_screen.dart  # Timeline chapter map
│   ├── quiz_screen.dart               # Quiz gameplay screen
│   ├── quiz_result_screen.dart        # Results screen
│   ├── character_gallery_screen.dart  # Character collection
│   └── progress_overview_screen.dart  # Progress statistics
└── widgets/                           # Reusable widgets (empty)
```

## Key Features

### 1. 10 Historical Chapters
Each chapter represents a distinct era of Portuguese history:
1. Pre-Roman Peoples (before 218 BC)
2. Roman Rule (218 BC – 468 AD)
3. Suebi and Visigoths (468–711)
4. Islamic Rule (711–1095)
5. County of Portugal (1095–1139)
6. First Dynasty (1139–1383)
7. Age of Discovery (1415–1580)
8. Iberian Union (1580–1640)
9. Restoration of Independence (1640–1820)
10. Modern Portugal (1820–present)

### 2. Quiz System
- Multiple-choice questions with 3 difficulty levels (Easy: 3 options, Medium: 4, Hard: 5)
- Points: 10 (Easy), 20 (Medium), 30 (Hard)
- Character hints during quizzes
- Immediate correct/incorrect feedback
- Questions currently hardcoded in `quiz_service.dart`

### 3. SQLite Persistence
Three tables:
- **chapter_progress**: era, unlocked, completed, bestScore, totalQuestions, attemptsCount
- **characters**: id, name, era, description, imagePath, accentColor, personalityTraits, isUnlocked
- **quiz_results**: era, score, totalQuestions, completedAt, timeSpentSeconds

Initial data:
- Chapter 1 (Pre-Roman) unlocked; chapters 2–10 locked
- 2 sample characters: Lusitano (unlocked), Viriato (locked)
- Sample questions for Pre-Roman, Roman, Islamic, First Dynasty, and Discoveries eras

### 4. Navigation
- Bottom navigation bar with 4 tabs
- Splash → Home → Chapter Selection → Quiz → Results flow
- Auto-unlock next chapter upon completion

## Building and Running

### Using Makefile (Recommended)

The project includes a comprehensive `Makefile` with all essential commands:

```bash
# Show all available commands
make help

# Initial setup
make setup

# Run app on connected device
make run

# Run tests (manually)
make test

# Run tests (with Docker, recommended)
make docker-setup
make docker-test

# Analyze code
make analyze

# Run all checks (format + analyze + test)
make check

# Pre-commit checks
make precommit

# Build release APK
make build-apk

# Build App Bundle for Play Store
make build-appbundle

# Quick commands (shortcuts)
make d      # Run in debug mode
make t      # Run tests
make a      # Analyze code
```

### Manual Commands

```bash
# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run

# Analyze code for errors and warnings
dart analyze

# Run tests
flutter test

# Build APK
flutter build apk

# Build App Bundle (for Play Store)
flutter build appbundle
```

### Full Makefile Command List

| Category | Command | Description |
|----------|---------|-------------|
| **Setup** | `make setup` | Install dependencies |
| | `make clean` | Clean build artifacts |
| | `make upgrade` | Upgrade Flutter and dependencies |
| **Run** | `make run` | Run on connected device |
| | `make run-debug` | Run in debug mode |
| | `make run-profile` | Run in profile mode |
| | `make run-release` | Run in release mode |
| **Testing** | `make test` | Run all tests |
| | `make test-coverage` | Run tests with coverage |
| | `make test-watch` | Run tests in watch mode |
| | `make test-single FILE=...` | Run single test file |
| **Analysis** | `make analyze` | Analyze code |
| | `make format` | Format Dart files |
| | `make fix` | Apply automated fixes |
| **Build** | `make build-apk` | Build APK |
| | `make build-apk-split` | Build split APKs per ABI |
| | `make build-appbundle` | Build for Play Store |
| | `make build-web` | Build for web |
| **Quality** | `make check` | Run analyze + tests |
| | `make precommit` | Format + analyze + test |
| | `make ci` | Full CI pipeline |

## Coding Conventions

Defined in `analysis_options.yaml`:
- Use `const` constructors and declarations where possible
- Prefer single quotes over double quotes
- Sort child properties last in widget constructors
- Use `key` in widget constructors
- `avoid_print` is disabled during development (allow `print` for debugging)

### Style Patterns Observed
- Enums with extensions for domain data (HistoricalEra)
- ChangeNotifier pattern for state management (Provider)
- Singleton pattern for DatabaseHelper
- Model classes with `fromMap`/`toMap` for serialization
- Async/await throughout

## Current Status

- **Architecture**: Fully implemented (core, data, game, screens layers)
- **Database**: Fully implemented with 3 tables and initial data
- **Screens**: 7 screens implemented (splash, home, chapter selection, quiz, quiz result, character gallery, progress overview)
- **Quiz Content**: Sample questions for 5 of 10 eras; remaining eras have placeholder questions
- **Assets**: Directory structure created; actual image/audio assets not yet added
- **Tests**: ✅ 239 automated tests implemented (Unit/Widget/Integration)
- **Warnings**: ~15 non-critical warnings (style suggestions, unused imports)
- **Compatibility**: Verified with Flutter 3.19.4 via Docker environment

## Known Gaps / TODOs

1. **Content**: Add quiz questions for remaining 5 eras (Suebi/Visigoths, County of Portugal, Iberian Union, Restoration, Modern)
2. **Assets**: Add character images, backgrounds, icons, music, and sound effects
3. **Flame Effects**: Add particle effects, shake animations, score animations in quiz components
4. **Audio**: Implement background music and sound effects
5. **Testing**: ✅ 239 unit/widget tests implemented and passing
6. **Lint Cleanup**: Fix remaining ~15 warnings (unused imports, missing const)
7. **Features**: Study mode vs test mode, achievements/rewards, progress sharing
