
import 'package:weather_app/weather_service.dart';

Future<void> main() async {
  print('Test started: searching for Kumasi...');

  final service = WeatherService();

  try {
    final city = await service.getCityCoordinates('Kumasi');

    if (city == null) {
      print('No matching city was found.');
      return;
    }

    print('City lookup successful!');
    print('City: ${city['name']}, ${city['country']}');
    print('Latitude: ${city['latitude']}');
    print('Longitude: ${city['longitude']}');
  } catch (error) {
    print('City lookup failed: $error');
  }

  print('Test finished.');
}
