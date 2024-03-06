import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../model/custom_exception.dart';
import '../model/isar_service.dart';
import '../model/user_model.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController() : super(const AsyncValue.data(null));

  // final UserRepository repositorioUsuario = UserRepository();
  final IsarService isarService = IsarService();

  Future<UserModel?> loadUser() async {
    try {
      state = const AsyncValue.loading();
      return await isarService.getUserDB();
    } catch (_) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> logIn(BuildContext context, WidgetRef ref, String? login, String? senha) async {
    try {
      if (login == null) throw CustomException("Usuário inválido");

      if (senha == null) throw CustomException("Senha inválida");

      state = const AsyncValue.loading();

      // await repositorioUsuario.logIn(ref, login, senha);

      // final userController = ref.read(userProvider.notifier);
      // final userState = ref.read(userProvider);

      // await repositorioUsuario.getToken(ref);
      context.go('/home');
    } catch (e) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signUp(BuildContext context, WidgetRef ref, String? login, String? fullName, String? password, String? confirmPassword) async {
    try {
      if (login == null) throw CustomException("Usuário inválido");
      if (fullName == null) throw CustomException("Favor informar nome completo");

      if (password == null) throw CustomException("Senha inválida");

      state = const AsyncValue.loading();

      // await repositorioUsuario.logIn(ref, login, senha);

      // final userController = ref.read(userProvider.notifier);
      // final userState = ref.read(userProvider);

      // await repositorioUsuario.getToken(ref);
      context.go('/home');
    } catch (e) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) => AuthController());
