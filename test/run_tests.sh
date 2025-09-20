#!/bin/bash

# CourtBook Flutter App Test Runner
# This script runs all unit tests and widget tests for the application

echo "🏃‍♂️ Running CourtBook Flutter App Tests"
echo "======================================"

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Check if we're in the correct directory
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ pubspec.yaml not found. Please run this script from the Flutter project root."
    exit 1
fi

echo "📦 Installing dependencies..."
flutter pub get

echo ""
echo "🧪 Running Unit Tests..."
echo "-----------------------"

# Run unit tests
echo "Testing Date Helper functions..."
flutter test test/unit/date_helper_test.dart

echo "Testing Booking Model..."
flutter test test/unit/booking_model_test.dart

echo "Testing Court Model..."
flutter test test/unit/court_model_test.dart

echo "Testing Booking Service..."
flutter test test/unit/booking_service_test.dart

echo "Testing Time Slot Conflict Detection..."
flutter test test/unit/time_slot_conflict_test.dart

echo ""
echo "🎭 Running Widget Tests..."
echo "-------------------------"

# Run widget tests
flutter test test/widget_test.dart

echo ""
echo "🔍 Running All Tests..."
echo "----------------------"

# Run all tests together
flutter test

echo ""
echo "✅ Test execution completed!"
echo "=========================="

# Show test coverage if available
if command -v genhtml &> /dev/null; then
    echo ""
    echo "📊 Generating test coverage report..."
    flutter test --coverage
    if [ -f "coverage/lcov.info" ]; then
        genhtml coverage/lcov.info -o coverage/html
        echo "📈 Coverage report generated in coverage/html/index.html"
    fi
else
    echo "💡 Install lcov to generate coverage reports: brew install lcov"
fi
