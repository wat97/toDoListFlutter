# Changelog

All notable changes to this project will be documented in this file.

## [1.0.1+5] - 2025-06-05
### Added
- Responsive and modern web UI for Home, Splash, and Add Task pages.
- Platform-safe Hive initialization for web (no more path_provider errors on web).
- App icons and Play Store assets (SVG/PNG) generated and configured.
- Automated GitHub Actions workflow for secure build, sign, and release (APK/AAB) with keystore from secrets.
- English and Indonesian project descriptions and release notes.
- In-app update support for Android using the `in_app_update` package (checks Play Store and prompts user).
- Platform-safe update helper (conditional import) to detect Android without breaking web builds.

### Changed
- Improved "Tambah Tugas" button and Add Task form for web/desktop experience.
- Home page and splash screen now use card layout and adapt to screen size.
- Splash screen now checks Play Store for available updates on Android before navigating to Home.

### Fixed
- AndroidManifest.xml and keystore workflow issues.
- Web build now works without path_provider errors.

### Notes (Catatan)
- Web: Penyimpanan data menggunakan Hive, sudah aman untuk web.
- Android/iOS: Build dan release otomatis via GitHub Actions.
- Semua tampilan sudah responsif dan nyaman di desktop/mobile/web.
 - In-app update: Fitur update dalam aplikasi bekerja hanya pada Android dan memerlukan aplikasi yang telah di-publish di Google Play (internal testing atau track lainnya) untuk dapat diuji.
 - Pada web dan iOS, pemeriksaan update akan diabaikan (no-op).
