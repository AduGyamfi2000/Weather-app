# Weather-app

A global weather application built with Dart and Flutter.

## Features

- Search weather for any city worldwide
- Display temperature, humidity, wind speed, pressure, and coordinates
- Includes quick access chips for popular global cities
- Minimal, responsive Material 3 UI

## Setup

1. Install Flutter: https://flutter.dev/docs/get-started/install
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Replace `YOUR_API_KEY` in `lib/weather_service.dart` with your OpenWeatherMap API key.
4. Run the app:
   ```bash
   flutter run
   ```

## Notes

- The app uses OpenWeatherMap's current weather API.
- For production use, move the API key to secure storage instead of keeping it in source.
