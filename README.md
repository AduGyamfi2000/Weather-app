# Weather-app

A global weather application built with Dart and Flutter.

## Screenshots

### Default State
![App launch — search field and quick-access city chips](assets/screenshots/01_default_state.png)

### Loading State
![Fetching weather data — circular progress indicator](assets/screenshots/02_loading_state.png)

### Weather Results
![Live weather card showing temperature, humidity, wind speed, pressure and coordinates](assets/screenshots/03_weather_results.png)

### Error State
![Error handling — city not found and empty search validation](assets/screenshots/04_error_state.png)

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
