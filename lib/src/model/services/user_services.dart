import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../custom_exception.dart';

class UserServices {
  static Future<UserCredential> logIn(BuildContext context, String email, String password) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw CustomException(AppLocalizations.of(context)!.errorInvalidEMailFormat);
        case 'invalid-credential':
          throw CustomException(AppLocalizations.of(context)!.errorWrongUserOrPwd);
        case 'user-not-found':
          throw CustomException(AppLocalizations.of(context)!.errorWrongUserOrPwd);
        case 'wrong-password':
          throw CustomException(AppLocalizations.of(context)!.errorWrongUserOrPwd);
        case 'user-disabled':
          throw CustomException(AppLocalizations.of(context)!.errorUserDisabled);
        default:
          throw CustomException(e.toString());
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential> signUp(BuildContext context, String email, String password) async {
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw CustomException(AppLocalizations.of(context)!.errorEmailAlreadyInUse);
        case 'invalid-email':
          throw CustomException(AppLocalizations.of(context)!.errorInvalidEMailFormat);
        case 'weak-password':
          throw CustomException(AppLocalizations.of(context)!.errorPasswordTooShort);
        default:
          throw CustomException(e.toString());
      }
    } catch (e) {
      rethrow;
    }
  }
}
