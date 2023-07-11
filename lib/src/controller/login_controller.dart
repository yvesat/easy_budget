// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/repositories/user_repository.dart';-
import '../model/custom_exception.dart';
import '../model/servidor_model.dart';
import '../model/usuario_model.dart';

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(const AsyncValue.data(null));

  final UserRepository repositorioUsuario = UserRepository();
  final IsarService isarService = IsarService();

  //Recupera usuário do banco de dados
  Future<Usuario?> recuperarUsuario() async {
    try {
      state = const AsyncValue.loading();
      return await isarService.recuperarUsuarioDB();
    } catch (_) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> entrar(BuildContext context, WidgetRef ref, String? login, String? senha) async {
    try {
      if (login == null) throw CustomException("Usuário inválido");

      if (senha == null) throw CustomException("Senha inválida");

      state = const AsyncValue.loading();

      try {
        await repositorioUsuario.logIn(ref, login, senha);
      } catch (e) {
        throw CustomException(e.toString());
      }

      final usuarioController = ref.read(usuarioProvider.notifier);
      final usuarioState = ref.read(usuarioProvider);

      if (usuarioState.servidores!.length == 1) {
        usuarioController.gravarCaminhoBanco(usuarioState.servidores![0].nome, usuarioState.servidores![0].caminho);
        //TODO: DESCOMENTAR PARA CONECTAR COM A API
        await repositorioUsuario.getToken(ref);
        context.go('/principal');
      } else {
        context.go('/escolha-base');
      }
    } catch (e) {
      throw CustomException(e.toString());
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> continuarComBaseSelecionada(BuildContext context, WidgetRef ref, Servidor? servidor) async {
    state = const AsyncValue.loading();

    try {
      if (servidor == null) throw CustomException("Base de dados não selecionada");

      final usuarioState = ref.read(usuarioProvider);
      final usuarioController = ref.read(usuarioProvider.notifier);

      usuarioController.gravarCaminhoBanco(servidor.nome, servidor.caminho);

      //TODO: DESCOMENTAR PARA CONECTAR COM A API
      await repositorioUsuario.getToken(ref);
      if (usuarioState.tokenUsuario!.token == "" || usuarioState.tokenUsuario == null) throw CustomException("Sem permissão para acesso a esta base.");

      context.go('/principal');
    } catch (e) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final loginControllerProvider = StateNotifierProvider<LoginController, AsyncValue<void>>((ref) => LoginController());
