import 'package:flutter/material.dart';

import '../../model/enums/auth_mode.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final AuthMode authMode;

  const GoogleSignInButton({super.key, required this.onPressed, required this.authMode});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(isDarkMode ? const Color(0xaa4285F4) : Theme.of(context).colorScheme.surface)),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: SizedBox(
                height: size.height * 0.045,
                child: Image.asset("assets/images/google_icon.png", fit: BoxFit.contain),
              ),
            ),
            Expanded(
              child: Text(
                authMode == AuthMode.logIn ? "Log In with Google" : "Sign Up with Google",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
