# Aventura da História - Quick Start Guide

## 🚀 Running the App

```bash
# Make sure you're in the project directory
cd /Users/marin/workspace/aventura-historia

# Get dependencies (already done)
flutter pub get

# Run on connected Android device or emulator
flutter run
```

## 📁 Project Structure Overview

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

## 🎮 Key Features Implemented

### 1. **Main Navigation** (home_screen.dart)
- Bottom navigation bar with 4 tabs
- Home dashboard with progress overview
- Quick actions and featured chapter

### 2. **Chapter Selection** (chapter_selection_screen.dart)
- Timeline visualization with 10 historical eras
- Color-coded chapters
- Lock/unlock system
- Star ratings and progress bars

### 3. **Quiz System** (quiz_screen.dart + quiz_service.dart)
- Multiple-choice questions
- Mixed difficulty (Easy: 3 options, Medium: 4, Hard: 5)
- Points system (10/20/30 based on difficulty)
- Character hints during quizzes
- Immediate feedback (correct/incorrect)

### 4. **SQLite Persistence** (database_helper.dart)
- Chapter progress tracking
- Character unlock states
- Quiz result history
- Auto-unlock next chapter on completion

### 5. **Character System** (character_gallery_screen.dart)
- 10 anime-style companions (one per era)
- Character detail view with personality traits
- Active character selection
- Unlock through quiz performance

### 6. **Portuguese Localization**
- All strings in pt-PT
- Proper date formatting
- Cultural adaptations

## 📝 Sample Data

The database initializes with:
- **10 chapters** (first one unlocked)
- **2 sample characters**: Lusitano (unlocked) and Viriato (locked)
- **Sample questions** for Pre-Roman, Roman, Islamic, First Dynasty, and Discoveries eras

## 🔧 Next Steps

### Add More Questions
Edit `lib/game/services/quiz_service.dart` and add questions for remaining eras:
- Suevos e Visigodos
- Condado Portucalense  
- União Ibérica
- Restauração
- Portugal Moderno

### Add Character Images
1. Place anime character images in `assets/images/characters/`
2. Update the `imagePath` in database initial data
3. Replace placeholder icons with actual images

### Add Flame Game Effects
Enhance `lib/game/components/quiz_question_widget.dart`:
- Particle effects for correct answers
- Shake animations for wrong answers
- Score animations
- Character animations

### Audio
1. Add background music to `assets/audio/music/`
2. Add sound effects to `assets/audio/sfx/`
3. Implement audio playback using audioplayers package

## ⚙️ Environment Notes

The project is optimized for **Flutter 3.19.4**. 
- Deprecated `withOpacity` is preferred over `withValues()` as the latter is unavailable in this SDK version.
- Compatibility layer implemented in `main.dart` for test-time dependency injection.
- 239 automated tests are implemented and passing in both local and Docker environments.

## ✅ Verification

```bash
# Analyze code
dart analyze

# Run tests (with Docker, recommended)
make docker-setup
make docker-test

# Run tests (manually)
flutter test

# Build APK
flutter build apk

# Build App Bundle (for Play Store)
flutter build appbundle
```

## 📚 Technologies Used

- **Flutter 3.16+**: UI framework
- **Flame 1.36**: Game engine
- **SQLite (sqflite 2.4)**: Local database
- **Provider 6.1**: State management
- **Material 3**: Design system
- **Portuguese (pt-PT)**: App language

## 🎯 Target Audience

- **Age**: 10-13 years old
- **Language**: Portuguese (Portugal)
- **Subject**: History of Portugal
- **Platform**: Android

Enjoy building! 🇵🇹✨
