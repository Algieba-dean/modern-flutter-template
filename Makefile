SHELL := /bin/bash
.DEFAULT_GOAL := help

FLUTTER ?= flutter
DART ?= dart
APP_ENV ?= development
API_BASE_URL ?= https://api.example.com
COVERAGE_MIN ?= 80

DART_DEFINES := --dart-define=APP_ENV=$(APP_ENV) --dart-define=API_BASE_URL=$(API_BASE_URL)
DART_FORMAT_DIRS ?= lib test patrol_test tool
DART_FORMAT_EXCLUDES ?= -name test_bundle.dart

PATROL_TARGET ?= patrol_test/app_smoke_test.dart
PATROL_DEVICE ?= emulator-5554
PATROL_IOS_DEVICE ?= iPhone 16
PATROL_MACOS_DEVICE ?= macos
PATROL_FLUTTER_COMMAND ?= $(FLUTTER)

VERSION ?=
TAG_PREFIX ?= v
BUILD_NAME ?=
BUILD_NUMBER ?=

BUILD_VERSION_FLAGS :=
ifneq ($(strip $(BUILD_NAME)),)
BUILD_VERSION_FLAGS += --build-name=$(BUILD_NAME)
endif
ifneq ($(strip $(BUILD_NUMBER)),)
BUILD_VERSION_FLAGS += --build-number=$(BUILD_NUMBER)
endif

.PHONY: help
help: ## Show available Make targets.
	@awk 'BEGIN {FS = ":.*## "}; /^[a-zA-Z0-9_.-]+:.*## / {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: doctor
doctor: ## Print Flutter environment diagnostics.
	$(FLUTTER) doctor -v

.PHONY: setup
setup: ## Install Dart and Flutter dependencies.
	$(FLUTTER) pub get

.PHONY: get
get: setup ## Alias for setup.

.PHONY: pub-get
pub-get: setup ## Alias for setup.

.PHONY: outdated
outdated: ## Show dependency update status.
	$(FLUTTER) pub outdated

.PHONY: pub-outdated
pub-outdated: outdated ## Alias for outdated.

.PHONY: upgrade
upgrade: ## Upgrade dependencies within pubspec constraints.
	$(FLUTTER) pub upgrade

.PHONY: pub-upgrade
pub-upgrade: upgrade ## Alias for upgrade.

.PHONY: pub-upgrade-major
pub-upgrade-major: ## Upgrade dependencies including major versions.
	$(FLUTTER) pub upgrade --major-versions

.PHONY: format
format: ## Format all Dart code.
	find $(DART_FORMAT_DIRS) -name '*.dart' ! \( $(DART_FORMAT_EXCLUDES) \) -print0 | xargs -0 $(DART) format

.PHONY: fmt
fmt: format ## Alias for format.

.PHONY: format-check
format-check: ## Verify Dart formatting without writing changes.
	find $(DART_FORMAT_DIRS) -name '*.dart' ! \( $(DART_FORMAT_EXCLUDES) \) -print0 | xargs -0 $(DART) format --output=none --set-exit-if-changed

.PHONY: fix
fix: ## Show Dart automated fix suggestions.
	$(DART) fix --dry-run

.PHONY: fix-apply
fix-apply: ## Apply Dart automated fixes.
	$(DART) fix --apply

.PHONY: analyze
analyze: ## Run static analysis.
	$(FLUTTER) analyze

.PHONY: lint
lint: analyze ## Alias for analyze.

.PHONY: gen-l10n
gen-l10n: ## Generate Flutter localization sources.
	$(FLUTTER) gen-l10n

.PHONY: generate
generate: gen-l10n ## Run project code generation.

.PHONY: test
test: ## Run unit and widget tests.
	$(FLUTTER) test

.PHONY: test-verbose
test-verbose: ## Run unit and widget tests with expanded output.
	$(FLUTTER) test --reporter expanded

.PHONY: test-coverage
test-coverage: ## Run unit and widget tests with coverage.
	$(FLUTTER) test --coverage

.PHONY: coverage-check
coverage-check: test-coverage ## Enforce the minimum line coverage threshold.
	$(DART) run tool/check_coverage.dart $(COVERAGE_MIN)

.PHONY: check
check: ## Run fast local PR checks.
	$(MAKE) format-check
	$(MAKE) gen-l10n
	$(MAKE) analyze
	$(MAKE) test

.PHONY: ci
ci: ## Run the default CI quality gate.
	$(MAKE) format-check
	$(MAKE) gen-l10n
	$(MAKE) analyze
	$(MAKE) coverage-check

.PHONY: devices
devices: ## List connected Flutter devices.
	$(FLUTTER) devices

.PHONY: run
run: ## Run the app on the selected Flutter device.
	$(FLUTTER) run $(DART_DEFINES)

.PHONY: run-dev
run-dev: ## Run the app with development configuration.
	$(MAKE) run APP_ENV=development

.PHONY: run-staging
run-staging: ## Run the app with staging configuration.
	$(MAKE) run APP_ENV=staging

.PHONY: run-production
run-production: ## Run the app with production configuration.
	$(MAKE) run APP_ENV=production

.PHONY: run-web
run-web: ## Run the app in Chrome.
	$(FLUTTER) run -d chrome $(DART_DEFINES)

.PHONY: run-macos
run-macos: ## Run the app on macOS.
	$(FLUTTER) run -d macos $(DART_DEFINES)

.PHONY: patrol-build-android
patrol-build-android: ## Build the Android Patrol test app.
	$(DART) run patrol_cli:main --flutter-command="$(PATROL_FLUTTER_COMMAND)" build android --target $(PATROL_TARGET) $(DART_DEFINES)

.PHONY: patrol-test-android
patrol-test-android: ## Run Patrol tests on an Android device or emulator.
	$(DART) run patrol_cli:main --flutter-command="$(PATROL_FLUTTER_COMMAND)" test --target $(PATROL_TARGET) --device "$(PATROL_DEVICE)" $(DART_DEFINES)

.PHONY: patrol-build-ios
patrol-build-ios: ## Build the iOS Patrol test app.
	$(DART) run patrol_cli:main --flutter-command="$(PATROL_FLUTTER_COMMAND)" build ios --target $(PATROL_TARGET) $(DART_DEFINES)

.PHONY: patrol-test-ios
patrol-test-ios: ## Run Patrol tests on an iOS simulator or device.
	$(DART) run patrol_cli:main --flutter-command="$(PATROL_FLUTTER_COMMAND)" test --target $(PATROL_TARGET) --device "$(PATROL_IOS_DEVICE)" $(DART_DEFINES)

.PHONY: patrol-build-macos
patrol-build-macos: ## Build the macOS Patrol test app.
	$(DART) run patrol_cli:main --flutter-command="$(PATROL_FLUTTER_COMMAND)" build macos --target $(PATROL_TARGET) $(DART_DEFINES)

.PHONY: patrol-test-macos
patrol-test-macos: ## Run Patrol tests on macOS.
	$(DART) run patrol_cli:main --flutter-command="$(PATROL_FLUTTER_COMMAND)" test --target $(PATROL_TARGET) --device "$(PATROL_MACOS_DEVICE)" $(DART_DEFINES)

.PHONY: build-android-debug
build-android-debug: ## Build an Android debug APK.
	$(FLUTTER) build apk --debug $(DART_DEFINES)

.PHONY: build-apk
build-apk: build-android-debug ## Alias for build-android-debug.

.PHONY: build-ios-simulator
build-ios-simulator: ## Build an iOS simulator app without code signing.
	$(FLUTTER) build ios --simulator --no-codesign $(DART_DEFINES)

.PHONY: build-web
build-web: ## Build the Flutter web app.
	$(FLUTTER) build web $(DART_DEFINES)

.PHONY: build
build: build-web ## Build the default local artifact.

.PHONY: build-macos-debug
build-macos-debug: ## Build a macOS debug app.
	$(FLUTTER) build macos --debug $(DART_DEFINES)

.PHONY: build-windows-debug
build-windows-debug: ## Build a Windows debug app.
	$(FLUTTER) build windows --debug $(DART_DEFINES)

.PHONY: build-linux-debug
build-linux-debug: ## Build a Linux debug app.
	$(FLUTTER) build linux --debug $(DART_DEFINES)

.PHONY: build-release-android-apk
build-release-android-apk: ## Build an Android release APK.
	$(FLUTTER) build apk --release --obfuscate --split-debug-info=build/symbols/android $(BUILD_VERSION_FLAGS) $(DART_DEFINES)

.PHONY: build-release-android-aab
build-release-android-aab: ## Build an Android Play Store app bundle.
	$(FLUTTER) build appbundle --release --obfuscate --split-debug-info=build/symbols/android $(BUILD_VERSION_FLAGS) $(DART_DEFINES)

.PHONY: build-release-ios
build-release-ios: ## Build an iOS release IPA.
	$(FLUTTER) build ipa --release --obfuscate --split-debug-info=build/symbols/ios $(BUILD_VERSION_FLAGS) $(DART_DEFINES)

.PHONY: build-release-web
build-release-web: ## Build a production Flutter web app.
	$(FLUTTER) build web --release $(DART_DEFINES)

.PHONY: build-release-macos
build-release-macos: ## Build a macOS release app.
	$(FLUTTER) build macos --release --obfuscate --split-debug-info=build/symbols/macos $(BUILD_VERSION_FLAGS) $(DART_DEFINES)

.PHONY: build-release-windows
build-release-windows: ## Build a Windows release app.
	$(FLUTTER) build windows --release --obfuscate --split-debug-info=build/symbols/windows $(BUILD_VERSION_FLAGS) $(DART_DEFINES)

.PHONY: build-release-linux
build-release-linux: ## Build a Linux release app.
	$(FLUTTER) build linux --release --obfuscate --split-debug-info=build/symbols/linux $(BUILD_VERSION_FLAGS) $(DART_DEFINES)

.PHONY: release-check
release-check: ## Run the baseline checks before cutting a release.
	$(MAKE) ci
	$(MAKE) patrol-build-android
	$(MAKE) build-release-web APP_ENV=production

.PHONY: hooks-install
hooks-install: ## Install Lefthook Git hooks.
	lefthook install

.PHONY: hooks-run
hooks-run: ## Run Lefthook pre-commit checks manually.
	lefthook run pre-commit

.PHONY: tag
tag: ## Create an annotated release tag, e.g. make tag VERSION=1.2.3.
	@if [ -z "$(VERSION)" ]; then echo "VERSION is required, e.g. make tag VERSION=1.2.3"; exit 1; fi
	git tag -a "$(TAG_PREFIX)$(VERSION)" -m "Release $(TAG_PREFIX)$(VERSION)"

.PHONY: clean
clean: ## Remove Flutter build outputs.
	$(FLUTTER) clean

.PHONY: clean-deep
clean-deep: clean ## Remove generated local caches and reports.
	rm -rf .dart_tool build coverage
