# Aventura da História - Makefile
# Flutter educational game about Portuguese History

# Variables
FLUTTER := flutter
DART := dart
PACKAGE_NAME := aventura_historia
APK_OUTPUT := build/app/outputs/flutter-apk
BUILD := build

# Default target
.PHONY: help
help: ## Show this help message
	@echo "Aventura da História - Available Commands"
	@echo "=========================================="
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

# ==================== Setup ====================

.PHONY: setup
setup: ## Initial project setup - install dependencies
	$(FLUTTER) pub get

.PHONY: clean
clean: ## Clean build artifacts
	$(FLUTTER) clean
	$(FLUTTER) pub get

.PHONY: upgrade
upgrade: ## Upgrade Flutter and dependencies
	$(FLUTTER) upgrade
	$(FLUTTER) pub outdated

# ==================== Run ====================

.PHONY: run
run: ## Run app on connected device or emulator
	$(FLUTTER) run

.PHONY: run-debug
run-debug: ## Run app in debug mode with dev tools
	$(FLUTTER) run --debug

.PHONY: run-profile
run-profile: ## Run app in profile mode (for performance testing)
	$(FLUTTER) run --profile

.PHONY: run-release
run-release: ## Run app in release mode
	$(FLUTTER) run --release

# ==================== Testing ====================

.PHONY: test
test: ## Run all tests
	$(FLUTTER) test

.PHONY: test-coverage
test-coverage: ## Run tests with coverage report
	$(FLUTTER) test --coverage
	@echo ""
	@echo "Coverage report generated in coverage/lcov.info"

.PHONY: test-watch
test-watch: ## Run tests in watch mode
	$(FLUTTER) test --watch

.PHONY: test-single
test-single: ## Run a single test file (usage: make test-single FILE=test/file_test.dart)
	$(FLUTTER) test $(FILE)

.PHONY: test-golden
test-golden: ## Run golden tests and update golden files
	$(FLUTTER) test --update-goldens

# ==================== Analysis ====================

.PHONY: analyze
analyze: ## Analyze code for errors and warnings
	$(DART) analyze

.PHONY: analyze-fatal
analyze-fatal: ## Analyze code (treat warnings as errors)
	$(DART) analyze --fatal-infos

.PHONY: format
format: ## Format all Dart files
	$(DART) format lib/ test/

.PHONY: format-check
format-check: ## Check code formatting
	$(DART) format --set-exit-if-changed lib/ test/

.PHONY: fix
fix: ## Apply automated fixes
	$(DART) fix --apply lib/ test/

# ==================== Building ====================

.PHONY: build-apk
build-apk: ## Build APK
	$(FLUTTER) build apk
	@echo ""
	@echo "APK built at: $(APK_OUTPUT)/app-release.apk"

.PHONY: build-apk-split
build-apk-split: ## Build split APKs (per ABI)
	$(FLUTTER) build apk --split-per-abi
	@echo ""
	@echo "Split APKs built at: $(APK_OUTPUT)/"

.PHONY: build-appbundle
build-appbundle: ## Build Android App Bundle (for Play Store)
	$(FLUTTER) build appbundle
	@echo ""
	@echo "App Bundle built at: $(BUILD)/app/outputs/bundle/release/app-release.aab"

.PHONY: build-ios
build-ios: ## Build iOS (macOS only)
	$(FLUTTER) build ios --no-codesign

.PHONY: build-web
build-web: ## Build for web
	$(FLUTTER) build web

# ==================== Code Quality ====================

.PHONY: check
check: analyze test ## Run analysis and tests

.PHONY: precommit
precommit: format analyze test ## Run all checks before commit

# ==================== Dependencies ====================

.PHONY: pub-get
pub-get: ## Install dependencies
	$(FLUTTER) pub get

.PHONY: pub-upgrade
pub-upgrade: ## Upgrade dependencies
	$(FLUTTER) pub upgrade

.PHONY: pub-cache
pub-cache: ## Clean pub cache
	$(FLUTTER) pub cache clean

.PHONY: deps-outdated
deps-outdated: ## Show outdated dependencies
	$(FLUTTER) pub outdated

# ==================== Device Management ====================

.PHONY: devices
devices: ## List connected devices
	$(FLUTTER) devices

.PHONY: doctor
doctor: ## Show Flutter installation info
	$(FLUTTER) doctor

.PHONY: doctor-v
doctor-v: ## Show verbose Flutter doctor info
	$(FLUTTER) doctor -v

# ==================== Utilities ====================

.PHONY: gen-l10n
gen-l10n: ## Generate localization files
	$(FLUTTER) gen-l10n

.PHONY: icons
icons: ## Generate app icons (requires flutter_launcher_icons)
	$(DART) run flutter_launcher_icons

.PHONY: splash
splash: ## Generate splash screen (requires flutter_native_splash)
	$(DART) run flutter_native_splash:create

.PHONY: logs
logs: ## Show app logs (Android)
	adb logcat | grep -i flutter

# ==================== Git ====================

.PHONY: git-status
git-status: ## Show git status
	git status --short

.PHONY: git-log
git-log: ## Show recent git commits
	git log --oneline -20

# ==================== Docker ====================

.PHONY: docker-up
docker-up: ## Start docker services (db)
	docker-compose -f docker/docker-compose.yml up -d

.PHONY: docker-down
docker-down: ## Stop docker services
	docker-compose -f docker/docker-compose.yml down

.PHONY: docker-test
docker-test: ## Run tests inside docker container
	docker-compose -f docker/docker-compose.yml run tester

.PHONY: docker-setup
docker-setup: ## Build docker images and start services
	docker-compose -f docker/docker-compose.yml build
	docker-compose -f docker/docker-compose.yml up -d

# ==================== CI/CD ====================

.PHONY: ci
ci: setup format-check analyze test build-apk ## Run full CI pipeline

# ==================== Shortcuts ====================

.PHONY: d
d: ## Quick run in debug mode
	$(FLUTTER) run --debug

.PHONY: t
t: ## Quick test run
	$(FLUTTER) test

.PHONY: a
a: ## Quick analyze
	$(DART) analyze

.PHONY: r
r: run ## Alias for run
