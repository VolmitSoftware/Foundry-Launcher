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
import 'package:foundry_launcher/service/user_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:serviced/serviced.dart';
import 'package:fast_log/fast_log.dart';

import '../../util/magic.dart';

BoolOption cfgAppearanceBrightness = BoolOption(
    name: "Dark Mode",
    icon: Icons.moon_stars,
    description: "This allows you to be cool, and have dark mode",
    defaultValue: UserService().settings.theme,
    reader: () => services().get<UserService>().settings.theme,
    writer: (value) async {
      try {
        UserService userService = services().get<UserService>();
        await userService.updateSettings((settings) =>
            settings.copyWith(theme: value ?? false)
        );
        updateApp();
      } catch (e, stack) {
        error("Failed to update theme");
        error(e);
        error(stack);
      }
    });

OptionGroup cfgAppearance = OptionGroup(
    name: "Appearance",
    icon: Icons.palette,
    description: "Customize the appearance of the ${_cfgPackageInfo.appName.lowerCamelCaseToUpperSpacedCase.replaceAll("_", " ")}",
    options: [
      cfgAppearanceBrightness,
    ]);

late PackageInfo _cfgPackageInfo;

InfoOption get cfgAboutFoundry => InfoOption(
    name: _cfgPackageInfo.appName.lowerCamelCaseToUpperSpacedCase.replaceAll("_", " "),
    icon: Icons.book,
    description: "v${_cfgPackageInfo.version} build ${_cfgPackageInfo.buildNumber}");

OptionGroup cfgAbout = OptionGroup(
    name: "About",
    icon: Icons.info,
    description: "Information about ${_cfgPackageInfo.appName.lowerCamelCaseToUpperSpacedCase.replaceAll("_", " ")}",
    options: [
      cfgAboutFoundry,
    ]);

OptionScreen cfgSettings = OptionScreen(
    name: "Settings",
    options: [cfgAppearance, cfgAbout]);

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<void> _work;

  @override
  void initState() {
    super.initState();
    _work = PackageInfo.fromPlatform().then((packageInfo) {
      _cfgPackageInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _work,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        return SettingsScreen(options: cfgSettings);
      }
      return const Center(child: CircularProgressIndicator());
    },
  );
}