import 'dart:async';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/components/password_field.dart';

class AccountForm extends StatefulWidget {
  final VoidCallback onClick;
  final String text;
  final bool checkUsername;

  const AccountForm({
    super.key,
    required this.onClick,
    required this.text,
    this.checkUsername = false,
  });

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool usernameAvailable = false;
  bool usernameIsNotEmpty = false;
  Timer? _debounce;

  void _checkUsername(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    setState(() {
      usernameIsNotEmpty = value.isNotEmpty;
    });

    _debounce = Timer(const Duration(milliseconds: 300), () {
      debugPrint("Final input: $value");
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UsernameField(),
        const SizedBox(height: 10),
        PasswordField(controller: _passwordController),
        const SizedBox(height: 20),
        ActionButton(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  ElevatedButton ActionButton() {
    return ElevatedButton(
      onPressed: widget.onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.blue,
        minimumSize: const Size(
          double.infinity,
          55,
        ), // 📐 Width: 200, Height: 60
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6), // 🎯 Rounded corners
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          letterSpacing: 1.8,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TextField UsernameField() {
    return TextField(
      controller: _usernameController,
      onChanged: widget.checkUsername ? _checkUsername : null,
      decoration: InputDecoration(
        hintText: "Username",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        suffixIcon:
            widget.checkUsername && usernameIsNotEmpty
                ? Icon(
                  usernameAvailable ? Icons.check : Icons.close,
                  color: usernameAvailable ? Colors.blue : Colors.red,
                )
                : null,
      ),
    );
  }
}
