/*
 * Foundry is a Configuration and Testing tool for Minecraft Servers,
 * Data and Resource Packs.
 *
 * Copyright (c) 2025 Aidan Aeternum LLC (Volmit Software)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:serviced/serviced.dart';
import 'package:fast_log/fast_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user_settings.dart';

class PreferencesService extends Service {
  static const String _settingsKey = 'user_settings';
  SharedPreferences? _prefs;
  UserSettings? _currentSettings;

  // Direct access to current settings
  UserSettings get settings => _currentSettings ?? UserSettings();

  @override
  Future<void> onStart() async {
    verbose("Starting PreferencesService");
    _prefs = await SharedPreferences.getInstance();
    await _loadSettings();
  }

  Future<void> _loadSettings() async {
    final String? savedSettings = _prefs?.getString(_settingsKey);
    if (savedSettings != null) {
      try {
        _currentSettings = UserSettingsMapper.fromJson(savedSettings);
        verbose("Loaded settings: ${_currentSettings?.toJson()}");
      } catch (e, stack) {
        error("Failed to load settings");
        error(e);
        error(stack);
        _createDefaults();
      }
    } else {
      verbose("No settings found, creating defaults");
      _createDefaults();
    }
  }

  void _createDefaults() {
    _currentSettings = UserSettings(
      theme: false, // false = dark theme
      highContrast: false, // false = normal contrast
    );
    saveSettings(_currentSettings!);
    verbose("Created default settings");
  }

  Future<void> saveSettings(UserSettings settings) async {
    if (_prefs == null) {
      error("Tried to save settings before preferences was initialized");
      return;
    }

    try {
      final String jsonSettings = settings.toJson();
      await _prefs?.setString(_settingsKey, jsonSettings);
      _currentSettings = settings;
      verbose("Saved settings: $jsonSettings");
    } catch (e, stack) {
      error("Failed to save settings");
      error(e);
      error(stack);
    }
  }

  @override
  void onStop() {
    verbose("Stopping PreferencesService");
    _prefs = null;
    _currentSettings = null;
  }
}