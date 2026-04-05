# Conventions

## Coding Standards
- **Naming:** Follows standard Dart/Flutter camelCase for variables/functions and PascalCase for classes.
- **Providers:** Always use `ChangeNotifier` and `notifyListeners()` for state updates.
- **Asynchronicity:** Extensive use of `async`/`await` for all database interactions.
- **UI Architecture:** Use `StatelessWidget` where possible; use `Provider` for cross-widget state instead of `StatefulWidget`.
- **Typing:** Strict typing for models (`fromMap` and `toMap` for SQLite integration).

## File & Directory Structure
- Logic and UI components are separated into dedicated directories (`lib/game` vs `lib/screens`).
- Constants (strings, themes, era lists) reside in `lib/core`.

## UI/UX Guidelines
- **Theme:** Uses unified `AppTheme` with system-aware light/dark mode.
- **Accessibility:** Uses localization strings via `AppStrings` for screen readers and future i18n.
- **Visuals:** Uses HSL-based palettes for historical eras.
- **Animations:** Uses standard Flutter transitions for screen changes.

## Internationalization
- The current base language is **Portuguese (Portugal)**.
- All strings should be placed in `lib/core/constants/app_strings.dart` (or better, use `arb` files in the future).
