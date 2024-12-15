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
        background: const Color(0xFFF1F1F1),
        foreground: const Color(0xFF303030),
        card: const Color(0xFFF1F1F1),
        cardForeground: const Color(0xFF303030),
        popover: const Color(0xFFFFFFFF),
        popoverForeground: const Color(0xFF2F2F2F),
        primary: const Color(0xFFFF8900),
        primaryForeground: const Color(0xFFFBFBFB),
        secondary: const Color(0xFFD2D2D2),
        secondaryForeground: const Color(0xFF303030),
        muted: const Color(0xFFD9D9D9),
        mutedForeground: const Color(0xFF6C6C6C),
        accent: const Color(0xFFF4F4F4),
        accentForeground: const Color(0xFF3D3D3D),
        destructive: const Color(0xFFAC2626),
        destructiveForeground: const Color(0xFFFAF8F4),
        border: const Color(0xFFD7D7D7),
        input: const Color(0xFFF1F1F1),
        ring: const Color(0xFFFF8900),
        chart1: const Color(0xFFE8E8E8),
        chart2: const Color(0xFFD6D6D6),
        chart3: const Color(0xFFA0A0A0),
        chart4: const Color(0xFF939393),
        chart5: const Color(0xFF585858),
      ),
      dark: ColorScheme(
        brightness: Brightness.dark,
        background: const Color(0xFF0D0A09),
        foreground: const Color(0xFFF2EFE8),
        card: const Color(0xFF0D0A09),
        cardForeground: const Color(0xFFFAF8F4),
        popover: const Color(0xFF0D0A09),
        popoverForeground: const Color(0xFFFAF8F4),
        primary: const Color(0xFFFF8900),
        primaryForeground: const Color(0xFF000000),
        secondary: const Color(0xFF323232),
        secondaryForeground: const Color(0xFFF8F8F8),
        muted: const Color(0xFF303030),
        mutedForeground: const Color(0xFF959595),
        accent: const Color(0xFFF4F4F4),
        accentForeground: const Color(0xFFFAF8F4),
        destructive: const Color(0xFF8C2626),
        destructiveForeground: const Color(0xFFFAF8F4),
        border: const Color(0xFF343434),
        input: const Color(0xFF303030),
        ring: const Color(0xFFFF8900),
        chart1: const Color(0xFFE8E8E8),
        chart2: const Color(0xFFD6D6D6),
        chart3: const Color(0xFFA0A0A0),
        chart4: const Color(0xFF939393),
        chart5: const Color(0xFF585858),
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
        primaryForeground: standardScheme.light.primaryForeground,
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
        primaryForeground: standardScheme.dark.primaryForeground,
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
