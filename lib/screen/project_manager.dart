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
import 'package:arcane/generated/arcane_shadcn/shadcn_flutter_extension.dart';
import 'package:foundry_launcher/screen/project_manager/tab_data_packs.dart';
import 'package:foundry_launcher/screen/project_manager/tab_networks.dart';
import 'package:foundry_launcher/screen/project_manager/tab_resource_packs.dart';
import 'package:foundry_launcher/screen/project_manager/user_settings.dart';
import 'package:foundry_launcher/widget/technical_footer.dart';

import '../util/magic.dart';

class FoundryProjectManager extends StatefulWidget {
  const FoundryProjectManager({super.key});

  static void go(BuildContext context) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const FoundryProjectManager()),
      (route) => false);

  @override
  State<FoundryProjectManager> createState() => _FoundryRootState();
}

class _FoundryRootState extends State<FoundryProjectManager> {
  int index = 0;
  double kMobileBreakpoint = 1000;

  final List<NavTab> navigationTabs = [
    NavTab(
      label: "Networks",
      icon: Icons.cube,
      selectedIcon: Icons.cube_fill,
      builder: (context) => const OutlinedContainer(
          borderRadius: BorderRadius.zero, child: TabNetworks()),
    ),
    NavTab(
      label: "Resource Packs",
      icon: Icons.cube,
      selectedIcon: Icons.cube_fill,
      builder: (context) => const OutlinedContainer(
          borderRadius: BorderRadius.zero, child: TabResourcePacks()),
    ),
    NavTab(
      label: "Data Packs",
      icon: Icons.cube,
      selectedIcon: Icons.cube_fill,
      builder: (context) => const OutlinedContainer(
          borderRadius: BorderRadius.zero, child: TabDataPacks()),
    ),
    NavTab(
      label: "Settings",
      icon: Icons.gear,
      selectedIcon: Icons.gear_fill,
      builder: (context) => const OutlinedContainer(
          borderRadius: BorderRadius.zero, child: UserScreen()),
    ),
  ];

  NavigationType _getNavigationType(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < kMobileBreakpoint) {
      return NavigationType.sidebar; // this is the "mobile" version
    } else {
      return NavigationType.sidebar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NavigationScreen(
              type: _getNavigationType(context),
              endSide: false,
              index: index,
              onIndexChanged: (index) => setState(() => this.index = index),
              tabs: navigationTabs,
              header: PaddingAll(
                  padding: 0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 40, maxWidth: 40),
                              child: foundryIcon),
                          Gap(16),
                          Text("Foundry", style: context.theme.typography.h3),
                          // Text("Foundry is a thing", style: context.theme.typography.small),
                        ],
                      ),
                      Gap(16),
                      Divider(),
                      Gap(16),
                      Row(
                        children: [
                          Text("Projects:",
                              style: context.theme.typography.textMuted)
                        ],
                      )
                    ],
                  )),
              sidebarConstraints:
                  const BoxConstraints(minWidth: 100, maxWidth: 200)),
        ),
        FoundryTechnicalFooter()
      ],
    );
  }
}
