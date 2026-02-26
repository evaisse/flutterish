---
name: creating-package
description: Scaffold a new Flutter package inside the flutterish monorepo. Use when asked to create, add, or scaffold a new package in the workspace.
---

# Creating a New Package in the Flutterish Monorepo

This skill guides the creation of a new independently-publishable Flutter package inside the `packages/` directory of the flutterish Dart workspace.

## Naming Convention

All packages are prefixed with `flutterish_`:

```
flutterish_<feature>          # e.g. flutterish_avatar, flutterish_carousel
```

The directory name must match the package name exactly.

## Step-by-Step Workflow

### 1. Create the directory structure

```
packages/flutterish_<feature>/
├── lib/
│   ├── src/               # Private implementation files
│   │   └── <feature>.dart
│   └── flutterish_<feature>.dart   # Barrel export (public API)
├── test/
│   └── <feature>_test.dart
├── analysis_options.yaml
├── CHANGELOG.md
└── pubspec.yaml
```

### 2. Create `pubspec.yaml`

```yaml
name: flutterish_<feature>
description: <One-line description of the package.>
version: 0.0.1
homepage: https://github.com/evaisse/flutterish/tree/main/packages/flutterish_<feature>
repository: https://github.com/evaisse/flutterish
resolution: workspace

environment:
  sdk: ^3.10.0

dependencies:
  flutter:
    sdk: flutter
  # Add sibling packages as path deps ONLY if needed:
  # flutterish_a2ui:
  #   path: ../flutterish_a2ui

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

Key rules:
- `resolution: workspace` is **required** — it links the package to the Dart workspace.
- Use `path:` dependencies for sibling packages (e.g. `../flutterish_a2ui`).
- Match the SDK constraint from the root workspace (`^3.9.0`).
- Never add dependencies not already used in the workspace without checking first.

### 3. Create the barrel export file

`lib/flutterish_<feature>.dart`:

```dart
library;

export 'src/<feature>.dart';
// export additional src files as needed
```

Only export the **public API**. Keep implementation details in `src/` unexported.

### 4. Create `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml
```

### 5. Create `CHANGELOG.md`

```markdown
# Changelog

## 0.0.1

- Initial release with <brief feature summary>.
```

### 6. Register the package in the workspace

Add the package path to the `workspace:` list in the **root** `pubspec.yaml`:

```yaml
workspace:
  - packages/flutterish
  - packages/flutterish_stepper
  - packages/flutterish_a2ui
  - packages/flutterish_a2ui_standard
  - packages/flutterish_<feature>   # ← add here
  - example
```

### 7. Add to the `PACKAGES` variable in `Makefile`

Append to the `PACKAGES` line so `make test`, `make analyze`, etc. cover the new package:

```makefile
PACKAGES := packages/flutterish_stepper packages/flutterish_a2ui packages/flutterish_a2ui_standard packages/flutterish_<feature> packages/flutterish
```

**Important:** Keep `packages/flutterish` (the umbrella) **last** in the list.

### 8. (Optional) Re-export from the umbrella package

If the package should be available via `package:flutterish/flutterish.dart`, add it to:

**`packages/flutterish/pubspec.yaml`** — add the dependency:
```yaml
dependencies:
  flutterish_<feature>:
    path: ../flutterish_<feature>
```

**`packages/flutterish/lib/flutterish.dart`** — add the re-export:
```dart
export 'package:flutterish_<feature>/flutterish_<feature>.dart';
```

### 9. Resolve and verify

```bash
flutter pub get        # Resolve workspace dependencies
make analyze           # Verify no analysis errors
make test              # Run all tests including the new package
```

## Checklist

Before considering the package done, verify:

- [ ] Package name starts with `flutterish_`
- [ ] `pubspec.yaml` has `resolution: workspace`
- [ ] Barrel export only exposes public API
- [ ] At least one test file exists in `test/`
- [ ] Package is listed in root `pubspec.yaml` workspace
- [ ] Package is listed in `Makefile` PACKAGES variable
- [ ] `flutter pub get` succeeds at the workspace root
- [ ] `flutter analyze` passes with no issues
- [ ] `flutter test` passes in the new package directory
- [ ] CHANGELOG.md documents the initial release
- [ ] If re-exported from umbrella: dependency + export added to `packages/flutterish`

## Conventions

- **One widget/feature per package** — keep packages focused and small.
- **Accessibility first** — use `Semantics` widgets, provide labels, support keyboard navigation.
- **Golden tests** — for any visual widget, add golden tests under `test/goldens/`.
- **Theming** — expose an `InheritedTheme` subclass (see `StepperTheme` pattern in `flutterish_stepper`).
- **No platform-specific code** unless the package is explicitly platform-scoped.
- **Conventional commits** — use `feat(flutterish_<feature>): ...` for scoped commits.
