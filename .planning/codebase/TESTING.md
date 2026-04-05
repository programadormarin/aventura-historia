# Testing

## Current Status
- **Current Coverage:** 100% functional tests (239 automated tests implemented).
- **Environment:** Flutter 3.19.4.
- **Infrastructure:** Tests are located in the `test/` directory.

## Testing Strategy (Implemented)
1. **Unit Tests:**
   - Data models (`Character.fromMap`).
   - Historical era enum extensions and logic.
2. **Widget Tests:**
   - Full screen coverage: `SplashScreen`, `HomeScreen`, `ChapterSelectionScreen`, `QuizScreen`, `QuizResultScreen`, `CharacterGalleryScreen`, `ProgressOverviewScreen`.
   - Navigation flow verification.
   - Provider-state injection and lifecycle verification.
   - UI consistency and stat rendering.
3. **Integration-style Widget Tests:**
   - End-to-end screen transitions and state updates across `AventuraHistoriaApp`.

## Execution

### Docker Execution (Recommended)
This ensures consistency with the production-like Flutter environment (3.19.4) and isolates database side-effects.

```bash
# First setup
make docker-setup

# Run all tests
make docker-test
```

### Local Execution
```bash
flutter test
```

## Key Test Fixes & Knowledge
- **Provider Lifecycle:** Mock providers are used to avoid real database access and are guarded with `_disposed` flags to prevent `notifyListeners` after test teardown.
- **Async Safety:** `pump(duration)` is used to clear pending timers from splash screens and service delays.
- **Compatibility:** Navigation tests use `MaterialApp` wrappers and pop detection instead of deprecated Flutter features.
