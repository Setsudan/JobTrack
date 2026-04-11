# 🕵️‍♂️ JobTrack (Offline Job Application Manager)

> Part of my **1 App Per Month** challenge. Built with Flutter. 100% Open Source. 100% Offline.

Job hunting is stressful enough without worrying about cloud subscriptions, privacy policies, or clunky mobile Kanban boards. JobTrack is an inbox-style mobile CRM built specifically for your job search. Your data stays on your device, your application pipeline stays organized, and you never miss a follow-up.

## ✨ Features

### 🚀 MVP (Current)

  * **Inbox-Style Pipeline:** No more horizontal scrolling. View your applications in a clean, scannable vertical list.
  * **Power-Swipes:** Swipe left or right on job cards to quickly update their status via customizable actions (e.g., swipe right for *Next Stage*, left for *Rejected*).
  * **Bottom Sheet Details:** Tap a card to pull up a smooth `DraggableScrollableSheet` containing job details, links, and notes without jarring page transitions.
  * **Local Reminders:** Completely local push notifications. Automatically get nudged to follow up if a job has been sitting in the "Applied" state for too long.
  * **CSV Import:** Don't start from scratch. Easily import your existing Google Sheet or Excel tracker directly into the local database to pick up right where you left off.

### 🗺️ Roadmap (Coming Soon)

  * **Cover Letter Generator:** A local templating engine. Save a master template with `{{Variables}}` and instantly generate tailored cover letters for specific job cards.
  * **Analytics Dashboard:** Visualize your job funnel (Applied -\> Interview -\> Offer) and response rates.
  * **Interview Prep Hub:** A dedicated STAR-method scratchpad attached to each job application.

## 🛠️ Tech Stack

  * **Framework:** [Flutter](https://flutter.dev/)
  * **Local Database:** [Isar](https://isar.dev/) (on-device NoSQL; job applications, settings, profile metadata, and notification bookkeeping). Existing installs are upgraded once from legacy `SharedPreferences` JSON via a startup migration.
  * **Notifications:** `flutter_local_notifications` (No Firebase or cloud required)
  * **Data Parsing:** `csv` (For offline spreadsheet importing)

## 🔒 The 100% Offline Promise

Your career data is your business. This app makes **zero** network requests. There is no cloud backend, no telemetry, and no required accounts. Everything is stored locally on your device (Isar database under the app documents directory), and you can export your data to JSON/CSV at any time for total peace of mind.

After changing Isar entity definitions, regenerate code with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Widget and integration-style tests download the Isar core binary once via `test/flutter_test_config.dart`; Isar disk access from `testWidgets` bodies is wrapped in `WidgetTester.runAsync` where needed.

## 📱 Getting Started

### Prerequisites

  * Flutter SDK
  * Dart SDK
  * iOS Simulator, Android Emulator, or a physical device

### Installation

1.  Clone the repo:
    ```bash
    git clone https://github.com/YourUsername/jobtrack.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd jobtrack
    ```
3.  Install dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the app:
    ```bash
    flutter run
    ```

## 🤝 Contributing

Since this is part of a 1-app-per-month challenge, the core structure was built fast\! Pull requests for bug fixes, new features (like the Cover Letter Generator), or UI tweaks are highly welcome.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.