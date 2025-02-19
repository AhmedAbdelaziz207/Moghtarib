import 'dart:async';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static bool _settingsOpened =
      false; // Track if settings have already been opened

  static Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Handle cases where permission is permanently denied
    while (permission == LocationPermission.deniedForever) {
      if (!_settingsOpened) {
        _settingsOpened = true; // Mark settings as opened
        bool openedSettings = await Geolocator.openAppSettings();
        if (!openedSettings) {
          throw Exception('Failed to open app settings.');
        }
      }

      // Wait for 1 second before rechecking permissions
      await Future.delayed(const Duration(seconds: 1));

      // Recheck permissions after returning from settings
      permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.deniedForever) {
        _settingsOpened = false; // Reset flag if permission changes
        break;
      }
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied.');
    }

    // Get the current location
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  static Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

}
