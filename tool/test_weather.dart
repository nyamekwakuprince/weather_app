import 'package:weather_app/weather_service.dart';

Future<void> main() async {
  print('Test started: loading weather for Kumasi...');

  final service = WeatherService();

  try {
    final city = await service.getCityCoordinates('Kumasi');
    if (city == null) {
      print('No matching city was found.');
      return;
    }

    final weather = await service.getWeather(
      (city['latitude'] as num).toDouble(),
      (city['longitude'] as num).toDouble(),
    );

    print('City: ${city['name']}, ${city['country']}');
    print('Temperature: ${weather.temperature} °C');
    print('Humidity: ${weather.humidity}%');
    print('Wind: ${weather.windSpeed} km/h');
    print('Weather code: ${weather.weatherCode}');
    print('Hourly entries: ${weather.hourly.length}');
    print('First hour: ${weather.hourly.first.time} -> '
        '${weather.hourly.first.temperature} °C');
  } catch (error) {
    print('Weather test failed: $error');
  }

  print('Test finished.');
}