import 'package:expense_tracker_app/components/account_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
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
        AccountForm(onClick: () => {}, text: "Log In"),
      ],
    );
  }
}
