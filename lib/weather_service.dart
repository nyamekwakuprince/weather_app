
import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
