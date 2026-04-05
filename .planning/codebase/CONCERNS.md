# Concerns

## Resolved & Mitigated
- **Test Coverage:** ✅ 239 automated tests implemented (Unit/Widget/Integration).
- **Environment Compatibility:** ✅ Fixed compatibility with Flutter 3.19.4 (`Color.toARGB32`, `CardTheme`, `onDidRemovePage`).
- **Provider-Timer Errors:** ✅ Safety handles for `_disposed` providers prevent "pending timer" errors during teardown.
- **Async Data Matching:** ⏳ Fixed ambiguous text finders in `ProgressOverviewScreen` by using `findsNWidgets(2)` where needed.

## Technical Debt & Issues
- **Localization Strategy:** Strings are hardcoded using `AppStrings` class; implementing official Flutter `l10n` (`.arb` files) would be more robust for multi-lingual expansion.
- **Database Maintenance:** No version-aware migrations are currently implemented; a schema change may require a full reset of users' data.
- **Asset Bundle Size:** Character images are local; as more eras are added, the bundle size may grow significantly. Remote asset fetching should be considered for large-scale content.
- **State Management Overhead:** Complex screen transitions may benefit from a more structured solution if the app grows beyond basic CRUD logic.

## Maintenance Risks
- **Dependency Versions:** High dependency on specific Flutter version (3.19.4) - future upgrades will require regression testing across all screens.
- **Platform-Specific:** Local database path varies across Android/iOS; testing in Docker is primarily covering the business and UI logic, not platform filesystem layers.

## Strategic Recommendations
- **Formalize l10n** with `.arb` files.
- **Add database migration support** using `onUpgrade` in `sqflite`.
- **Implement CI** that runs the `make docker-test` command on every push.
