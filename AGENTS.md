# Aventura da História - AI Agent Documentation

## Table of Contents
1. [Project Overview](#project-overview)
2. [Technical Stack](#technical-stack)
3. [Architecture and Structure](#architecture-and-structure)
   - [Directory Layout](#directory-layout)
   - [Layered Architecture Flow](#layered-architecture-flow)
   - [Design Patterns](#design-patterns)
4. [Domain Model (Core Data Structures)](#domain-model-core-data-structures)
   - [Historical Eras](#historical-eras)
   - [Chapter Progress](#chapter-progress)
   - [Characters (Companions)](#characters-companions)
   - [Quiz Questions](#quiz-questions)
5. [Database and Persistence](#database-and-persistence)
6. [State Management](#state-management)
7. [Testing Strategy](#testing-strategy)
8. [Workflow and Commands](#workflow-and-commands)
9. [Conventions and Guidelines](#conventions-and-guidelines)
10. [Known Issues and Next Steps](#known-issues-and-next-steps)

---

## Project Overview
**Aventura da História** is an educational Flutter game aimed at children aged 10-13, designed to teach the history of Portugal. The application guides players through 10 distinct historical eras (chapters), from Pre-Roman times to Modern Portugal. 

Key features include:
- A progressive timeline of 10 historical eras.
- Interactive multi-difficulty quizzes.
- Unlockable anime-style companion characters unique to each era.
- Persistent local game progress and score tracking.

**Language:** Portuguese (Portugal, `pt-PT`).
**Target Platform:** Primarily Android (configurable for iOS/Web).
**Target Flutter Version:** `3.19.4` (or `3.16.0+` compatible).

## Technical Stack
- **Framework:** Flutter SDK `^3.16.0` (Tests hardened for `3.19.4`)
- **Language:** Dart `^3.2.0`
- **Game Engine:** Flame `^1.16.0`
- **Local Database:** SQLite via `sqflite` (`^2.3.2`)
- **State Management:** Provider (`^6.1.2`)
- **UI Design:** Material 3
- **Animations/Typography:** `lottie` (`^3.1.0`), Google Fonts (Outfit expected through assets/theme), `animated_text_kit` (`^4.2.2`)
- **Audio:** `audioplayers` (`^5.2.1`)
- **Testing:** `flutter_test`, `mocktail`, `sqflite_common_ffi`

---

## Architecture and Structure

### Directory Layout
The application is structured to clearly separate concerns: data management, core utilities, game logic, and UI screens.

```text
lib/
├── core/
│   ├── constants/             # Enums, static strings (AppStrings, HistoricalEra)
│   └── theme/                 # AppTheme, text styles, colors
├── data/
│   ├── database/              # SQLite helper (DatabaseHelper)
│   ├── models/                # Logic-free data classes (Character, ChapterProgress, QuizQuestion)
│   └── providers/             # State holders serving models to UI (ProgressProvider, CharacterProvider)
├── game/
│   ├── components/            # Flame engine game components (QuizQuestionWidget)
│   └── services/              # Pure game logic (QuizService)
├── screens/                   # Page-level UI (HomeScreen, QuizScreen, CharacterGalleryScreen, etc.)
└── widgets/                   # Reusable UI elements
test/
├── ... (mirrors lib/ structure for unit and widget tests)
```

### Layered Architecture Flow
1. **Data Layer (`models/` + `database/`):** Defines what things are and how they are stored locally via SQLite (`DatabaseHelper`).
2. **Logic & State Layer (`providers/` + `services/`):** 
   - `QuizService` fetches/generates quiz content.
   - `ProgressProvider` and `CharacterProvider` fetch data from `DatabaseHelper` and expose it to the UI, handling business logic like "calculate total score" or "unlock next chapter".
3. **UI Layer (`screens/` + `widgets/` + `game/components/`):** Listens to Providers via `Consumer` or `context.watch()` to update the UI reactively. Flame is used in specific components for visual flair within standard Flutter widgets.

### Design Patterns
- **Provider/ChangeNotifier:** Standard dependency injection and reactive state mapping.
- **Singleton:** `DatabaseHelper` uses a private constructor (`DatabaseHelper.instance`).
- **Extensions:** Heavy use of Dart extensions (e.g., `HistoricalEraExtension`, `DifficultyLevelExtension`) to attach business logic, localized strings, and colors directly to enums.

---

## Domain Model (Core Data Structures)

### Historical Eras
Central enum `HistoricalEra` defined in `lib/core/constants/historical_eras.dart`.
Follows 10 chapters:
1. `preRoman` (Povos Pré-Romanos)
2. `roman` (Domínio Romano)
3. `suebiVisigoth` (Suevos e Visigodos)
4. `islamic` (Domínio Islâmico)
5. `countyPortugal` (Condado Portucalense)
6. `firstDynasty` (Primeira Dinastia)
7. `discoveries` (Era dos Descobrimentos)
8. `iberialUnion` (União Ibérica)
9. `restoration` (Restauração da Independência)
10. `modern` (Portugal Moderno)

Each era has associated colors (`eraColors`), display names, and dates built directly into the extension.

### Chapter Progress
`ChapterProgress` tracks a user's journey through an era:
- `isUnlocked`: Bool determining if the chapter map is accessible (Chapter 1 unlocked by default).
- `isCompleted`: Bool determining if the user has passed the chapter quiz (>= 50% score).
- `bestScore`: Int tracking the max score achieved in that era.
- `attemptsCount`: Tracks replayability.
- Calculation: Emits a `starRating` (0 to 3) based on percentage.

### Characters (Companions)
`Character` represents the anime-style companions:
- Mapped 1:1 with an era.
- Contains personality traits and an accent color.
- Tracks unlocking state (`isUnlocked`).

### Quiz Questions
`QuizQuestion` and `DifficultyLevel`:
- Difficulties: Easy (3 options), Medium (4 options), Hard (5 options).
- Points: Easy=10, Medium=20, Hard=30.
- Contains the `correctAnswerIndex` and historical `explanation` text shown upon answer.

---

## Database and Persistence
Powered by `sqflite` through `DatabaseHelper`.
- **Database File:** `aventura_historia.db` (Version 1).
- **Tables:**
  1. `chapter_progress`: Progression states per era.
  2. `characters`: Character unlock states and metadata.
  3. `quiz_results`: Granular logging of past quiz attempts.
- **Initial State Setup:** Pre-populates all 10 eras (locking eras 2-10) and loads sample characters directly via SQL batches upon the first app execution.

---

## State Management
Managed using `MultiProvider` at the top of the tree (`main.dart`). Use `ChangeNotifierProvider.value` when injecting mock providers during tests.
1. **`ProgressProvider`**: Holds `List<ChapterProgress>`. Responsible for saving quiz scores, evaluating if a chapter was completed, and triggering the unlock of the *next* chronological chapter.
2. **`CharacterProvider`**: Holds `List<Character>`. Manages the currently "active" character seen on the dashboard and handles unlocking new companions.

*Crucial Implementation Detail:* Both providers implement `bool _disposed = false` and guard `notifyListeners()` (e.g., `if (!_disposed) super.notifyListeners();`). This prevents asynchronous timers from firing after the provider has been destroyed, which was a critical fix for Flutter widget tests.

---

## Testing Strategy
The project has **100% functional test coverage** with roughly 239 passing automated tests.

1. **Unit Tests:** Found in `test/data`, `test/core`. Tests exact data serialization (e.g., `toMap()`/`fromMap()`) and logic extensions (e.g., star calculations).
2. **Widget Tests:** Extensively tests navigation, state updates, and rendering.
   - Located primarily in `test/screens`.
   - Uses `mocktail` to inject mock instances of `ProgressProvider` and `CharacterProvider`.
   - By creating mocked states, widget tests run smoothly without requiring SQLite filesystem access.
3. **Timer / Async Handling:** Widget tests extensively use `tester.pumpAndSettle()` and `tester.pump(const Duration(seconds: 2))` to clear Flame game engine timers and splash screen asynchronous delays.

**Running tests reliably:**
Due to slight API changes across SDKs and SQLite C-bindings restrictions on local machines, it is recommended to run tests inside Docker.
```bash
make docker-setup
make docker-test
```

---

## Workflow and Commands
The codebase utilizes a `Makefile` exclusively to streamline development tasks.

| Command | Action |
| --- | --- |
| `make setup` | Runs `flutter pub get` |
| `make run` / `make d` | Runs the app normally / in debug mode |
| `make test` / `make t` | Runs the local test suite |
| `make docker-setup` | Builds the Docker environment with Flutter 3.19.4 |
| `make docker-test` | Runs tests safely isolated inside Docker |
| `make check` | Runs analyzer + tests |
| `make format` | Formats all dart code |

---

## Conventions and Guidelines
- **Null Safety/Typing:** Strict typing is enforced. Classes heavily use `factory MyClass.fromMap(Map map)` to validate SQLite inputs.
- **Async/Await:** Broad use of asynchronous futures. Treat database and service transactions as if they take variable time.
- **UI Architecture:** Favor `StatelessWidget` when reading from `Provider`, rather than keeping logic in `StatefulWidget`. Use `Consumer<T>` to scope widget rebuilds.
- **Styles:** Reference colors only via `AppTheme` or `HistoricalEraExtension.eraColors`. Strings must route through `AppStrings` to support future `.arb` translation files.
- **Do not use deprecated properties:** In Flutter 3.19.4, `Color.toARGB32` is preferred (or handled safely). Avoid `withOpacity()` if `withAlpha()` or standard `Color(0x...)` logic applies across specific Flutter versions.

---

## Known Issues and Next Steps
1. **Content Expansion:** `QuizService` only contains hardcoded questions for eras 1-5. Eras 6-10 return empty lists or placeholders.
2. **Asset Integration:** Image paths like `assets/images/characters/lusitano.png` are referenced in DB initial data but the physical assets are yet to be populated.
3. **Flame Integration:** `QuizQuestionWidget` uses Flame minimally right now. Need to add particle effects (confetti) or shake animations (wrong answers).
4. **I18n:** Transition from `lib/core/constants/app_strings.dart` static constants to official `.arb` strings for better toolchain support.
5. **Database Extensibility:** Implement database migrations (`onUpgrade` in SQLite) if the schema for new features, like user study modes, changes.
