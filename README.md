# Weather App

A beautiful and user-friendly Flutter weather application that provides real-time weather information for Dar es Salaam, Tanzania. Built with Flutter, this app fetches data from the OpenWeatherMap API to display current weather conditions, hourly forecasts, and additional meteorological details.

## Features

- **Current Weather Display**: Shows temperature, weather description, and icon for the current conditions.
- **Hourly Forecast**: Displays a 5-day hourly weather forecast with time, temperature, and weather icons.
- **Additional Information**: Provides humidity, wind speed, and atmospheric pressure details.
- **Error Handling**: Graceful handling of network errors, timeouts, and API failures with user-friendly messages.
- **Refresh Functionality**: Manual refresh button to update weather data.
- **Dark Theme**: Modern dark theme for a sleek user experience.
- **Responsive Design**: Optimized for various screen sizes and orientations.

## Screenshots

<!-- Add screenshots here when available -->
*Screenshots will be added soon.*

## Prerequisites

Before running this project, make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.10.3 or later)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- An IDE such as [Visual Studio Code](https://code.visual.com/) or [Android Studio](https://developer.android.com/studio)
- A device or emulator for testing (Android/iOS simulator)

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/weatherapp.git
   cd weatherapp
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up API Key:**
   - Sign up for a free account at [OpenWeatherMap](https://openweathermap.org/api).
   - Obtain your API key from the dashboard.
   - Open `lib/secrets.dart` and replace the existing `openWeatherAPIkey` with your API key:
     ```dart
     const openWeatherAPIkey = 'your_api_key_here';
     ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Usage

- Launch the app on your device or emulator.
- The app will automatically fetch and display weather data for Dar es Salaam.
- Use the refresh button in the app bar to update the weather information.
- The app handles network issues gracefully and provides retry options.

## Dependencies

This project uses the following main dependencies:

- `http: ^1.6.0` - For making HTTP requests to the OpenWeatherMap API
- `intl: ^0.20.2` - For date and time formatting
- `cupertino_icons: ^1.0.8` - For iOS-style icons
- `flutter_lints: ^6.0.0` - For code linting and best practices

For a complete list of dependencies, see `pubspec.yaml`.

## Project Structure

```
lib/
├── main.dart              # App entry point
├── weather_screen.dart    # Main weather screen widget
├── additional_info_item.dart # Widget for displaying additional weather info
├── hourly_forecast_item.dart # Widget for hourly forecast items
└── secrets.dart           # API key configuration (keep secure!)
```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

Please ensure your code follows Flutter best practices and includes appropriate tests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Weather data provided by [OpenWeatherMap](https://openweathermap.org/)
- Built with [Flutter](https://flutter.dev/)
- Icons from [Material Design Icons](https://material.io/design/iconography/system-icons.html)

## Support

If you encounter any issues or have questions, please open an issue on GitHub or contact the maintainers.
