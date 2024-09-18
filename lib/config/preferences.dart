import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // Singleton pattern to ensure only one instance of Preferences is used
  static final Preferences _instance = Preferences._internal();
  factory Preferences() => _instance;
  Preferences._internal();

  SharedPreferences? _prefs;

  // Initialization method to load SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Method to save a string value
  Future<bool> setString(String key, String value) async {
    if (_prefs == null) await init();
    return _prefs!.setString(key, value);
  }

  // Method to get a string value
  String? getString(String key) {
    if (_prefs == null) return null;
    return _prefs!.getString(key);
  }

  // Method to save a boolean value
  Future<bool> setBool(String key, bool value) async {
    if (_prefs == null) await init();
    return _prefs!.setBool(key, value);
  }

  // Method to get a boolean value
  bool? getBool(String key) {
    if (_prefs == null) return null;
    return _prefs!.getBool(key);
  }

  // Method to save an integer value
  Future<bool> setInt(String key, int value) async {
    if (_prefs == null) await init();
    return _prefs!.setInt(key, value);
  }

  // Method to get an integer value
  int? getInt(String key) {
    if (_prefs == null) return null;
    return _prefs!.getInt(key);
  }

  // Method to save a double value
  Future<bool> setDouble(String key, double value) async {
    if (_prefs == null) await init();
    return _prefs!.setDouble(key, value);
  }

  // Method to get a double value
  double? getDouble(String key) {
    if (_prefs == null) return null;
    return _prefs!.getDouble(key);
  }

  // Method to remove a specific value
  Future<bool> remove(String key) async {
    if (_prefs == null) await init();
    return _prefs!.remove(key);
  }

  // Method to clear all stored values
  Future<bool> clear() async {
    if (_prefs == null) await init();
    return _prefs!.clear();
  }

  // Method to save default position
  Future<bool> setDefaultPosition(double latitude, double longitude) async {
    if (_prefs == null) await init();
    await _prefs!.setDouble('default_latitude', latitude);
    await _prefs!.setDouble('default_longitude', longitude);
    return true;
  }

  // Method to get default position
  LatLng? getDefaultPosition() {
    if (_prefs == null) return null;
    final double? lat = _prefs!.getDouble('default_latitude');
    final double? lng = _prefs!.getDouble('default_longitude');
    if (lat != null && lng != null) {
      return LatLng(lat, lng);
    } else {
      return null;
    }
  }
}
