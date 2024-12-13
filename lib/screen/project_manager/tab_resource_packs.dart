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

class TabResourcePacks extends StatefulWidget {
  const TabResourcePacks({super.key});

  @override
  State<TabResourcePacks> createState() => _TabResourcePacksState();
}

class _TabResourcePacksState extends State<TabResourcePacks> {
  @override
  void initState() {
    super.initState();
    info("Initialized");
  }

  @override
  Widget build(BuildContext context) => SliverScreen(
          sliver: SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Resource Packs Coming Soon")],
          ),
        ),
      ));
}
