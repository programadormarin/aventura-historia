# Project Structure

## Directory Overview
- `.planning/`: GSD workflow state and codebase documentation.
- `android/`: Android-specific platform code and Gradle configuration.
- `assets/`: Static image assets (characters, UI elements, era backgrounds).
- `build/`: Generated build artifacts.
- `ios/`: iOS-specific platform code and CocoaPods configuration.
- `lib/`: Core Dart source code.
  - `core/`: Constants, themes, and global configuration.
  - `data/`: Models, database, and state management providers.
  - `game/`: Quiz logic, services, and game-specific UI components.
  - `screens/`: Top-level application pages.
  - `widgets/`: Reusable/generic UI components.
- `test/`: Unit and widget tests.

## Source Files (Primary)
- `lib/main.dart`: Entry point, provider setup, and `MaterialApp` configuration.
- `lib/data/database/database_helper.dart`: Primary SQLite implementation.
- `lib/data/providers/progress_provider.dart`: Global game state management.
- `lib/data/providers/character_provider.dart`: Companion/character collection state.
- `lib/game/services/quiz_service.dart`: Business logic for quiz flow and scoring.
- `lib/core/constants/historical_eras.dart`: Era data definitions (pre-Roman to modern).
