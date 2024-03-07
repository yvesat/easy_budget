import 'package:easy_budget/src/model/custom_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserServices {
  static Future<UserCredential?> logIn(BuildContext context, email, String password) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        if (e.code == 'email-already-in-use') throw CustomException(AppLocalizations.of(context)!.errorEmailAlreadyInUse);
        if (e.code == 'invalid-email') throw CustomException(AppLocalizations.of(context)!.errorInvalidEMailFormat);
        if (e.code == 'weak-password') throw CustomException(AppLocalizations.of(context)!.errorPasswordTooShort);
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
