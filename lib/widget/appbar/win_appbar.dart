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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';

class FoundryAppBarWindows extends StatefulWidget {
  const FoundryAppBarWindows({super.key});

  @override
  State<FoundryAppBarWindows> createState() => _FoundryAppBarWindowsState();
}

class _FoundryAppBarWindowsState extends State<FoundryAppBarWindows> {

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      child: Bar(
        backgroundColor: Colors.black.withOpacity(0.2),
        title: Text(localizations.appTitle),
        trailing: [
          GhostButton(
            child: Icon(Icons.minus),
            // density: ButtonDensity.compact,
            onPressed: () async {
              await windowManager.minimize();
            },
          ),
          GhostButton(
            child: Icon(BootstrapIcons.fullscreen),
            // density: ButtonDensity.compact,
            onPressed: () async {
              await windowManager.maximize();
            },
          ),
          GhostButton(
            child: Icon(Icons.close_ionic),
            // density: ButtonDensity.compact,
            onPressed: () async {
              await windowManager.close();
            },
          )
        ],
      ),
      onPanStart: (_) => windowManager.startDragging(),
    );
  }
}
