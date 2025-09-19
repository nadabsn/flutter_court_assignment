import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _bookingsKey = 'saved_bookings';

  // Singleton instance
  static final LocalStorageService _instance = LocalStorageService._internal();

  // Factory constructor to return the singleton instance
  factory LocalStorageService() => _instance;

  // Private constructor for singleton
  LocalStorageService._internal();

  // SharedPreferences instance to be used across all methods
  late SharedPreferences _prefs;

  // Initialization flag to track if _prefs has been initialized
  bool _isInitialized = false;

  // Initialize shared preferences
  Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  // Ensures _prefs is initialized before use
  Future<SharedPreferences> _getPrefs() async {
    if (!_isInitialized) {
      await init();
    }
    return _prefs;
  }

  // Booking management
  Future<void> setBookings(List<String> bookings) async {
    final prefs = await _getPrefs();
    await prefs.setStringList(_bookingsKey, bookings);
  }

  Future<List<String>?> getBookings() async {
    final prefs = await _getPrefs();
    return prefs.getStringList(_bookingsKey);
  }

  // Token management
  Future<void> setToken(String token) async {
    final prefs = await _getPrefs();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final prefs = await _getPrefs();
    return prefs.getString('token');
  }

  // Clear all stored data
  Future<void> clear() async {
    final prefs = await _getPrefs();
    await prefs.clear();
  }
}
