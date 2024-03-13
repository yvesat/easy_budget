import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../model/custom_exception.dart';
import '../model/enums/alert_type.dart';
import '../model/isar_service.dart';
import '../model/services/user_services.dart';
import '../model/user_model.dart';
import '../view/widgets/alert.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  AuthController() : super(const AsyncValue.data(null));

  final IsarService _isarService = IsarService();

  Future<UserModel?> loadUser() async {
    try {
      state = const AsyncValue.loading();
      return await _isarService.getUserDB();
    } catch (_) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> logIn(BuildContext context, WidgetRef ref, String? email, String? password) async {
    try {
      if (email == null) throw CustomException("Usuário inválido");

      if (password == null) throw CustomException("Senha inválida");

      state = const AsyncValue.loading();

      await UserServices.logIn(context, email, password);

      if (context.mounted) context.go('/home');
    } catch (e) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> signUp(BuildContext context, WidgetRef ref, String? email, String? password, String? confirmPassword) async {
    try {
      if (email == null) throw CustomException(AppLocalizations.of(context)!.errorNoEMail);
      if (password == null) throw CustomException(AppLocalizations.of(context)!.errorNoPassword);
      if (password != confirmPassword) throw CustomException(AppLocalizations.of(context)!.errorPasswordNoMatch);

      state = const AsyncValue.loading();

      await UserServices.signUp(context, email, password);

      if (context.mounted) Alert.dialog(context, AlertType.sucess, AppLocalizations.of(context)!.successUserCreation);
    } catch (e) {
      rethrow;
    } finally {
      state = const AsyncValue.data(null);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) => AuthController());
