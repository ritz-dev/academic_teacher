import 'package:hive_flutter/hive_flutter.dart';

part 'settings_data.g.dart';

@HiveType(typeId:0)

class SettingsItem {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String role;

  SettingsItem({
    required this.name,
    required this.email,
    required this.role,
    required String key
  });
}