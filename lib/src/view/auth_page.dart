// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/app_settings_controller.dart';
import '../controller/auth_controller.dart';
import '../model/enums/auth_mode.dart';
import '../model/user_model.dart';
import 'widgets/button.dart';
import 'widgets/login_text_field.dart';
import 'widgets/progress.dart';
import 'widgets/alert.dart';
import 'widgets/sign_with_google.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<AuthPage> {
  bool _hidePassword = true;

  late Future<UserModel?> _user;

  final _edtEmail = TextEditingController(text: "");
  final _edtPassword = TextEditingController(text: "");
  final _edConfirmPassword = TextEditingController(text: "");

  AuthMode _authMode = AuthMode.logIn;
  bool _rememberCredentials = false;

  @override
  void initState() {
    super.initState();
    _user = AuthController().loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(authControllerProvider);
    final loginController = ref.read(authControllerProvider.notifier);

    final appSettingsController = AppSettingsController();

    final size = MediaQuery.sizeOf(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return FutureBuilder(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasData && _edtEmail.text.isEmpty && _edtPassword.text.isEmpty) {
          _edtEmail.text = snapshot.data!.user!;
          _edtPassword.text = snapshot.data!.password!;
          setState(() async {
            final appSettings = await appSettingsController.getAppSettings();
            _rememberCredentials = appSettings!.rememberCredentials;
          });
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(height: _authMode == AuthMode.signUp ? size.height * 0.05 : size.height * 0.1),
                      Image.asset(isDarkMode ? "assets/images/icon_title_dark.png" : "assets/images/icon_title.png", height: _authMode == AuthMode.logIn ? size.height * 0.25 : size.height * 0.15),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (_authMode == AuthMode.signUp) const SizedBox(height: 8),
                            LoginTextField(controller: _edtEmail, label: AppLocalizations.of(context)!.email, hide: false, keyboardType: TextInputType.emailAddress, maxLength: 100),
                            const SizedBox(height: 8),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                LoginTextField(
                                  controller: _edtPassword,
                                  label: AppLocalizations.of(context)!.password,
                                  hide: _hidePassword,
                                  keyboardType: TextInputType.emailAddress,
                                  maxLength: 20,
                                ),
                                IconButton(
                                  icon: Icon(_hidePassword ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
                                  onPressed: () => setState(() => _hidePassword = !_hidePassword),
                                )
                              ],
                            ),
                            if (_authMode == AuthMode.signUp)
                              Stack(
                                alignment: Alignment.centerRight,
                                children: <Widget>[
                                  LoginTextField(
                                    controller: _edConfirmPassword,
                                    label: AppLocalizations.of(context)!.confirmPassword,
                                    hide: _hidePassword,
                                    keyboardType: TextInputType.emailAddress,
                                    maxLength: 20,
                                  ),
                                ],
                              ),
                            const SizedBox(height: 16),
                            Button(
                              label: _authMode == AuthMode.logIn ? AppLocalizations.of(context)!.logIn : AppLocalizations.of(context)!.signUp,
                              onTap: () async {
                                try {
                                  if (_authMode == AuthMode.logIn) {
                                    await loginController.logIn(context, ref, _edtEmail.text, _edtPassword.text);
                                  } else {
                                    await loginController.signUp(context, ref, _edtEmail.text, _edtPassword.text, _edConfirmPassword.text);
                                    setState(() {
                                      _authMode = AuthMode.logIn;
                                    });
                                  }
                                } catch (e) {
                                  Alert.snack(context, e.toString());
                                }
                              },
                            ),
                            if (_authMode == AuthMode.logIn)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: InkWell(
                                  onTap: () async {
                                    _rememberCredentials = await appSettingsController.changeRemeberCredentials();
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      FaIcon(_rememberCredentials == true ? FontAwesomeIcons.squareCheck : FontAwesomeIcons.square, color: Theme.of(context).colorScheme.secondary),
                                      const SizedBox(width: 8),
                                      Text(AppLocalizations.of(context)!.rememberUser, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                                    ],
                                  ),
                                ),
                              ),
                            //TODO: Implementar função
                            if (_authMode == AuthMode.logIn)
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppLocalizations.of(context)!.forgotPassword,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                            Row(
                              children: [
                                Expanded(child: Container(margin: const EdgeInsets.only(right: 15.0), child: Divider(color: Theme.of(context).colorScheme.secondary, height: 36))),
                                Text(AppLocalizations.of(context)!.authPageOr, style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                                Expanded(child: Container(margin: const EdgeInsets.only(left: 15.0), child: Divider(color: Theme.of(context).colorScheme.secondary, height: 36))),
                              ],
                            ),
                            //TODO: Implementar função
                            GoogleSignInButton(
                              authMode: _authMode,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _authMode = _authMode == AuthMode.signUp ? AuthMode.logIn : AuthMode.signUp;
                          });
                        },
                        child: Text(_authMode == AuthMode.logIn ? AppLocalizations.of(context)!.dontHaveAccount : AppLocalizations.of(context)!.alreadyHaveAccount, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
                      ),
                      const SizedBox(height: 18)
                    ],
                  ),
                ),
                if (loginState.isLoading) Progress(size),
              ],
            ),
          ),
        );
        // : Progress(size);
      },
    );
  }
}
