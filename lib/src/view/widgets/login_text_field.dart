import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool hide;
  final TextInputType keyboardType;
  final int maxLength;
  final bool? enable;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hide,
    required this.keyboardType,
    required this.maxLength,
    this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hide,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: 1,
      enabled: enable ?? true,
      autocorrect: false,
      onTapOutside: (_) => SystemChannels.textInput.invokeMethod('TextInput.hide'),
      decoration: InputDecoration(labelText: label, filled: true, counterText: "", isDense: true),
      // inputFormatters: [TextListener()],
    );
  }
}
