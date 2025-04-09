import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  void _login() async {
    setState(() => _loading = true);

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    // TODO: Integrate with backend API

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _loading = false);

    // Navigate or show error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login API not connected yet')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child:
                  _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
