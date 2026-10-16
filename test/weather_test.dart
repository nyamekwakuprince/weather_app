import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather_codes.dart';
import 'package:weather_app/weather_models.dart';

void main() {
  // A small sample, shaped like the real Open-Meteo answer.
  final Map<String, dynamic> sampleJson = {
    'current': {
      'temperature_2m': 22.8,
      'relative_humidity_2m': 99,
      'weather_code': 2,
      'wind_speed_10m': 1.8,
    },
    'hourly': {
      'time': ['2026-10-16T04:00', '2026-10-16T05:00'],
      // 23 is a whole number and 22.8 has a decimal, as in the real data.
      'temperature_2m': [23, 22.8],
      'weather_code': [2, 45],
    },
  };

  group('WeatherData.fromJson', () {
    test('reads the current weather', () {
      final weather = WeatherData.fromJson(sampleJson);

      expect(weather.temperature, 22.8);
      expect(weather.humidity, 99);
      expect(weather.windSpeed, 1.8);
      expect(weather.weatherCode, 2);
    });

    test('builds one forecast item for each hour', () {
      final weather = WeatherData.fromJson(sampleJson);

      expect(weather.hourly.length, 2);
      expect(weather.hourly.first.time, DateTime(2026, 10, 16, 4));
      expect(weather.hourly[1].weatherCode, 45);
    });

    test('accepts a whole number as a temperature', () {
      final weather = WeatherData.fromJson(sampleJson);

      expect(weather.hourly.first.temperature, 23.0);
    });
  });

  group('weather codes', () {
    test('known codes give a description', () {
      expect(weatherDescription(0), 'Clear sky');
      expect(weatherDescription(2), 'Partly cloudy');
      expect(weatherDescription(95), 'Thunderstorm');
    });

    test('an unknown code gives Unknown', () {
      expect(weatherDescription(12345), 'Unknown');
    });

    test('clear sky uses the sun icon', () {
      expect(weatherIcon(0), Icons.wb_sunny_rounded);
    });
  });
}