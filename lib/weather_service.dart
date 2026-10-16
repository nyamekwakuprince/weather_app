import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_models.dart';

class WeatherService {
  Future<Map<String, dynamic>?> getCityCoordinates(
    String cityName,
  ) async {
    final url = Uri.https(
      'geocoding-api.open-meteo.com',
      '/v1/search',
      {
        'name': cityName,
        'count': '1',
        'language': 'en',
        'format': 'json',
      },
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Could not search for this city.');
    }

    final data = jsonDecode(response.body)
        as Map<String, dynamic>;

    final results = data['results'] as List?;

    if (results == null || results.isEmpty) {
      return null;
    }

    final city = results.first as Map<String, dynamic>;

    return {
      'name': city['name'],
      'country': city['country'],
      'latitude': city['latitude'],
      'longitude': city['longitude'],
    };
  }

  Future<WeatherData> getWeather(double latitude, double longitude) async {
    final url = Uri.https(
      'api.open-meteo.com',
      '/v1/forecast',
      {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current':
            'temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m',
        'hourly': 'temperature_2m,weather_code',
        'timezone': 'auto',
        'forecast_hours': '12',
      },
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Could not load weather data.');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return WeatherData.fromJson(data);
  }
}