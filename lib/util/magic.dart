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
import 'package:flutter_svg/svg.dart';

BehaviorSubject<int> appUpdateStream = BehaviorSubject<int>.seeded(0);
void updateApp() => appUpdateStream.add(appUpdateStream.value + 1);

const String _assetName = 'assets/icon/icon.svg';

final Widget foundryIcon = SvgPicture.asset(
  _assetName,
  semanticsLabel: 'Foundry Logo',
);
