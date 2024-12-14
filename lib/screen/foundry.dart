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
import 'dart:ui';

import 'package:arcane/arcane.dart';
import 'package:fast_log/fast_log.dart';
import 'package:foundry_launcher/screen/project_manager.dart';
import 'package:foundry_launcher/service/preference_service.dart';
import 'package:foundry_launcher/service/widgets_binding_service.dart';
import 'package:serviced/serviced.dart';

import '../util/imports.dart';
import '../util/magic.dart';

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
  late StreamSubscription _updateSubscription;

  @override
  void initState() {
    super.initState();
    _updateSubscription = appUpdateStream.listen((_) {
      setState(() {
        _initializeTheme();
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeTheme();
    });
    svc<WidgetsBindingService>().dropSplash();
  }

  @override
  void dispose() {
    _updateSubscription.cancel();
    super.dispose();
  }

  void _initializeTheme() {
    try {
      PreferencesService prefsService = services().get<PreferencesService>();
      ArcaneTheme theme = buildTheme(isLight: prefsService.settings.theme);
      Arcane.app.setTheme(theme);
      verbose("Theme initialized: ${prefsService.settings.theme ? 'light' : 'dark'}");
      setState(() {});
    } catch (e, stack) {
      error("Failed to initialize theme");
      error(e);
      error(stack);
    }
  }

  static ArcaneTheme buildTheme(
      {required bool isLight, ContrastedColorScheme? scheme}) {
    return FoundryTheme(
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
      scheme: scheme ?? _FoundryColors.foundryOrange(),
    );
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
      home: FoundryProjectManager(),
      theme: buildTheme(isLight: prefsService.settings.theme),
    );
  }
}

class _FoundryColors {
  static ContrastedColorScheme foundryOrange() {
    final prefsService = services().get<PreferencesService>();
    final bool isHighContrast = prefsService.settings.highContrast;
    final standardScheme = ContrastedColorScheme(
      light: ColorScheme(
        brightness: Brightness.light,
        background: const HSLColor.fromAHSL(1, 30.0, 0.1, 0.95).toColor(),
        foreground: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.1).toColor(),
        card: const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        cardForeground: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.1).toColor(),
        popover: const HSLColor.fromAHSL(1, 30.0, 0.1, 1.0).toColor(),
        popoverForeground: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.1).toColor(),
        primary: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.5).toColor(),
        primaryForeground:
            const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        secondary: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.85).toColor(),
        secondaryForeground:
            const HSLColor.fromAHSL(1, 30.0, 0.8, 0.1).toColor(),
        muted: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.8).toColor(),
        mutedForeground: const HSLColor.fromAHSL(1, 30.0, 0.25, 0.4).toColor(),
        accent: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.65).toColor(),
        accentForeground: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.1).toColor(),
        destructive: const HSLColor.fromAHSL(1, 0.0, 0.84, 0.6).toColor(),
        destructiveForeground:
            const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        border: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.7).toColor(),
        input: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.9).toColor(),
        ring: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.5).toColor(),
        chart1: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.5).toColor(),
        chart2: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.2).toColor(),
        chart3: const HSLColor.fromAHSL(1, 15.0, 0.75, 0.6).toColor(),
        chart4: const HSLColor.fromAHSL(1, 40.0, 0.85, 0.4).toColor(),
        chart5:
            const HSLColor.fromAHSL(1, 5.0, 0.9, 0.5).toColor(), // Red-orange
      ),
      dark: ColorScheme(
        brightness: Brightness.dark,
        background: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.05).toColor(),
        foreground: const HSLColor.fromAHSL(1, 30.0, 0.1, 0.95).toColor(),
        card: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.05).toColor(),
        cardForeground: const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        popover: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.05).toColor(),
        popoverForeground:
            const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        primary: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.5).toColor(),
        primaryForeground: const HSLColor.fromAHSL(1, 30.0, 0.8, 0.1).toColor(),
        secondary: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.2).toColor(),
        secondaryForeground:
            const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        muted: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.2).toColor(),
        mutedForeground: const HSLColor.fromAHSL(1, 30.0, 0.1, 0.7).toColor(),
        accent: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.65).toColor(),
        accentForeground: const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        destructive: const HSLColor.fromAHSL(1, 0.0, 0.7, 0.4).toColor(),
        destructiveForeground:
            const HSLColor.fromAHSL(1, 30.0, 0.1, 0.98).toColor(),
        border: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.2).toColor(),
        input: const HSLColor.fromAHSL(1, 30.0, 0.15, 0.2).toColor(),
        ring: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.5).toColor(),
        chart1: const HSLColor.fromAHSL(1, 24.0, 0.95, 0.6).toColor(),
        chart2: const HSLColor.fromAHSL(1, 15.0, 0.85, 0.5).toColor(),
        chart3: const HSLColor.fromAHSL(1, 35.0, 0.9, 0.4).toColor(),
        chart4: const HSLColor.fromAHSL(1, 5.0, 0.8, 0.5).toColor(),
        chart5: const HSLColor.fromAHSL(1, 45.0, 0.75, 0.55).toColor(),
      ),
    );

    final oledScheme = ContrastedColorScheme(
      light: ColorScheme(
        brightness: Brightness.light,
        background: Colors.white,
        foreground: Colors.black,
        card: Colors.white,
        cardForeground: Colors.black,
        popover: Colors.white,
        popoverForeground: Colors.black,
        primary: standardScheme.light.primary,
        primaryForeground: Colors.black,
        secondary: const Color(0xFFF5F5F5),
        secondaryForeground: Colors.black,
        muted: const Color(0xFFEEEEEE),
        mutedForeground: const Color(0xFF242424),
        accent: standardScheme.light.accent,
        accentForeground: Colors.black,
        destructive: standardScheme.light.destructive,
        destructiveForeground: Colors.white,
        border: const Color(0xFFDDDDDD),
        input: const Color(0xFFF5F5F5),
        ring: standardScheme.light.primary,
        chart1: standardScheme.light.chart1,
        chart2: standardScheme.light.chart2,
        chart3: standardScheme.light.chart3,
        chart4: standardScheme.light.chart4,
        chart5: standardScheme.light.chart5,
      ),
      dark: ColorScheme(
        brightness: Brightness.dark,
        background: Colors.black,
        foreground: Colors.white,
        card: Colors.black,
        cardForeground: Colors.white,
        popover: Colors.black,
        popoverForeground: Colors.white,
        primary: standardScheme.dark.primary,
        primaryForeground: Colors.black,
        secondary: const Color(0xFF252525),
        secondaryForeground: Colors.white,
        muted: const Color(0xFF3D3D3D),
        mutedForeground: const Color(0xFFEEEEEE),
        accent: standardScheme.dark.accent,
        accentForeground: Colors.white,
        destructive: standardScheme.dark.destructive,
        destructiveForeground: Colors.white,
        border: const Color(0xFF333333),
        input: const Color(0xFF111111),
        ring: standardScheme.dark.primary,
        chart1: standardScheme.dark.chart1,
        chart2: standardScheme.dark.chart2,
        chart3: standardScheme.dark.chart3,
        chart4: standardScheme.dark.chart4,
        chart5: standardScheme.dark.chart5,
      ),
    );

    return isHighContrast ? oledScheme : standardScheme;
  }
}
