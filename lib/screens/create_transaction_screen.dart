import 'package:expense_tracker_app/widgets/transaction_form.dart';
import 'package:flutter/material.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() => _CreateTransactionScreen();
}

class _CreateTransactionScreen extends State<CreateTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create Transaction"),
          backgroundColor: Colors.blue.shade50,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: TransactionForm(),
          ),
        ),
      ),
    );
  }
}
