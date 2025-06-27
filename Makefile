# Variables
APP_NAME ?= twins-for-android
DOCKER_COMPOSE_CMD = docker-compose
DOCKER_COMPOSE_RUN = $(DOCKER_COMPOSE_CMD) run --rm android-app
DOCKER_BUILD_CMD = docker build

# Phony targets (targets que no representan archivos)
.PHONY: all build shell bash clean \
	assemble debug release \
	test test-unit test-instrumented \
	install install-debug \
	logs help

# Default target
all: help

# Docker targets
build:
	@echo "Building Docker image..."
	$(DOCKER_COMPOSE_CMD) build

shell: bash # Alias
bash:
	@echo "Opening bash shell in Docker container..."
	$(DOCKER_COMPOSE_RUN) bash

# Gradle build targets
assemble: debug
debug:
	@echo "Building debug APK..."
	$(DOCKER_COMPOSE_RUN) ./gradlew :app:assembleDebug

release:
	@echo "Building release APK..."
	$(DOCKER_COMPOSE_RUN) ./gradlew :app:assembleRelease

clean:
	@echo "Cleaning project..."
	$(DOCKER_COMPOSE_RUN) ./gradlew :app:clean
	@echo "Cleaning Docker build cache (optional, uncomment if needed)..."
	# $(DOCKER_COMPOSE_CMD) down --rmi local --volumes

# Gradle test targets
test: test-unit
test-unit:
	@echo "Running unit tests..."
	$(DOCKER_COMPOSE_RUN) ./gradlew :app:testDebugUnitTest

# Instrumented tests are more complex with Docker as they require a running emulator or device.
# This target assumes ADB is configured to connect to a device/emulator from the Docker container.
# This might require network_mode: "host" or other specific Docker network configurations.
test-instrumented:
	@echo "Running instrumented tests (requires connected device/emulator and proper ADB setup)..."
	$(DOCKER_COMPOSE_RUN) ./gradlew :app:connectedDebugAndroidTest

# Install targets (similar complexity to instrumented tests regarding ADB)
install: install-debug
install-debug:
	@echo "Installing debug APK (requires connected device/emulator and proper ADB setup)..."
	$(DOCKER_COMPOSE_RUN) ./gradlew :app:installDebug

# Utility targets
logs:
	@echo "Showing logs from Docker container (if running in detached mode)..."
	$(DOCKER_COMPOSE_CMD) logs -f android-app

help:
	@echo "Available Makefile targets:"
	@echo "  all                  - Show this help message"
	@echo "  build                - Build the Docker image"
	@echo "  shell / bash         - Open an interactive bash shell in the Docker container"
	@echo "  assemble / debug     - Build the debug APK"
	@echo "  release              - Build the release APK"
	@echo "  clean                - Clean the Gradle project (and optionally Docker cache)"
	@echo "  test / test-unit     - Run unit tests"
	@echo "  test-instrumented    - Run instrumented tests (requires device/emulator & ADB setup)"
	@echo "  install / install-debug - Install debug APK (requires device/emulator & ADB setup)"
	@echo "  logs                 - Show logs from the Docker container"
