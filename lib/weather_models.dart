class HourlyForecast {
  final DateTime time;
  final double temperature;
  final int weatherCode;

  const HourlyForecast({
    required this.time,
    required this.temperature,
    required this.weatherCode,
  });
}

class WeatherData {
  final double temperature;
  final int humidity;
  final double windSpeed;
  final int weatherCode;
  final List<HourlyForecast> hourly;

  const WeatherData({
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.weatherCode,
    required this.hourly,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    final hourly = json['hourly'] as Map<String, dynamic>;

    final times = hourly['time'] as List;
    final temps = hourly['temperature_2m'] as List;
    final codes = hourly['weather_code'] as List;

    return WeatherData(
      temperature: (current['temperature_2m'] as num).toDouble(),
      humidity: (current['relative_humidity_2m'] as num).round(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      weatherCode: (current['weather_code'] as num).toInt(),
      hourly: List.generate(times.length, (i) {
        return HourlyForecast(
          time: DateTime.parse(times[i] as String),
          temperature: (temps[i] as num).toDouble(),
          weatherCode: (codes[i] as num).toInt(),
        );
      }),
    );
  }
}