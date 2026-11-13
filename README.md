# praktikum_papb

Aplikasi Flutter praktikum PAPB: daftar post dari JSONPlaceholder, login/register dengan SQLite, dan GetX sebagai state & route manager.

## Build variant (flavor)

Aplikasi punya dua flavor Android:

| Flavor | Application ID                 | Nama app | Config               |
| ------ | ------------------------------ | -------- | -------------------- |
| `dev`  | `com.example.praktikum_papb.dev` | PAPB Dev | `config/dev.json`  |
| `prod` | `com.example.praktikum_papb`     | PAPB     | `config/prod.json` |

Karena application ID-nya berbeda, versi dev dan prod bisa terpasang bersamaan di satu perangkat.

Nilai per environment (`ENV`, `BASE_URL`, `DB_NAME`) ada di folder `config/` dan dibaca lewat `lib/config/app_config.dart`. Jangan simpan rahasia (API key, password) di file ini, karena nilainya ikut masuk ke dalam APK.

Selalu sertakan `--flavor` **dan** `--dart-define-from-file` dengan environment yang sama.

> Project ini memakai [FVM](https://fvm.app). Kalau tidak memakai FVM, hapus awalan `fvm` dari perintah di bawah.

### Run

Development:

```bash
fvm flutter run --flavor dev --dart-define-from-file=config/dev.json
```

Production:

```bash
fvm flutter run --flavor prod --dart-define-from-file=config/prod.json
```

Di VS Code, pilih konfigurasi **Dev (Debug)**, **Prod (Debug)**, atau **Prod (Profile)** di panel Run and Debug.

### Build

APK development:

```bash
fvm flutter build apk --flavor dev --dart-define-from-file=config/dev.json
```

APK production:

```bash
fvm flutter build apk --release --flavor prod --dart-define-from-file=config/prod.json
```

App Bundle production (untuk Play Store):

```bash
fvm flutter build appbundle --release --flavor prod --dart-define-from-file=config/prod.json
```

Hasil build ada di:

- APK: `build/app/outputs/flutter-apk/app-<flavor>-<mode>.apk`
- App Bundle: `build/app/outputs/bundle/<flavor>Release/app-<flavor>-release.aab`

> Saat ini build release masih ditandatangani dengan debug key. Sebelum upload ke Play Store, atur signing config sendiri di `android/app/build.gradle.kts`.
