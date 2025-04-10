import 'package:expense_tracker_app/components/account_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupForm();
}

class _SignupForm extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
        ),
        SizedBox(height: 5),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 16),
            text: "Already have an account? ",
            children: [
              TextSpan(
                text: "Login",
                style: TextStyle(color: Colors.blue),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        AccountForm(onClick: () => {}, text: "Sign Up"),
      ],
    );
  }
}
