# ConnectMe - Social Connection App

A modern, beautiful social connection app built with Flutter following a comprehensive design specification.

## Features

✨ **Complete Feature Set:**
- 🎨 Beautiful UI with light/dark theme support
- 🔐 Authentication (Sign In/Sign Up)
- 🎯 Interest-based matching
- 💬 Real-time chat interface
- 👥 User discovery with swipeable cards
- ⚙️ Comprehensive settings
- 🌓 Theme persistence
- 📱 Fully responsive design

## Design System

### Color Palette
- **Primary:** Coral Red (#FF6B6B)
- **Secondary:** Turquoise (#4ECDC4)
- **Accent:** Warm Yellow (#FFE66D)
- Comprehensive light/dark theme support

### Typography
- System font stack for optimal performance
- 7 font sizes (XS to 3XL)
- 4 font weights (Regular to Bold)
- 3 line heights (Tight, Normal, Relaxed)

### Components
- Custom buttons (Primary, Secondary, Ghost)
- Avatar with online status
- Interactive cards
- Chat bubbles
- Interest tags
- Bottom navigation

## Screens

1. **Splash Screen** - Animated app intro
2. **Onboarding** - 3-slide introduction
3. **Auth Screen** - Sign in/Sign up
4. **Interests** - Select user interests
5. **Discovery** - Swipeable user cards
6. **Chat List** - All conversations
7. **Chat** - Individual conversation
8. **Settings** - App preferences

## Getting Started

### Prerequisites
- Flutter SDK (3.9.2 or higher)
- Dart SDK

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd connect_me
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   └── theme/           # Theme configuration
│       ├── app_colors.dart
│       ├── app_typography.dart
│       ├── app_spacing.dart
│       └── app_theme.dart
├── models/              # Data models
│   ├── user_profile.dart
│   ├── chat.dart
│   └── interest.dart
├── providers/           # State management
│   ├── theme_provider.dart
│   └── app_provider.dart
├── screens/             # App screens
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── auth_screen.dart
│   ├── interests_screen.dart
│   ├── home_screen.dart
│   ├── discovery_screen.dart
│   ├── chat_list_screen.dart
│   ├── chat_screen.dart
│   └── settings_screen.dart
├── widgets/             # Reusable widgets
│   └── common/
│       ├── custom_button.dart
│       ├── custom_avatar.dart
│       └── custom_card.dart
├── data/                # Mock data
│   └── mock_data.dart
└── main.dart            # App entry point
```

## Dependencies

- **provider** (^6.1.1) - State management
- **shared_preferences** (^2.2.2) - Local storage
- **lucide_icons** (^0.257.0) - Icon library

## Design Specifications

This app is built following a comprehensive design specification that ensures:
- Pixel-perfect implementation
- Consistent spacing (4px/8px/16px/24px/32px/48px system)
- Proper border radius (8px/12px/16px/24px/full)
- Theme-aware shadows
- Spring-based animations
- Accessibility compliance

## Animations

All animations use spring physics for natural, delightful motion:
- Tap/press feedback (scale 0.98)
- Page transitions (horizontal slide)
- List stagger animations
- Icon scale animations
- Toggle switch animations

## Theme Support

The app supports both light and dark themes with:
- Automatic theme persistence
- Smooth transitions (200ms)
- Theme-aware colors for all components
- Proper contrast ratios for accessibility

## State Management

Uses Provider pattern for:
- Theme state (light/dark mode)
- App navigation state
- User data management
- Chat conversations
- Selected interests

## Contributing

This is a demonstration project built to showcase Flutter development skills and adherence to design specifications.

## License

MIT License

## Author

Built with ❤️ using Flutter

---

**Note:** This app uses mock data for demonstration purposes. In a production environment, you would integrate with a real backend API for user authentication, data storage, and real-time messaging.
