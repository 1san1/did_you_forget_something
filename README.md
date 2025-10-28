# Did You Forget Something?

A Flutter application that keeps you prepared with contextual reminders, smart checklists, and routines inspired by the supporting product and architecture documentation in this repository.

## Sprint 1 – Foundation

This iteration lays the groundwork for the mobile experience:

- Flutter project scaffold with Material 3 theming.
- Riverpod-powered application state container and theme controller.
- Hive-based local storage service ready for checklists, reminders, and routines.

## Getting Started

> **Note:** Flutter SDK 3.16 or newer is recommended.

1. Install Flutter following the official [setup guide](https://docs.flutter.dev/get-started/install).
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
  app/
    app.dart          # Root MaterialApp definition
    bootstrap.dart    # Dependency bootstrapping and ProviderScope
    controllers/      # Riverpod controllers (e.g., ThemeController)
    theme.dart        # Light and dark theme definitions
    view/             # Global application shells and scaffolds
  features/
    checklists/
    reminders/
    routines/
    insights/
  shared/
    repositories/     # Data access layers backed by services
    services/         # Platform integrations such as Hive
    utils/
    widgets/
```

Future sprints will flesh out the feature directories with rich domain models, UX flows, and intelligent reminders.
