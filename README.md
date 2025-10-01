# 📱 Pokédex App

A modern Flutter application that brings the classic Pokédex experience to your mobile device with a retro pixel theme inspired by the original Pokédex design.

## 🎨 Design Theme

The app features a **pixel-perfect retro theme** with the classic Pokédex color scheme:
- **Primary Color**: Deep Red (`#CC0000`) - Inspired by the classic Pokédex red
- **Secondary Colors**: Pure White (`#FAFAFA`) and Deep Black (`#1A1A1A`)
- **Typography**: Monospace font family for that authentic retro computing feel
- **UI Elements**: Bordered containers, pixelated styling, and classic gaming aesthetics

## ✨ Features

### 🏠 Core Functionality
- **Pokémon Browser**: Browse through all Pokémon with detailed information
- **Advanced Search**: Search Pokémon by name with real-time filtering
- **Type Filtering**: Filter Pokémon by their types
- **Favorites System**: Save your favorite Pokémon for quick access
- **Detailed Views**: Comprehensive Pokémon details including stats, types, and abilities

### 🎒 Items Section
- **Item Catalog**: Browse through all Pokémon items with **icons displayed in list view**
- **Item Details**: View detailed information about each item including:
  - High-quality item images
  - Category classification
  - Cost in Pokédollars
  - Effect descriptions
- **Search Functionality**: Find specific items quickly

### ⚡ Moves Database
- **Move Encyclopedia**: Complete database of Pokémon moves
- **Move Details**: Detailed move information and statistics

### 🎮 Games Collection
- **Game Library**: Information about Pokémon games
- **Game Details**: Comprehensive game information

### 🌟 Additional Features
- **Offline Support**: Cached data for offline browsing
- **Background Services**: Automatic data updates
- **Push Notifications**: Stay updated with Pokédex notifications
- **Multi-language Support**: English and Vietnamese localization
- **Dark/Light Themes**: Both themes maintain the pixel aesthetic
- **Responsive Design**: Optimized for different screen sizes

## 🛠️ Technical Stack

### Framework & Language
- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language

### State Management
- **Provider**: Efficient state management throughout the app

### Data & Storage
- **HTTP**: RESTful API communication with PokéAPI
- **Hive**: Local database for caching and favorites
- **Cached Network Images**: Optimized image loading and caching

### UI/UX Libraries
- **Shimmer**: Loading animations
- **Custom Pixel Theme**: Retro gaming-inspired design system

### Services
- **Background Services**: Workmanager for background tasks
- **Local Notifications**: Flutter Local Notifications

## 🎯 App Architecture

### Design Patterns
- **MVVM (Model-View-ViewModel)**: Clean separation of concerns
- **Provider Pattern**: Reactive state management
- **Repository Pattern**: Data layer abstraction

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── pokemon_*.dart
│   ├── item.dart
│   ├── move.dart
│   └── game.dart
├── providers/                # State management
│   ├── pokemon_list_provider.dart
│   ├── item_list_provider.dart
│   ├── favorites_provider.dart
│   └── *_provider.dart
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── item_list_screen.dart
│   ├── item_detail_screen.dart
│   └── *.dart
├── services/                 # Business logic
│   ├── poke_api_service.dart
│   ├── notification_service.dart
│   └── background_service.dart
├── theme/                    # Pixel theme system
│   └── app_theme.dart
├── widgets/                  # Reusable components
│   ├── pokemon_card.dart
│   └── shimmer.dart
└── utils/                    # Utilities
    └── type_colors.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.9.2)
- Dart SDK
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd pokedex_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (macOS only)
flutter build ios --release
```

## 🎮 Pixel Theme Highlights

- **Retro Aesthetics**: Monospace fonts and pixelated borders
- **Classic Colors**: Authentic Pokédex red, white, and black color scheme
- **Gaming UI**: Bordered containers reminiscent of classic handheld gaming
- **Consistent Design**: Pixel theme applied across all screens and components
- **Enhanced UX**: Item icons in list views for better visual identification

## 🔄 Recent Updates

### Version 1.0.0
- ✅ **New Pixel Theme**: Complete UI overhaul with retro gaming aesthetics
- ✅ **Item Icons**: Added item icons in list view for better visual experience
- ✅ **Enhanced Typography**: Monospace fonts for authentic retro feel
- ✅ **Improved Navigation**: Pixel-styled bottom navigation
- ✅ **Better Cards**: Enhanced Pokemon and item cards with bordered design
- ✅ **Consistent Theming**: Dark and light themes with pixel aesthetic


## 🙏 Acknowledgments

- **PokéAPI**: For providing the comprehensive Pokémon data
- **Flutter Team**: For the amazing cross-platform framework
- **Pokémon Company**: For the inspiration and original Pokédex design
- **Retro Gaming Community**: For inspiration on pixel art and design


*Built with ❤️ using Flutter and inspired by the classic Pokédex experience*
