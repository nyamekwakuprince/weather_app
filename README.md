# Weather App 🌦️

A weather application built with Flutter and Dart, designed to provide users with current weather conditions and forecasts for searched cities.

## Overview

The Weather App is a mobile application project focused on delivering a clean, intuitive, and responsive weather experience. The project uses Flutter for the user interface and is being developed to integrate live weather information from the Open-Meteo API.

## Key Features

- **Weather Dashboard:** A dedicated screen for presenting weather information.
- **City Search:** Search for a city to view its weather conditions.
- **Current Weather:** Display current temperature and weather conditions.
- **Weather Details:** Present supporting information such as humidity and wind speed.
- **Forecast:** Display forecast information in an easy-to-read layout.
- **Responsive Interface:** A clean layout designed to adapt to different screen sizes.
- **API Integration:** Retrieve weather information from the Open-Meteo API.

*Feature implementation is in progress. Features will be marked as completed after they have been implemented and tested.*

## Technology Stack

- **Flutter** — application UI and development framework
- **Dart** — programming language
- **Open-Meteo API** — planned weather data provider
- **Git and GitHub** — version control and project management
- **Visual Studio Code** — development environment

## Current Development Progress

### Phase 1 — User Interface
- Created the main weather screen.
- Added the city search field design.
- Created a weather information card.
- Added humidity and wind information layouts.
- Created a horizontal forecast layout.
- Built reusable widgets for weather details and forecast items.
- Applied styling, spacing, colours, and rounded corners.

**Current status:** Initial UI implemented. Weather values are currently sample data, and the search field is not yet connected to a weather service.

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK (included with Flutter)
- Visual Studio Code or another supported IDE
- Google Chrome for running the current web prototype

### Installation

1. Clone the repository.
2. Open the project directory in your terminal.
3. Install the project dependencies:

   `flutter pub get`

4. Run the application in Chrome:

   `flutter run -d chrome`

## Planned Improvements

- Implement functional city search.
- Integrate the Open-Meteo API.
- Parse API responses and display live weather data.
- Add loading indicators and error handling.
- Display real forecast information.
- Test the application and improve responsiveness.
- Complete project documentation and screenshots.

## Project Structure

- `lib/main.dart` — application entry point and current UI implementation
- `test/` — location for automated tests
- `pubspec.yaml` — project configuration and dependencies

## Development Approach

The application is being developed incrementally. Each phase focuses on a specific set of features, followed by testing, documentation, and a version-control checkpoint.

## Project Status

**In development** — initial interface implemented; live weather integration and functional search are pending.
