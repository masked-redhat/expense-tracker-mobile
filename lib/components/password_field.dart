import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordField();
}

class _PasswordField extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        ),
      ),
      controller: widget.controller,
    );
  }
}
