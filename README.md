# GCPRUN - Flutter Mobile App

Marketplace mobile app for GCPRUN, built with Flutter.

## Tech Stack

- **Framework**: Flutter 3.x (Dart 3.x)
- **State Management**: Riverpod 2.x
- **Routing**: GoRouter 14.x
- **HTTP Client**: Dio 5.x
- **Local Storage**: Hive + Flutter Secure Storage
- **Image Caching**: Cached Network Image
- **Charts**: FL Chart
- **Forms**: Flutter Form Builder

## Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / Xcode
- A device or emulator

### Setup

```bash
# Clone the repository
git clone git@github.com:bukdan101-star/gcprun-flutter.git

# Navigate to project
cd gcprun_flutter

# Generate platform files (first time only)
flutter create .

# Install dependencies
flutter pub get

# Run code generation (freezed, json_serializable)
dart run build_runner build --delete-conflicting-outputs

# Copy environment file
cp .env.example .env

# Run the app
flutter run
```

## Project Structure

```
lib/
├── main.dart                          # App entry point
├── app.dart                           # Root MaterialApp widget
│
├── core/                              # Shared core utilities
│   ├── constants/
│   │   └── api_constants.dart         # API endpoint constants
│   ├── network/
│   │   ├── api_client.dart            # Dio HTTP client with auth interceptor
│   │   └── api_response.dart          # Generic API response wrapper
│   ├── presentation/
│   │   └── pages/
│   │       └── splash_page.dart       # Splash screen
│   ├── router/
│   │   └── app_router.dart            # GoRouter configuration
│   ├── theme/
│   │   ├── app_colors.dart            # Color palette
│   │   └── app_theme.dart             # Light & dark theme
│   ├── utils/
│   │   ├── currency_formatter.dart    # Rupiah formatter
│   │   ├── date_formatter.dart        # Indonesian date formatter
│   │   └── validators.dart            # Form validators
│   └── widgets/
│       ├── empty_state.dart           # Empty state placeholder
│       ├── listing_card.dart          # Listing card (grid & horizontal)
│       ├── loading_skeleton.dart      # Shimmer loading skeletons
│       └── stats_card.dart            # Stats summary card
│
├── features/                          # Feature modules (Clean Architecture)
│   ├── auth/                          # Authentication
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── auth_remote_datasource.dart
│   │   │   └── models/
│   │   │       └── user_model.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   ├── register_page.dart
│   │       │   └── forgot_password_page.dart
│   │       └── providers/
│   │           └── auth_provider.dart
│   │
│   ├── dashboard/                     # Dashboard (14 pages)
│   │   └── presentation/pages/
│   │       ├── dashboard_shell.dart   # Bottom nav shell
│   │       ├── home_page.dart         # Dashboard home
│   │       ├── profile_page.dart      # User profile
│   │       ├── listings_page.dart     # My listings
│   │       ├── orders_page.dart       # Orders management
│   │       ├── wallet_page.dart       # Wallet & balance
│   │       ├── withdraw_page.dart     # Withdrawal
│   │       ├── messages_page.dart     # Conversations list
│   │       ├── notifications_page.dart
│   │       ├── wishlist_page.dart
│   │       ├── kyc_page.dart          # KYC verification
│   │       ├── coupons_page.dart
│   │       ├── ai_credit_score_page.dart
│   │       ├── support_page.dart
│   │       └── settings_page.dart
│   │
│   ├── listing/                       # Listing detail & create
│   ├── marketplace/                   # Browse marketplace
│   ├── messages/                      # Chat messaging
│   └── user/                          # Other user profiles
│
└── shared/                            # Shared providers & utilities
    └── providers/
        └── theme_provider.dart        # Theme mode notifier
```

## Architecture

This app follows **Clean Architecture** principles:

- **Presentation Layer**: UI widgets, pages, and Riverpod providers/notifiers
- **Domain Layer**: Entities, repository interfaces, and use cases
- **Data Layer**: Remote data sources, models, and repository implementations

## Build & Release

```bash
# Build APK
flutter build apk --release

# Build App Bundle
flutter build appbundle --release

# Build iOS
flutter build ios --release
```

## Environment Variables

See `.env.example` for all configuration options.
