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

import 'package:arcane/arcane.dart';
import 'package:foundry_launcher/screen/home.dart';
import 'package:foundry_launcher/service/preference_service.dart';
import 'package:foundry_launcher/service/widgets_binding_service.dart';
import 'package:serviced/serviced.dart';
import 'package:fast_log/fast_log.dart';

import '../util/imports.dart';


class FoundryApplication extends StatefulWidget {
  const FoundryApplication({super.key});

  @override
  State<FoundryApplication> createState() => FoundryApplicationState();
}

class FoundryTheme extends ArcaneTheme {
  FoundryTheme({
    super.scheme,
    super.radius = 0.5,
    super.themeMode,
    super.surfaceBlur = 18,
    super.surfaceOpacity = 0.66,
  });
}

class FoundryApplicationState extends State<FoundryApplication> {
  @override
  void initState() {
    super.initState();
    // Delay the theme setup to ensure Arcane is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTheme();
    });
    svc<WidgetsBindingService>().dropSplash();
  }

  void _initializeTheme() {
    try {
      PreferencesService prefsService = services().get<PreferencesService>();
      ArcaneTheme theme = buildTheme(isLight: prefsService.settings.theme);
      Arcane.app.setTheme(theme);
      verbose("Theme initialized: ${prefsService.settings.theme ? 'light' : 'dark'}");
    } catch (e, stack) {
      error("Failed to initialize theme");
      error(e);
      error(stack);
    }
  }

  static ArcaneTheme buildTheme({required bool isLight}) {
    return FoundryTheme(themeMode: isLight ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    PreferencesService prefsService = services().get<PreferencesService>();

    return ArcaneApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
      ],
      title: 'Foundry Launcher',
      home: FoundaryRoot(),
      theme: buildTheme(isLight: prefsService.settings.theme),
    );
  }
}