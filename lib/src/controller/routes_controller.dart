import 'package:go_router/go_router.dart';

import '../view/auth_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const AuthPage()),
  ],
);
