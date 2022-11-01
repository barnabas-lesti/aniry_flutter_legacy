# Aniry

Aniry calorie counter mobile application.

## First time setup
### Install and configure the following tools:
- [Git](https://git-scm.com/downloads)
  - On Mac, install [Xcode](https://developer.apple.com/xcode/) from the App Store and verify that **Git** is available:
```bash
git --version
```
- [Flutter](https://docs.flutter.dev/get-started/install)
- Clone the repository
  - Authenticate using GitHub
  - Set git username and email for the repo:
```bash
git config user.name "Barnabas Lesti"
git config user.email "barnabas.lesti@gmail.com"
```
- [VSCode](https://code.visualstudio.com/download) with recommended extensions
- Verify that the app can be started

### Set up simulators
  - For Android, install [Android Studio](https://developer.android.com/studio)
  - For iOS, **Xcode** handles the simulators

## Development
Follow [Flutters test-drive](https://docs.flutter.dev/get-started/test-drive) instructions.


```bash
# Start development server on simulator
flutter run

# Deploy release version to device
flutter run --release

# Generate JSON serializable models (*.g.dart files)
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localized message files
flutter gen-l10n
```

## Resources
- https://docs.flutter.dev/
- https://dart.dev/guides/language/effective-dart/style
- https://fonts.google.com/icons?selected=Material+Icons
- https://api.flutter.dev/flutter/material/Icons-class.html
- https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter-beamer/
- https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/
- https://www.geeksforgeeks.org/how-to-install-flutter-app-on-ios/
- https://github.com/flutter/samples/tree/main/provider_shopper
- https://docs.flutter.dev/development/accessibility-and-localization/internationalization
- https://localizely.com/flutter-arb/
- https://medium.com/@manoelsrs/dart-extends-vs-implements-vs-with-b070f9637b36
