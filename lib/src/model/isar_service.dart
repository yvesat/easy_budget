import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

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

  //Usuario
  Future<UserModel?> getUserDB() async {
    final isar = await db;
    UserModel? user = await isar.userModels.where().findFirst();
    return user;
  }

  Future<void> saveUserDB(UserModel user) async {
    final isar = await db;
    // await isar.writeTxnSync(() async => isar.usuarios.putSync(usuario));
    await isar.writeTxn(() async => isar.userModels.put(user));
  }

  Future<int> clearUserDB() async {
    final isar = await db;
    return await isar.writeTxn(() async => await isar.userModels.where().deleteAll());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        directory: dir.path,
        [UserModelSchema],
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
