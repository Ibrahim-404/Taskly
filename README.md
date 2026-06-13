# Taskly

> A premium Flutter task management app with an iOS-inspired design, built with Clean Architecture and GetX.

## Features

- **Task Management** — Full CRUD with title, description, deadline, priority (Low/Medium/High), and sub-tasks
- **Sub-tasks** — Expandable per-task list with individual progress tracking
- **Categories** — Custom categories with color coding
- **Deadline Extension** — One-time extension per task with visual badge and history
- **Search & Filter** — Real-time search + category + status (Done/Overdue/Today/Upcoming) filters
- **Local Notifications** — Background-scheduled reminders for tasks due within 24 hours; permission-aware (Android 13+ / iOS)
- **Analytics Dashboard** — Beautiful charts: task completion trend, category distribution, priority breakdown, overdue rate
- **Profile & Settings** — Avatar with camera/gallery picker, editable name & email, account stats
- **Theme Modes** — Light / Dark / System with persisted preference
- **Bilingual** — Full English and Arabic (RTL) localization
- **Animated UI** — Wave gradient header, skeleton loading, Lottie empty states, smooth transitions

## Screenshots

| | | |
|---|---|---|
| Home | Analytics | Profile |
| _Add screenshot_ | _Add screenshot_ | _Add screenshot_ |

## Architecture

Clean Architecture with strict layer separation:

```
lib/
├── core/
│   ├── controller/          # Base GetX controllers, ThemeController
│   ├── database/            # SQLite schema & migrations (v1–v5)
│   ├── notification/        # Local notifications & background scheduler
│   ├── theme/               # iOS-inspired ThemeData, gradients, component themes
│   ├── const/               # App strings
│   └── enums/               # ViewState, TaskFilter, Priority
├── features/
│   ├── analysis/            # Analytics dashboard (fl_chart)
│   ├── profile/             # Profile & settings (avatar, name, email, theme, notifications)
│   ├── search/              # Search screen with filters
│   └── tasks/               # Task management (CRUD, categories, deadlines, sub-tasks)
│       ├── data/            # Models, data sources, repository implementation
│       ├── domain/          # Entities, repository interface, use cases
│       └── presentation/    # Controllers, screens, widgets
└── l10n/                    # ARB localization files (en/ar)
```

- **State Management:** GetX (reactive `.obs`, `Obx`, `GetBuilder`, dependency injection)
- **Persistence:** SQLite via `sqflite` with manual migrations; `shared_preferences` for user settings
- **Error Handling:** `dartz` `Either<Failure, Success>` pattern
- **DI:** GetX `Bindings` + `get_it`

## Tech Stack

| Package | Purpose |
|---|---|
| `flutter` | UI framework |
| `get` | State management & DI |
| `sqflite` | Local SQLite database |
| `shared_preferences` | Key-value storage (profile, theme, prefs) |
| `dartz` | Functional error handling |
| `flutter_local_notifications` | Push notifications |
| `permission_handler` | Runtime permission requests |
| `workmanager` | Background notification scheduling |
| `lottie` | Animations & empty states |
| `skeletonizer` | Loading shimmer placeholders |
| `fl_chart` | Analytics charts |
| `image_picker` | Camera & gallery image selection |
| `scrollable_positioned_list` | Efficient scroll-to-task |
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

- [x] Task CRUD with sub-tasks, categories, priorities
- [x] Search & category filter
- [x] Deadline extension
- [x] Analytics dashboard with charts
- [x] Local notifications with background scheduling
- [x] Profile & settings (avatar, name, email, theme)
- [x] Light / Dark / System themes
- [x] Bilingual support (EN/AR)
- [x] iOS-inspired redesign
- [ ] Unit & widget tests
- [ ] Cloud sync
- [ ] Team collaboration
- [ ] AI productivity insights

## License

MIT
