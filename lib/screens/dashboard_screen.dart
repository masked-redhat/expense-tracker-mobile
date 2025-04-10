import 'package:expense_tracker_app/components/loader.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:expense_tracker_app/widgets/user_info.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? username;
  double? balance;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    setUserData();
  }

  Future<void> setUserData() async {
    final user = await getUserData();

    if (user == null) return;

    setState(() {
      username = user.username;
      balance = user.currentBalance;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            loading
                ? Center(child: Loader())
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      UserBalanceCard(username: username!, balance: balance!),
                    ],
                  ),
                ),
      ),
    );
  }
}
