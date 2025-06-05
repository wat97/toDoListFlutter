# Changelog

All notable changes to this project will be documented in this file.

## [1.0.1+5] - 2025-06-05
### Added
- Responsive and modern web UI for Home, Splash, and Add Task pages.
- Platform-safe Hive initialization for web (no more path_provider errors on web).
- App icons and Play Store assets (SVG/PNG) generated and configured.
- Automated GitHub Actions workflow for secure build, sign, and release (APK/AAB) with keystore from secrets.
- English and Indonesian project descriptions and release notes.

### Changed
- Improved "Tambah Tugas" button and Add Task form for web/desktop experience.
- Home page and splash screen now use card layout and adapt to screen size.

### Fixed
- AndroidManifest.xml and keystore workflow issues.
- Web build now works without path_provider errors.

### Notes (Catatan)
- Web: Penyimpanan data menggunakan Hive, sudah aman untuk web.
- Android/iOS: Build dan release otomatis via GitHub Actions.
- Semua tampilan sudah responsif dan nyaman di desktop/mobile/web.
