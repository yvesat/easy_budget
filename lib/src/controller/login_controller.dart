// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../model/custom_exception.dart';
import '../model/isar_service.dart';
import '../model/user_model.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(const AsyncValue.data(null));

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

  Future<void> login(BuildContext context, WidgetRef ref, String? login, String? senha) async {
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
}

final loginControllerProvider = StateNotifierProvider<LoginController, AsyncValue<void>>((ref) => LoginController());
