import 'package:flutter/material.dart';

import '../misc/constant.dart';

class FlixTextField extends StatelessWidget {
  final String labelText;
  final String? suffixText;
  final TextEditingController controller;
  final bool obsecureText;
  final IconButton? icon;
  final bool readOnly;
  const FlixTextField(
      {super.key,
      required this.labelText,
      required this.controller,
      this.suffixText,
      this.readOnly = false,
      this.icon,
      this.obsecureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      controller: controller,
      obscureText: obsecureText,
      readOnly: readOnly,
      obscuringCharacter: '●',
      style: const TextStyle(decorationThickness: 0),
      onTap: () => FocusScope.of(context).requestFocus(),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        suffixIcon: icon,
        suffixIconColor: ghostWhite,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: ghostWhite,
        ),
        suffixText: suffixText,
        suffixStyle: const TextStyle(color: grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: grey800),
        ),
        focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide(color: ghostWhite)),
      ),
    );
  }
}
