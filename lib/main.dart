import 'package:flutter/material.dart';

import 'weather_codes.dart';
import 'weather_models.dart';
import 'weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final WeatherService _weatherService = WeatherService();

  String _cityName = '';
  WeatherData? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Load Accra's weather when the app opens.
    _searchCity('Accra');
  }

  Future<void> _searchCity(String value) async {
    final query = value.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final city = await _weatherService.getCityCoordinates(query);

      if (city == null) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _errorMessage =
              'City not found. Please check the spelling and try again.';
        });
        return;
      }

      final weather = await _weatherService.getWeather(
        (city['latitude'] as num).toDouble(),
        (city['longitude'] as num).toDouble(),
      );

      if (!mounted) return;
      setState(() {
        _cityName = '${city['name']}, ${city['country']}';
        _weather = weather;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Could not load the weather. Please check your internet connection and try again.';
      });
    }
  }

  String _formatHour(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final period = time.hour < 12 ? 'AM' : 'PM';
    return '$hour $period';
  }

  Widget _buildErrorBanner(String message) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFB91C1C)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF7F1D1D)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard(WeatherData weather) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF1D4ED8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white70,
                size: 20,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _cityName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Center(
            child: Icon(
              weatherIcon(weather.weatherCode),
              color: const Color(0xFFFFD166),
              size: 90,
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              '${weather.temperature.round()}\u00B0',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 68,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              weatherDescription(weather.weatherCode),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WeatherDetail(
                icon: Icons.water_drop_outlined,
                label: 'Humidity',
                value: '${weather.humidity}%',
              ),
              WeatherDetail(
                icon: Icons.air,
                label: 'Wind',
                value: '${weather.windSpeed.round()} km/h',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 60),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final weather = _weather;
    if (weather == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWeatherCard(weather),
        const SizedBox(height: 32),
        const Text(
          'Next 12 Hours',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xFF172554),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 145,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: weather.hourly.map((hour) {
              return ForecastItem(
                time: _formatHour(hour.time),
                icon: weatherIcon(hour.weatherCode),
                temperature: '${hour.temperature.round()}\u00B0',
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'WEATHER APP',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Welcome to My Weather App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172554),
                ),
              ),
              const SizedBox(height: 24),

              // City search field
              TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: _searchCity,
                decoration: InputDecoration(
                  hintText: 'Search location...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              if (_errorMessage != null) _buildErrorBanner(_errorMessage!),

              _buildContent(),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable widget for weather details
class WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetail({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

// Reusable widget for each forecast item
class ForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temperature;

  const ForecastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
            ),
          ),
          Icon(
            icon,
            color: const Color(0xFFF59E0B),
            size: 30,
          ),
          Text(
            temperature,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF172554),
            ),
          ),
        ],
      ),
    );
  }
}