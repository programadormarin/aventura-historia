# Architecture

## Design Patterns
- **Layered Architecture:** Clear separation between data, logic, and UI.
- **Provider Pattern:** Used for dependency injection and state management.
- **Singleton Pattern:** Employed by the `DatabaseHelper` class.
- **Repository-like Pattern:** Providers handle orchestration between the database and the UI.
- **Component-based UI:** Reusable widgets for quiz questions and other repeated elements.

## Logical Layers
1. **Data Layer** (`lib/data/`):
   - **Models**: Defines game entities (`Character`, `ChapterProgress`, `QuizQuestion`).
   - **Database**: `DatabaseHelper` manages SQLite operations.
   - **Providers**: `ProgressProvider` and `CharacterProvider` manage runtime state and interact with the database.

2. **Game Logic Layer** (`lib/game/`):
   - **Services**: `QuizService` handles quiz logic and scoring.
   - **Components**: UI-specific game elements (`QuizQuestionWidget`).

3. **UI/Presentation Layer** (`lib/screens/`, `lib/widgets/`):
   - **Screens**: Complete pages (Splash, Home, Gallery, Quiz, Results, Progress).
   - **Widgets**: Reusable, atomic UI components.
   - **Core**: Theme (`AppTheme`) and constants (`AppStrings`).

## Data Flow
- User interaction → Provider triggers action → Provider updates database (via `DatabaseHelper`) → Provider notifies listeners → UI updates.
- Home screen shows overall progress.
- Quiz session updates chapter progress and unlocks next eras.
- Unlocking eras may unlock characters in the Gallery.
