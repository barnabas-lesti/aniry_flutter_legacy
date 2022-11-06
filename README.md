# Aniry

Aniry calorie counter mobile application.

## First time setup
### Tools
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

### Simulators
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

Application file location on simulator:
- 'Library/Developer/CoreSimulator/Devices/272369ED-9FA9-473A-84BE-52BF363A2F46/data/Containers/Data/Application/CAD10C54-7048-4542-9C1A-54F7A911C07C/Documents'

## Conventions
### State management
- Prioritize the use of `StatelessWidget` where possible.
  - Utilize constructor parameters and default values.
- Use `StatefulWidget` when widget state can/should change and the widget doesn't need to interact with other widgets.
- Create controllers where child widget data needs to be accessed from parent on specific events on demand, eg.:
  - `TextFormField` widget text is required in parent when a specific event occurs.
  - An `IngredientFormController` should be passed to the `IngredientForm` that has a `getIngredient` function. This will return an `Ingredient` instance when parent save button is pressed.
- Only use `Providers` as repositories, when state needs to be shared around the feature/app, data of the provider can change and re-build of widgets is required.
  - These providers should be injected on root app level.

### Models
- All models should be located in the `/models` folder of a feature.
- Ordering of properties and functions in a model:
  1. Argument definitions.
  2. Constructor and argument assignments.
  3. Private properties + Getter and Setter if any:
  4. Static properties
  5. Static methods
  6. Public instance methods
  7. Private instance methods
```dart
class Foo {
  late String id;

  Foo({ required this.id });

  String _description;

  String _name;
  String get name => _name;
  set name(String value) => _name = value;

  static final Color color = Colors.green[400]!;

  static Foo fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {}

  void _foo() {}
}
```

### Widgets
- All widgets should be located in the `/widgets` folder of a feature.
- Screens count as widgets.
- All non one line/statement properties or methods should be defined as private getters or methods on the widget class (not in the `build` function).
- Methods that require context should be built using `_build` methods.
- Related methods (like `showWidget` or `buildWidget`) should be created in the same file as public methods.
- Related widgets (like `_AppListTile` for `AppList`) should be created in the same file as private widgets (if not needed elsewhere).

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
