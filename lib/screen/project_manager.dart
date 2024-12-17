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
import 'package:foundry_launcher/screen/project_manager/tab_data_packs.dart';
import 'package:foundry_launcher/screen/project_manager/tab_networks.dart';
import 'package:foundry_launcher/screen/project_manager/tab_resource_packs.dart';
import 'package:foundry_launcher/screen/project_manager/user_settings.dart';

class FoundryProjectManager extends StatefulWidget {
  const FoundryProjectManager({super.key});

  static void go(BuildContext context) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const FoundryProjectManager()),
        (route) => false,
      );

  @override
  State<FoundryProjectManager> createState() => _FoundryProjectManagerState();
}

class _FoundryProjectManagerState extends State<FoundryProjectManager> {
  @override
  Widget build(BuildContext context) {
    return MutablePylon<int>(
      rebuildChildren: true,
      local: true,
      value: 0,
      builder: (context) => NavigationScreen(
        type: NavigationType.sidebar,
        index: context.pylon<int>(),
        onIndexChanged: (index) => context.setPylon<int>(index),
        tabs: <NavItem>[
          NavTab(
              label: "Networks",
              icon: Icons.share_network,
              selectedIcon: Icons.share_network_fill,
              builder: (context) => TabNetworks()),
          NavTab(
              label: "Data Packs",
              icon: Icons.cube,
              selectedIcon: Icons.cube_fill,
              builder: (context) => TabDataPacks()),
          NavTab(
              label: "Resource Packs",
              icon: Icons.folder,
              selectedIcon: Icons.folder_fill,
              builder: (context) => TabResourcePacks()),
          NavTab(
              label: "Settings",
              icon: Icons.gear_six,
              selectedIcon: Icons.gear_six_fill,
              builder: (context) => UserScreen()),
        ].toList(),
        sidebarFooter: (context) => ArcaneSidebarFooter(
          content: const Text("something"),
        ),
      ),
    );
  }
}
