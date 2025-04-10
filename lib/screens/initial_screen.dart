import 'package:expense_tracker_app/components/loader.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final isValid = await validUserToken();

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, isValid ? '/dashboard' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Loader()), // your custom loader
    );
  }
}
