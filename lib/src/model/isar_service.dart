import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'app_settings_model.dart';
import 'user_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> clearDB() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  //User data base operations
  Future<UserModel?> getUserDB() async {
    final isar = await db;
    final user = await isar.userModels.where().findFirst();
    return user;
  }

  Future<void> saveUserDB(UserModel user) async {
    final isar = await db;
    await isar.writeTxn(() async => isar.userModels.put(user));
  }

  Future<void> clearUserDB() async {
    final isar = await db;
    return await isar.writeTxn(() async => await isar.userModels.where().deleteAll());
  }

  //App settings data base operations
  Future<AppSettingsModel?> getAppSettingsDB() async {
    final isar = await db;
    return await isar.appSettingsModels.where().findFirst();
  }

  Future<void> saveAppSettingsDB(AppSettingsModel appSettings) async {
    final isar = await db;
    await isar.writeTxn(() async => isar.appSettingsModels.put(appSettings));
  }

  Future<void> clearAppSettingsDB() async {
    final isar = await db;
    return await isar.writeTxn(() async => await isar.appSettingsModels.where().deleteAll());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        directory: dir.path,
        [UserModelSchema, AppSettingsModelSchema],
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
