# 💸 Expense Tracker App

A clean, responsive, and functional Flutter application that helps users track their expenses and incomes with authentication and persistent data storage.

Built with:
- 📱 Flutter (UI)
- 🌐 Node.js (API backend)
- 💾 SharedPreferences (local auth token storage)
- 🌍 REST API communication via HTTP

---

## ✨ Features

- 🔐 Sign Up & Login with token-based authentication
- 🧾 Add new transactions (Income or Expense)
- 📊 Dashboard with animated balance display
- 📜 Infinite scroll transaction list with loader
- 🔁 Logout & token persistence
- 🌙 Responsive UI & swipe navigation

---

## 📦 Installation

### 1. Clone the repository

```bash
git clone https://github.com/your-username/expense_tracker_app.git
cd expense_tracker_app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run the app

```bash
flutter run
```

> ✅ Make sure your backend is running and accessible (see `.env` or change `lib/constants/api.dart`)

---

## 🧐 Project Structure

```
lib/
├── components/            # Reusable UI components like loaders, input fields
├── constants/             # API constants (base URL, endpoints)
├── models/                # Dart models (User, Transaction)
├── screens/               # App screens (Login, Signup, Dashboard, etc.)
├── services/              # API requests, token handling
├── utils/                 # Navigation, dialogs
├── widgets/               # UI building blocks (Forms, Lists)
└── main.dart              # Entry point + routes
```

---

## 📱 Screens

### 🏠 Initial Screen

- Auto-checks login token
- Redirects to `/dashboard` or `/login`

### 🔐 Login / Signup

- Form validation
- Username availability check
- SharedPreferences for token

### 📊 Dashboard

- Shows user info and balance
- Refresh & Add Transaction FABs
- Infinite loading transaction list

### ➕ Create Transaction

- Select `type` (Income or Expense)
- Add `value` and `message`
- Auto-updates balance & list

---

## 📡 API Endpoints Used

These are configured in `lib/constants/api.dart`:

- `GET /account` → Fetch user data
- `POST /login` → Login user
- `POST /signup` → Register user
- `GET /logout` → Logout & invalidate token
- `GET /check-token` → Validate auth token
- `GET /check-username?username=` → Check username availability
- `GET /transaction?page=` → Paginated transaction list
- `POST /transaction` → Create a new transaction

> Ensure the `baseUrl` is updated to point to your server or IP when testing on device.

---

## 🛠 Dependencies

```yaml
dependencies:
  flutter:
  http: ^1.3.0
  shared_preferences: ^2.5.3
  google_fonts: ^6.2.1
  visibility_detector: ^0.4.0+2
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_launcher_icons: ^0.14.3
  flutter_test:
  flutter_lints:
```

> App icon is set using [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)

---

## 🏗 Build APK / AAB

To build for release:

```bash
flutter build apk --release
```

Or AAB for Play Store:

```bash
flutter build appbundle --release
```

---

## 📁 APK Releases

APK files can be downloaded from [Releases](https://github.com/your-username/expense_tracker_app/releases)

---

## 🦪 Testing

- Includes form validations
- Custom UI states (loading, success, error)
- Backend failure handling

---

## 🙌 Credits

Created by **Masked Redhat** — as a solo project to manage expenses smartly and learn full-stack development.