# Weather App

A Flutter weather app that lets you search for a city and see its live weather conditions and the forecast for the next 12 hours. Built with Flutter and Dart, using the free Open-Meteo API.

## Features

- Search for any city by name
- Current temperature, weather condition, humidity and wind speed
- Hourly forecast for the next 12 hours
- Weather icons that match the conditions
- Loading indicator while data is being fetched
- Friendly messages when a city is not found or the internet request fails

## How it works

1. The user types a city name and presses Enter.
2. The app sends the name to the Open-Meteo **geocoding API**, which returns the city's coordinates.
3. The app sends those coordinates to the Open-Meteo **forecast API**, which returns the weather as JSON.
4. The JSON is converted into Dart classes (`WeatherData`, `HourlyForecast`).
5. The screen updates with the real values.

## Technology

- **Flutter** and **Dart** for the app and interface
- **Open-Meteo API** for geocoding and weather data (free, no API key needed)
- **http** package for internet requests
- **Git and GitHub** for version control
- **Visual Studio Code** for development

## Project structure

```
lib/
  main.dart             The screen, search field and forecast widgets
  weather_service.dart  Talks to the Open-Meteo APIs
  weather_models.dart   Dart classes that hold the weather data
  weather_codes.dart    Turns weather codes into descriptions and icons
tool/
  test_city_lookup.dart Terminal test for the city lookup
  test_weather.dart     Terminal test for the weather request
```

## Running the app

You need the Flutter SDK installed.

```
flutter pub get
flutter run -d chrome
```

## Current status

- Tested in Google Chrome.
- Not yet tested on an Android emulator or a physical phone.

## Known limitations

- If several cities share a name, the app uses the first match from the search.
- The forecast covers the next 12 hours only. There is no multi-day forecast yet.
- Temperatures are shown in degrees Celsius and wind speed in km/h.

## Possible improvements

- Multi-day forecast
- Choose between Celsius and Fahrenheit
- Remember the last searched city
- Automated tests for the weather service and screen

## Credits

Weather data by [Open-Meteo.com](https://open-meteo.com/).