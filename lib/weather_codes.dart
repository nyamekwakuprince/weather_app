import 'package:flutter/material.dart';

// Turns a weather code number into words.
String weatherDescription(int code) {
  return switch (code) {
    0 => 'Clear sky',
    1 => 'Mainly clear',
    2 => 'Partly cloudy',
    3 => 'Overcast',
    45 || 48 => 'Fog',
    51 || 53 || 55 => 'Drizzle',
    56 || 57 => 'Freezing drizzle',
    61 || 63 || 65 => 'Rain',
    66 || 67 => 'Freezing rain',
    71 || 73 || 75 || 77 => 'Snow',
    80 || 81 || 82 => 'Rain showers',
    85 || 86 => 'Snow showers',
    95 => 'Thunderstorm',
    96 || 99 => 'Thunderstorm with hail',
    _ => 'Unknown',
  };
}

// Turns a weather code number into an icon.
IconData weatherIcon(int code) {
  return switch (code) {
    0 || 1 => Icons.wb_sunny_rounded,
    2 => Icons.cloud_queue_rounded,
    3 => Icons.cloud_rounded,
    45 || 48 => Icons.blur_on,
    51 || 53 || 55 || 56 || 57 => Icons.grain,
    61 || 63 || 65 || 66 || 67 || 80 || 81 || 82 => Icons.water_drop,
    71 || 73 || 75 || 77 || 85 || 86 => Icons.ac_unit,
    95 || 96 || 99 => Icons.flash_on,
    _ => Icons.cloud_rounded,
  };
}