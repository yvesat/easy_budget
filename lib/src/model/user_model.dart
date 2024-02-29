import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'isar_service.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  String? user;
  String? password;
  String? email;
  String? userToken;

  UserModel({
    this.user,
    this.password,
    this.email,
  });
}

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier() : super(UserModel());

  final IsarService isarService = IsarService();

  Future<void> createUser({
    required String login,
    required String senha,
  }) async {
    final userExists = await isarService.getUserDB();

    if (userExists == null) {
      final user = UserModel(
        user: login,
        password: senha,
      );
      state = user;
      await isarService.saveUserDB(state);
    } else {
      state = userExists;
    }
  }

  Future<void> saveToken(String token) async {
    state.userToken = token;
    await isarService.saveUserDB(state);
  }

  UserModel getUser() => state;
}

final userProvider = StateNotifierProvider<UserNotifier, UserModel>((ref) => UserNotifier());
