import 'package:expense_tracker_app/components/account_form.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:expense_tracker_app/services/user_token_service.dart';
import 'package:expense_tracker_app/utils/navigate_dashboard.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupForm();
}

class _SignupForm extends State<SignupForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;

  Future<void> signup() async {
    setState(() => loading = true);

    final userToken = await signupUser(
      _usernameController.text,
      _passwordController.text,
    );
    if (userToken != null) {
      await saveUserToken(userToken);

      if (!mounted) return;

      navigateToDashboard(context);
    } else {
      print("Not logged In");
    }

    setState(() => loading = false);
  }

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
                text: "Log In",
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
        AccountForm(
          onClick: signup,
          text: "Sign Up",
          checkUsername: true,
          usernameController: _usernameController,
          passwordController: _passwordController,
          loading: loading,
        ),
      ],
    );
  }
}
