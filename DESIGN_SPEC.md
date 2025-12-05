# ConnectMe Design Specification

## Overview
This document contains the complete design specification for the ConnectMe social app, implemented in Flutter.

## Color System

### Light Theme
```dart
Primary: #FF6B6B (coral red)
Primary Hover: #FF5252 (darker coral)
Secondary: #4ECDC4 (turquoise)
Accent: #FFE66D (warm yellow)
Background: #FAFAFA (off-white)
Surface: #FFFFFF (white)
Text: #2D3436 (dark gray)
Text Secondary: #636E72 (medium gray)
Text Tertiary: #B2BEC3 (light gray)
Border: #E8ECEF (very light gray)
Success: #00B894 (green)
Error: #FF6B6B (coral red)
```

### Dark Theme
```dart
Primary: #FF8E8E (lighter coral)
Primary Hover: #FFA3A3 (even lighter coral)
Secondary: #5DD9D1 (lighter turquoise)
Accent: #FFE66D (warm yellow)
Background: #0F1419 (very dark blue-black)
Surface: #1A1F2E (dark blue-gray)
Surface Elevated: #252B3B (lighter dark blue-gray)
Text: #E8ECEF (light gray)
Text Secondary: #B2BEC3 (medium gray)
Text Tertiary: #636E72 (darker gray)
Border: #2D3748 (dark border)
Success: #00B894 (green)
Error: #FF8E8E (lighter coral)
```

## Typography

### Font Sizes
- XS: 12px
- SM: 14px
- Base: 16px
- LG: 18px
- XL: 24px
- 2XL: 32px
- 3XL: 48px

### Font Weights
- Regular: 400
- Medium: 500
- Semibold: 600
- Bold: 700

### Line Heights
- Tight: 1.2
- Normal: 1.5
- Relaxed: 1.75

## Spacing System
- XS: 4px
- SM: 8px
- MD: 16px
- LG: 24px
- XL: 32px
- 2XL: 48px

## Border Radius
- SM: 8px
- MD: 12px
- LG: 16px
- XL: 24px
- Full: 9999px (pill shape)

## Component Specifications

### Button
**Variants:**
- Primary: Filled with primary color
- Secondary: Outlined with border
- Ghost: Transparent background

**Sizes:**
- Small: 8px/16px padding, 14px text
- Medium: 12px/24px padding, 16px text
- Large: 16px/32px padding, 18px text

**Animation:** Scale to 0.98 on tap

### Avatar
**Sizes:**
- Small: 40px
- Medium: 48px
- Large: 64px
- XL: 96px

**Features:**
- Image or initials fallback
- Online status indicator
- Circular shape

### Card
**Properties:**
- Border radius: 16px
- Padding: 16px
- Shadow: Small or medium
- Tap animation: Scale 0.98

### Input Field
**Properties:**
- Border: 2px solid
- Border radius: 16px
- Padding: 12px/16px
- Icon support
- Focus state: Primary color border

### Interest Tag
**Properties:**
- Padding: 8px/16px
- Border radius: Full
- Border: 2px solid
- Selected: Primary background
- Unselected: Surface elevated background
- Animation: Scale pulse on selection

## Screen Specifications

### 1. Splash Screen
- Duration: 2.5 seconds
- Heart icon animation (scale + rotate)
- Text fade-in animations
- Loading dots pulse animation

### 2. Onboarding (3 slides)
- Progress indicators (4px height)
- Icon container (128px circle)
- Slide animations with spring physics
- Skip button option

### 3. Auth Screen
- Email, password, name inputs
- Toggle between sign in/sign up
- Smooth height animation for name field
- Google sign-in option

### 4. Interests Screen
- Minimum 3 interests required
- Stagger animation (30ms delay)
- Selection counter
- Disabled continue button until 3+ selected

### 5. Discovery Screen
- User cards (580px height)
- Image with gradient overlay
- Interest tags (max 3 visible)
- Action buttons (Pass, Info, Like)
- Swipe animations

### 6. Chat List Screen
- Search input
- Avatar with online status
- Unread badge
- Stagger animation (50ms delay)

### 7. Chat Screen
- Header with avatar and status
- Message bubbles (left/right aligned)
- Input field with send button
- Auto-scroll to bottom

### 8. Settings Screen
- Sectioned layout
- Toggle switches
- Icon circles
- Danger items (logout)
- Version footer

## Animation Specifications

### Spring Physics
- Stiffness: 300-500
- Damping: 24-30
- Used for natural, bouncy animations

### Transitions
- Page transitions: 300ms
- Button press: 100ms
- Toggle switch: 200ms
- List stagger: 50ms delay per item

### Interactive Elements
- Tap scale: 0.98 (buttons/cards)
- Tap scale: 0.9 (icon buttons)
- Hover opacity: 0.7 (desktop only)

## Accessibility

- Minimum touch targets: 44px × 44px
- Color contrast: 4.5:1 for normal text
- Semantic HTML structure
- Screen reader support
- Keyboard navigation support
- Focus indicators on all interactive elements

## Implementation Notes

1. All colors use theme-aware system
2. Spacing follows 4px/8px grid
3. Border radius is consistent across components
4. Shadows are theme-specific
5. Animations use spring physics
6. Theme persists to local storage
7. All images use NetworkImage with Unsplash URLs
8. Icons use Lucide Icons library

## Responsive Behavior

- Max content width: 448px (forms)
- Max content width: 672px (chat)
- Centered layouts with auto margins
- Mobile-first approach
- Bottom navigation always visible

## State Management

- Provider pattern for global state
- Theme state with persistence
- App navigation state
- User data management
- Chat conversations
- Selected interests

---

This specification ensures 100% visual and behavioral accuracy in the Flutter implementation.
