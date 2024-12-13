import 'package:serviced/serviced.dart';
import 'dart:io' show Platform;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user_settings.dart';

class UserPreferencesService extends Service {
  static const String _settingsKey = 'user_settings';
  SharedPreferences? _prefs;
  UserSettings? _currentSettings;

  // Getters for easy access to current settings
  UserSettings get settings => _currentSettings ?? UserSettings();
  String? get theme => settings.theme;
  bool get highContrast => settings.highContrast;

  @override
  Future<void> onStart() async {
    _prefs = await SharedPreferences.getInstance();

    // Print SharedPreferences file location
    if (Platform.isAndroid) {
      final dir = await getApplicationDocumentsDirectory();
      print('SharedPreferences location (Android): ${dir.path}/shared_prefs/');
    } else if (Platform.isIOS) {
      final dir = await getApplicationSupportDirectory();
      print('SharedPreferences location (iOS): ${dir.path}');
    } else if (Platform.isLinux || Platform.isMacOS) {
      final dir = await getApplicationSupportDirectory();
      print('SharedPreferences location (Desktop): ${dir.path}');
    }

    await _loadSettings();
    _printCurrentSettings();
  }

  Future<void> _loadSettings() async {
    final String? savedSettings = _prefs?.getString(_settingsKey);
    if (savedSettings != null) {
      try {
        _currentSettings = UserSettingsMapper.fromJson(savedSettings);
        print('Loaded existing settings: $savedSettings');
      } catch (e) {
        print('Error loading settings: $e');
        _createDefaults();
      }
    } else {
      print('No existing settings found. Creating defaults...');
      _createDefaults();
    }
  }

  void _createDefaults() {
    _currentSettings = UserSettings(
      theme: 'light', // Default theme
      highContrast: false, // Default high contrast setting
    );
    // Save the defaults
    saveSettings(_currentSettings!);
    print('Created default settings');
  }

  void _printCurrentSettings() {
    print('Current Settings:');
    print('Theme: ${settings.theme}');
    print('High Contrast: ${settings.highContrast}');
  }

  Future<void> saveSettings(UserSettings settings) async {
    if (_prefs == null) return;

    try {
      final String jsonSettings = settings.toJson();
      await _prefs?.setString(_settingsKey, jsonSettings);
      _currentSettings = settings;
      print('Saved settings: $jsonSettings');
      _printCurrentSettings();
    } catch (e) {
      print('Error saving settings: $e');
    }
  }

  Future<void> updateTheme(String? theme) async {
    print('Updating theme to: $theme');
    final newSettings = settings.copyWith(theme: theme);
    await saveSettings(newSettings);
  }

  Future<void> updateHighContrast(bool highContrast) async {
    print('Updating high contrast to: $highContrast');
    final newSettings = settings.copyWith(highContrast: highContrast);
    await saveSettings(newSettings);
  }

  @override
  void onStop() {
    print('Stopping PreferencesService');
    _prefs = null;
    _currentSettings = null;
  }
}