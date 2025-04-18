import 'package:expense_tracker_app/components/account_form.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:expense_tracker_app/services/user_token_service.dart';
import 'package:expense_tracker_app/utils/navigate_dashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);

    final userToken = await loginUser(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );
    if (userToken != null) {
      await saveUserToken(userToken);

      if (!mounted) return;

      navigateToDashboard(context);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Not logged in!')));
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
        ),
        SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 16),
            text: "Don't have an account? ",
            children: [
              TextSpan(
                text: "Sign up",
                style: TextStyle(color: Colors.blue),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, "/signup");
                      },
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        AccountForm(
          onClick: login,
          text: "Log In",
          usernameController: _usernameController,
          passwordController: _passwordController,
          loading: loading,
        ),
      ],
    );
  }
}
