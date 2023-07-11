import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'user_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = abrirDB();
  }

  Future<void> limparDB() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  //Usuario
  Future<User?> getUserDB() async {
    final isar = await db;
    User? acesso = await isar.users.where().findFirst();
    return acesso;
  }

  Future<void> gravarUsuarioDB(User usuario) async {
    final isar = await db;
    // await isar.writeTxnSync(() async => isar.usuarios.putSync(usuario));
    await isar.writeTxn(() async => isar.users.put(usuario));
  }

  Future<int> limparUsuarioDB() async {
    final isar = await db;
    return await isar.writeTxn(() async => await isar.users.where().deleteAll());
  }

  Future<Isar> abrirDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        directory: dir.path,
        [UserSchema],
        // [UsuarioSchema, DocSchema, DocLineSchema, LoteSchema],
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }
}
