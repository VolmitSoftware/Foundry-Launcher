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

import 'package:foundry_launcher/data/user_settings.dart';
import 'package:foundry_launcher/screen/foundary.dart';
import 'package:foundry_launcher/service/preference_service.dart';
import 'package:foundry_launcher/util/magic.dart';
import 'package:serviced/serviced.dart';
import 'package:fast_log/fast_log.dart';


class UserService extends StatelessService {
  UserSettings _settings = UserSettings();

  UserSettings get settings => _settings;

  @override
  Future<void> onStart() async {
    verbose("Starting UserService");
    try {
      PreferencesService prefsService = services().get<PreferencesService>();
      _settings = prefsService.settings;
      verbose("Initial settings loaded");
      verbose("Theme = ${_settings.theme}");
      verbose("High Contrast = ${_settings.highContrast}");
    } catch (e, stack) {
      error("Failed to initialize UserService");
      error(e);
      error(stack);
    }
  }

  Future<void> updateSettings(UserSettings Function(UserSettings settings) updater) async {
    try {
      PreferencesService prefsService = services().get<PreferencesService>();
      UserSettings updatedSettings = updater(_settings);
      await prefsService.saveSettings(updatedSettings);
      _settings = updatedSettings;
      verbose("Settings updated through updater function");
    } catch (e, stack) {
      error("Failed to update settings");
      error(e);
      error(stack);
    }
  }

  @override
  void onStop() {
    verbose("Stopping UserService");
  }
}