// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controller/login_controller.dart';
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

enum AuthMode {
  signUp,
  logIn,
}

class _LoginPageState extends ConsumerState<AuthPage> {
  bool _hidePassword = true;

  late Future<UserModel?> _user;

  final _edtUser = TextEditingController(text: "");
  final _edtPassword = TextEditingController(text: "");
  final _edSecondtPassword = TextEditingController(text: "");

  AuthMode _authMode = AuthMode.logIn;

  @override
  void initState() {
    super.initState();
    _user = LoginController().loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final alertProvider = Provider<Alert>((ref) => Alert());
    final alert = ref.watch(alertProvider);

    final loginState = ref.watch(loginControllerProvider);
    final loginController = ref.read(loginControllerProvider.notifier);

    final size = MediaQuery.sizeOf(context);
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return FutureBuilder(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.hasData && _edtUser.text.isEmpty && _edtPassword.text.isEmpty) {
          _edtUser.text = snapshot.data!.user!;
          _edtPassword.text = snapshot.data!.password!;
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.asset(isDarkMode ? "assets/images/icon_title_dark.png" : "assets/images/icon_title.png", height: size.height * 0.25),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (_authMode == AuthMode.signUp) LoginTextField(controller: _edtUser, label: "Full name", hide: false, keyboardType: TextInputType.emailAddress, maxLength: 100),
                            LoginTextField(controller: _edtUser, label: "User", hide: false, keyboardType: TextInputType.emailAddress, maxLength: 100),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: <Widget>[
                                  LoginTextField(
                                    controller: _edtPassword,
                                    label: "Password",
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
                            ),
                            if (_authMode == AuthMode.signUp)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: <Widget>[
                                    LoginTextField(
                                      controller: _edSecondtPassword,
                                      label: "Confirm Password",
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
                              ),
                            Button(
                              label: "ENTER",
                              onTap: () async {
                                try {
                                  await loginController.login(context, ref, _edtUser.text, _edtPassword.text);
                                } catch (e) {
                                  alert.snack(context, e.toString());
                                }
                              },
                            ),
                            //TODO: Implementar função
                            TextButton(
                              onPressed: () {},
                              child: const Text("Forgot Password?"),
                            ),
                            Row(
                              children: [
                                Expanded(child: Container(margin: const EdgeInsets.only(right: 15.0), child: Divider(color: Theme.of(context).colorScheme.secondary, height: 36))),
                                Text("or", style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
                                Expanded(child: Container(margin: const EdgeInsets.only(left: 15.0), child: Divider(color: Theme.of(context).colorScheme.secondary, height: 36))),
                              ],
                            ),
                            GoogleSignInButton(
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
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
