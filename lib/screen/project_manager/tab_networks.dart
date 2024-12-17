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

class TabNetworks extends StatefulWidget {
  const TabNetworks({super.key});

  @override
  State<TabNetworks> createState() => _TabNetworksState();
}

class _TabNetworksState extends State<TabNetworks> {
  @override
  void initState() {
    super.initState();
    info("Initialized");
  }

  @override
  Widget build(BuildContext context) => SliverScreen(
      header: Bar(
        trailing: [
          // something here
        ],
        titleText: "Networks",
        subtitleText: "Create, Manage and Share Networks",
      ),
      sliver: SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Networks Coming Soon")],
          ),
        ),
      ));
}
