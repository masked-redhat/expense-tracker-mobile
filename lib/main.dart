import 'package:expense_tracker_app/screens/dashboard_screen.dart';
import 'package:expense_tracker_app/screens/initial_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 REQUIRED before prefs or async ops

  final prefs = await SharedPreferences.getInstance(); // now safe

  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // or any color you want
        statusBarIconBrightness: Brightness.dark, // ⬅ white icons
        statusBarBrightness: Brightness.dark, // iOS
      ),
    );

    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.spaceGroteskTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const SignupScreen(),
        "/dashboard": (context) => const DashboardScreen(),
      },
      home: InitialScreen(),
    );
  }
}
