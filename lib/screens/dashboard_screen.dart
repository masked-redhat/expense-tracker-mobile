import 'package:expense_tracker_app/components/loader.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:expense_tracker_app/widgets/transaction_list.dart';
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
  bool reloading = false;
  Key transactionListKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    setUserData();
  }

  Future<void> setUserData() async {
    setState(() {
      loading = true;
    });

    final user = await getUserData();

    if (user == null) return;

    setState(() {
      username = user.username;
      balance = user.currentBalance;
      loading = false;
    });
  }

  void reloadTransactionList() {
    setState(() {
      reloading = true;
      transactionListKey = UniqueKey();
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        reloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  loading
                      ? Center(child: Loader())
                      : UserBalanceCard(username: username!, balance: balance!),
                  SizedBox(height: 10),
                  Expanded(child: TransactionList(key: transactionListKey)),
                ],
              ),
            ),
            Positioned(
              bottom: 32,
              right: 20,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: !reloading ? reloadTransactionList : null,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.refresh),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/create-transaction").then((
                        value,
                      ) {
                        if (value == null) return;
                        setState(() {
                          if (value is double) balance = value;
                        });
                        reloadTransactionList();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
