import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';
import 'isar_service.dart';

part 'user_model.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  String? usuario;
  String? senha;
  String? email;
  String? tokenUsuario;

  User({
    this.usuario,
    this.senha,
    this.email,
  });
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User());

  final IsarService isarService = IsarService();

  Future<void> createUser({
    required String login,
    required String senha,
  }) async {
    final userExists = await isarService.getUserDB();

    if (userExists == null) {
      final user = User(
        usuario: login,
        senha: senha,
      );
      state = user;
      await isarService.gravarUsuarioDB(state);
    } else {
      state = userExists;
    }
  }

  Future<void> saveToken(String token) async {
    state.tokenUsuario = token;
    await isarService.gravarUsuarioDB(state);
  }

  User getUser() => state;
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());
