#!/bin/bash

echo "============================================="
echo "  GCPRUN Flutter - Project Setup"
echo "============================================="
echo ""

# Check Flutter installation
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter SDK not found!"
    echo "   Install Flutter first: https://docs.flutter.dev/get-started/install"
    exit 1
fi

echo "✅ Flutter SDK found: $(flutter --version | head -1)"
echo ""

# Generate platform files if missing
if [ ! -d "android" ] || [ ! -d "ios" ]; then
    echo "📦 Generating platform files (android/ios)..."
    flutter create . --org com.gcprun --project-name gcprun
    echo "✅ Platform files generated"
else
    echo "✅ Platform files already exist"
fi

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
flutter pub get

# Copy env file
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "✅ Created .env from .env.example"
    fi
fi

echo ""
echo "============================================="
echo "  ✅ Setup Complete!"
echo ""
echo "  Next steps:"
echo "  1. Edit .env with your API configuration"
echo "  2. Run: flutter run"
echo "============================================="
