
import 'package:flutter/material.dart';

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
  String _cityName = 'Accra, Ghana';

  void _searchCity(String value) {
    final city = value.trim();
    if (city.isEmpty) return;

    setState(() {
      _cityName = city;
    });
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

              // Current weather card
              Container(
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
                        Text(
                          _cityName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const Center(
                      child: Icon(
                        Icons.wb_sunny_rounded,
                        color: Color(0xFFFFD166),
                        size: 90,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        '29°',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 68,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Sunny',
                        style: TextStyle(
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
                          value: '65%',
                        ),
                        WeatherDetail(
                          icon: Icons.air,
                          label: 'Wind',
                          value: '12 km/h',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Forecast section
              const Text(
                'Today’s Forecast',
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
                  children: const [
                    ForecastItem(
                      time: '12 PM',
                      icon: Icons.wb_sunny_rounded,
                      temperature: '30°',
                    ),
                    ForecastItem(
                      time: '1 PM',
                      icon: Icons.wb_sunny_rounded,
                      temperature: '31°',
                    ),
                    ForecastItem(
                      time: '2 PM',
                      icon: Icons.cloud_rounded,
                      temperature: '29°',
                    ),
                    ForecastItem(
                      time: '3 PM',
                      icon: Icons.cloud_queue_rounded,
                      temperature: '28°',
                    ),
                  ],
                ),
              ),
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
