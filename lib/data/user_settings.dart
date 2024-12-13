import 'package:dart_mappable/dart_mappable.dart';

part 'user_settings.mapper.dart';

@MappableClass()
class UserSettings {
  final String? theme;
  final bool highContrast;

  UserSettings({
    this.theme,
    this.highContrast = false,
  });

}
