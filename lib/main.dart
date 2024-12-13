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

import 'dart:async';

import 'package:arcane/arcane.dart';
import 'package:fast_log/fast_log.dart';
import 'package:foundry_launcher/screen/foundary.dart';
import 'package:foundry_launcher/service/preference_service.dart';
import 'package:foundry_launcher/service/user_service.dart';
import 'package:foundry_launcher/service/widgets_binding_service.dart';
import 'package:window_manager/window_manager.dart';
import 'package:serviced/serviced.dart';


void main() => runZonedGuarded(() async {
  PrecisionStopwatch t = PrecisionStopwatch.start();
    WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
    size: Size(920, 620),
    title: "Foundry",
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    minimumSize: Size(800, 620),
  );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  registerServices();
  await services().waitForStartup();
  runApp(const FoundryApplication());
  success("Startup completed in ${t.getMilliseconds().round()}ms");
}, onError);

void onError(Object e, StackTrace s) {
  error(e);
  error(s);
}


void registerServices() {
  // Core Services here
  services().register<WidgetsBindingService>(() => WidgetsBindingService(),
      lazy: false);
  services().register<PreferencesService>(() => PreferencesService(),
      lazy: false);
  services().register<UserService>(() => UserService());

}

