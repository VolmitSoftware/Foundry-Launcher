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
import 'package:fast_log/fast_log.dart';
import 'package:foundry_launcher/screen/project_manager/tab_data_packs.dart';
import 'package:foundry_launcher/screen/project_manager/tab_networks.dart';
import 'package:foundry_launcher/screen/project_manager/tab_resource_packs.dart';
import 'package:foundry_launcher/screen/project_manager/user_settings.dart';
import 'package:foundry_launcher/widget/project_manager/network_appbar.dart';

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
  int selectedIndex = 0;

  final List<Widget Function(BuildContext)> tabs = [
    (context) => const TabNetworks(),
    (context) => const TabResourcePacks(),
    (context) => const TabDataPacks(),
    (context) => const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return FillScreen(
      header: ProjectManagerNetworkAppbar(),
        child: Column(
      children: [
        SidebarScreen(
          fab: Fab(
            child: const Icon(Icons.plug),
            onPressed: () {
              info("Add Network");
            },
          ),
          gutter: false,
          sidebar: (context) => ArcaneSidebar(
            children: (context) => [
              ArcaneSidebarButton(
                icon: context.isSidebarExpanded
                    ? const Icon(Icons.share_network)
                    : const Icon(Icons.share_network_fill),
                label: "Networks",
                selected: selectedIndex == 0,
                onTap: () => setState(() => selectedIndex = 0),
              ),
              ArcaneSidebarButton(
                icon: const Icon(Icons.cube),
                label: "Resource Packs",
                selected: selectedIndex == 1,
                onTap: () => setState(() => selectedIndex = 1),
              ),
              ArcaneSidebarButton(
                icon: const Icon(Icons.cube),
                label: "Data Packs",
                selected: selectedIndex == 2,
                onTap: () => setState(() => selectedIndex = 2),
              ),
              ArcaneSidebarButton(
                icon: const Icon(Icons.gear),
                label: "Settings",
                selected: selectedIndex == 3,
                onTap: () => setState(() => selectedIndex = 3),
              ),
            ],
            footer: (context) => const ArcaneSidebarFooter(
              content: ArcaneSidebarFooter(),
            ),
          ),
          sliver: SliverFillRemaining(
            hasScrollBody: false,
            child: tabs[selectedIndex](context),
          ),
        ),
      ],
    ));
  }
}
