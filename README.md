# Taskly

A feature-rich Flutter task management application for organizing daily tasks with categories, priorities, deadlines, and sub-tasks. Built with Clean Architecture and GetX.

## Features

- **Task Management** — Create, update, complete, and delete tasks with titles, descriptions, and deadlines
- **Sub-tasks** — Break down tasks into smaller sub-tasks with individual completion tracking
- **Categories** — Organize tasks into custom categories (work, life, etc.)
- **Priority Levels** — Low (green), Medium (orange), and High (red) priority tagging
- **Progress Tracking** — Visual progress bar per task based on sub-task completion
- **Local Push Notifications** — Background notification scheduling for tasks due within 24 hours
- **Search & Filter** — Search tasks and filter by category
- **Bilingual** — Full English and Arabic localization
- **Animated UI** — Wave header, gradient bottom nav, skeleton loading, Lottie empty states

## Screenshots

_(Add screenshots here)_

## Architecture

Clean Architecture with three layers:

```
lib/
├── core/              # Shared utilities, DI, database, notifications
│   ├── database/      # SQLite schema & migrations
│   ├── notification/  # local notifications & background scheduler
│   └── controller/    # Base GetX controllers
├── features/
│   └── tasks/         # Task management feature
│       ├── data/      # Models, data sources, repo implementation
│       ├── domain/    # Entities, repository interface, use cases
│       └── presentation/  # Controllers, screens, widgets
└── l10n/              # Localization files (en/ar)
```

- **State Management:** GetX (reactive `.obs`, `Obx`, dependency injection)
- **Persistence:** SQLite via `sqflite` with manual migrations
- **Error Handling:** `dartz` `Either<Failure, Success>` pattern
- **DI:** GetX Bindings + `get_it`

## Tech Stack

| Package | Purpose |
|---|---|
| `flutter` | UI framework |
| `get` | State management & DI |
| `sqflite` | Local database |
| `dartz` | Functional error handling |
| `flutter_local_notifications` | Push notifications |
| `workmanager` | Background task scheduling |
| `lottie` | Animations |
| `skeletonizer` | Loading shimmer |
| `scrollable_positioned_list` | Efficient task list |
| `flutter_localizations` + `intl` | i18n (en/ar) |

## Getting Started

### Prerequisites

- Flutter SDK ^3.9.2
- Dart SDK ^3.9.2

### Installation

```bash
git clone https://github.com/yourusername/tasks_manager.git
cd tasks_manager
flutter pub get
flutter run
```

### Build

```bash
flutter build apk        # Android
flutter build ios        # iOS
flutter build web        # Web
flutter build windows    # Windows
```

## Project Status

- [x] Task CRUD with sub-tasks
- [x] Categories and priorities
- [x] Local notifications
- [x] Bilingual support (EN/AR)
- [x] Search & category filter
- [ ] Task editing UI
- [ ] Analytics screen
- [ ] Tests

## License

MIT
