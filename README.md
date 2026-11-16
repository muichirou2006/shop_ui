# shop_ui (connected to shop_api)

Flutter e-commerce UI (Material 3, Riverpod) that loads live data from the Shop API.

## 1. Start the API first
```bash
cd shop_api && npm run dev      # http://localhost:3000
```

## 2. Install and run the app
```bash
flutter pub get
flutter run
```

The base URL is chosen automatically:

| Where the app runs | Base URL used |
|---|---|
| Android emulator | `http://10.0.2.2:3000/api/v1` |
| iOS simulator | `http://localhost:3000/api/v1` |
| Real phone (same Wi-Fi) | pass your computer's IP: |

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.20:3000/api/v1
```

## 3. Platform settings (plain HTTP during development)

**Android** – `android/app/src/main/AndroidManifest.xml`
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET"/>
    <application
        android:usesCleartextTraffic="true"
        ...>
```

**iOS** – `ios/Runner/Info.plist` (inside the top-level `<dict>`)
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
</dict>
```
Use HTTPS and remove both of these for production.

## What talks to the API

| UI | Endpoint |
|---|---|
| Product grid, search, sort, category chips, infinite scroll | `GET /products?page&limit&q&category&sort` |
| Category chips | `GET /categories` |
| Product details (fresh price/stock/specs) | `GET /products/:id` |

Cart, profile, and the promo banners stay local (no endpoints for them yet).
