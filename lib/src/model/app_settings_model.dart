import 'package:isar/isar.dart';

part 'app_settings_model.g.dart';

@collection
class AppSettingsModel {
  Id id = Isar.autoIncrement;
  bool rememberCredentials;

  AppSettingsModel({
    this.rememberCredentials = false,
  });
}
