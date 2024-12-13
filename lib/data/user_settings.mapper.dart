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

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'user_settings.dart';

class UserSettingsMapper extends ClassMapperBase<UserSettings> {
  UserSettingsMapper._();

  static UserSettingsMapper? _instance;
  static UserSettingsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserSettingsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UserSettings';

  static bool _$theme(UserSettings v) => v.theme;
  static const Field<UserSettings, bool> _f$theme =
      Field('theme', _$theme, opt: true, def: true);
  static bool _$highContrast(UserSettings v) => v.highContrast;
  static const Field<UserSettings, bool> _f$highContrast =
      Field('highContrast', _$highContrast, opt: true, def: false);

  @override
  final MappableFields<UserSettings> fields = const {
    #theme: _f$theme,
    #highContrast: _f$highContrast,
  };

  static UserSettings _instantiate(DecodingData data) {
    return UserSettings(
        theme: data.dec(_f$theme), highContrast: data.dec(_f$highContrast));
  }

  @override
  final Function instantiate = _instantiate;

  static UserSettings fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UserSettings>(map);
  }

  static UserSettings fromJson(String json) {
    return ensureInitialized().decodeJson<UserSettings>(json);
  }
}

mixin UserSettingsMappable {
  String toJson() {
    return UserSettingsMapper.ensureInitialized()
        .encodeJson<UserSettings>(this as UserSettings);
  }

  Map<String, dynamic> toMap() {
    return UserSettingsMapper.ensureInitialized()
        .encodeMap<UserSettings>(this as UserSettings);
  }

  UserSettingsCopyWith<UserSettings, UserSettings, UserSettings> get copyWith =>
      _UserSettingsCopyWithImpl(this as UserSettings, $identity, $identity);
  @override
  String toString() {
    return UserSettingsMapper.ensureInitialized()
        .stringifyValue(this as UserSettings);
  }

  @override
  bool operator ==(Object other) {
    return UserSettingsMapper.ensureInitialized()
        .equalsValue(this as UserSettings, other);
  }

  @override
  int get hashCode {
    return UserSettingsMapper.ensureInitialized()
        .hashValue(this as UserSettings);
  }
}

extension UserSettingsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UserSettings, $Out> {
  UserSettingsCopyWith<$R, UserSettings, $Out> get $asUserSettings =>
      $base.as((v, t, t2) => _UserSettingsCopyWithImpl(v, t, t2));
}

abstract class UserSettingsCopyWith<$R, $In extends UserSettings, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? theme, bool? highContrast});
  UserSettingsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _UserSettingsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UserSettings, $Out>
    implements UserSettingsCopyWith<$R, UserSettings, $Out> {
  _UserSettingsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UserSettings> $mapper =
      UserSettingsMapper.ensureInitialized();
  @override
  $R call({bool? theme, bool? highContrast}) => $apply(FieldCopyWithData({
        if (theme != null) #theme: theme,
        if (highContrast != null) #highContrast: highContrast
      }));
  @override
  UserSettings $make(CopyWithData data) => UserSettings(
      theme: data.get(#theme, or: $value.theme),
      highContrast: data.get(#highContrast, or: $value.highContrast));

  @override
  UserSettingsCopyWith<$R2, UserSettings, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _UserSettingsCopyWithImpl($value, $cast, t);
}
