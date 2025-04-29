# Preptly

A Flutter application using GetX for state management and following Clean Architecture with MVC pattern.

## Setup

1. Clone the repository
2. Run `flutter pub get` to install dependencies

## App Icon Setup

The project uses `flutter_launcher_icons` to generate app icons. Follow these steps:

### Option 1: Create App Icons Using Online Services (Recommended)

1. Use an online app icon generator like [App Icon Generator](https://appicon.co/) or [Icon Kitchen](https://icon.kitchen/) to create app icons with the following specs:
   - Background color: #833CF6 (purple)
   - Foreground: A white 'P' on a white circle
   
2. Download the generated icons and place them in:
   - `assets/icon/app_icon.png` (full icon with background)
   - `assets/icon/app_icon_foreground.png` (only the foreground element)
   
3. Run the icon generator:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

### Option 2: Create Simple App Icons Manually

1. Download any 1024x1024 PNG image for your app
2. Rename it to `app_icon.png` and place it in the `assets/icon/` directory
3. Make a copy, rename it to `app_icon_foreground.png`, and place it in the same directory
4. Run the icon generator:
   ```bash
   flutter pub run flutter_launcher_icons
   ```

## Features

- **State Management:** GetX
- **Architecture:** Clean Architecture using MVC pattern
- **Responsive UI:** ScreenUtil for dynamic sizing
- **Constants:** Centralized constants for strings, colors, and styles
- **Theming:** Centralized theme using a primary and secondary color used throughout the app
- **Error Handling:** Proper error handling using custom exceptions

## Folder Structure

```
lib/
  - core/
    - constants/
      - app_colors.dart
      - app_strings.dart
    - theme/
      - app_theme.dart
    - network/
    - routes/
      - app_routes.dart
      - app_pages.dart
    - widgets/
      - common_button.dart
  - features/
    - splash/
      - screen/
        - splash_screen.dart
      - binding/
        - splash_binding.dart
    - contact_us/
      - controller/
        - contact_us_controller.dart
      - screen/
        - contact_us_screen.dart
      - binding/
        - contact_us_binding.dart
```

## Running the Project

```bash
flutter run
```
