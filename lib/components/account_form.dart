import 'dart:async';
import 'package:expense_tracker_app/components/loader.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/components/password_field.dart';

class AccountForm extends StatefulWidget {
  final VoidCallback onClick;
  final String text;
  final bool checkUsername;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool loading;

  const AccountForm({
    super.key,
    required this.onClick,
    required this.text,
    this.checkUsername = false,
    required this.usernameController,
    required this.passwordController,
    this.loading = false,
  });

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  bool usernameAvailable = false;
  bool usernameIsNotEmpty = false;
  Timer? _debounce;

  Future<void> updateUsernameAvailabe(value) async {
    var available = await checkUsername(value);
    setState(() {
      usernameAvailable = available;
    });
  }

  void _checkUsername(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    setState(() {
      usernameIsNotEmpty = value.isNotEmpty;
    });

    _debounce = Timer(const Duration(milliseconds: 300), () {
      updateUsernameAvailabe(value);
    });
  }

  @override
  void dispose() {
    widget.usernameController.dispose();
    widget.passwordController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UsernameField(),
        const SizedBox(height: 10),
        PasswordField(controller: widget.passwordController),
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
      child:
          widget.loading
              ? Loader()
              : Text(
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
      controller: widget.usernameController,
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
