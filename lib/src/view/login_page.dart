// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info/package_info.dart';

import 'widgets/button.dart';
import 'widgets/login_text_field.dart';
import 'widgets/progress.dart';
import 'widgets/alert.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _hidePassword = true;

  String _versao = "";

  // late Future<Usuario?> _usuario;

  final _edtUser = TextEditingController(text: "");
  final _edtPassword = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    // _usuario = LoginController().recuperarUsuario();
    _carregarVersao();
  }

  @override
  Widget build(BuildContext context) {
    final alertaProvider = Provider<Alert>((ref) => Alert());
    final alerta = ref.watch(alertaProvider);

    // final loginState = ref.watch(loginControllerProvider);
    // final loginController = ref.read(loginControllerProvider.notifier);

    final size = MediaQuery.sizeOf(context);
    return FutureBuilder(
      future: _usuario,
      builder: (context, snapshot) {
        if (snapshot.hasData && _edtUser.text.isEmpty && _edtPassword.text.isEmpty) {
          _edtUser.text = snapshot.data!.usuario!;
          _edtPassword.text = snapshot.data!.senha!;
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 36),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/images/logomarca_original.png", height: 70, width: 70),
                            const Text('Med Collector', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50, 16, 50, 0),
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            LoginTextField(controller: _edtUser, label: "User", hide: false, keyboardType: TextInputType.emailAddress, maxLength: 100),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: <Widget>[
                                  LoginTextField(controller: _edtPassword, label: "Password", hide: _hidePassword, keyboardType: TextInputType.emailAddress, maxLength: 20),
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
                                  await loginController.entrar(context, ref, _edtUser.text, _edtPassword.text);
                                } catch (e) {
                                  alerta.snack(context, e.toString());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (loginState.isLoading) Progress(size),
                Positioned(bottom: 16, right: 16, child: Text("Versão: $_versao")),
              ],
            ),
          ),
        );
        // : Progress(size);
      },
    );
  }

  void _carregarVersao() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _versao = packageInfo.version;
    });
  }
}
