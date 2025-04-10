import 'package:expense_tracker_app/components/loader.dart';
import 'package:expense_tracker_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionList();
}

class _TransactionList extends State<TransactionList> {
  List<dynamic> transactions = [];
  int? nextPage = 1;
  bool loading = false;

  Future<void> getTransactions() async {
    if (loading || nextPage == null) return;

    setState(() => loading = true);

    final res = await getTransactionsData(nextPage!);
    if (res != null) {
      setState(() {
        transactions = transactions + res['transactions'];
        nextPage = res['nextPage'];
      });
    }

    setState(() => loading = false);
  }

  Future<void> _loadUntil30() async {
    int safety = 0;
    while (nextPage != null && transactions.length < 30 && safety < 10) {
      await getTransactions();
      safety++;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUntil30();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length + 1,
      itemBuilder: (context, index) {
        if (index == transactions.length) {
          return VisibilityDetector(
            key: const Key("transactions-loader"),
            onVisibilityChanged: (visibilityInfo) {
              if (visibilityInfo.visibleFraction > 0 && !loading) {
                getTransactions();
              }
            },
            child:
                loading
                    ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: Loader()),
                    )
                    : const SizedBox(height: 10),
          );
        }

        final txn = transactions[index];
        final isExpense = txn.type.toLowerCase() == 'expense';
        final bgColor = isExpense ? Colors.red.shade50 : Colors.green.shade50;
        final symbol = isExpense ? '-' : '+';

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                symbol,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: isExpense ? Colors.red : Colors.green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (txn.message.trim().isNotEmpty)
                      Text(
                        txn.message,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    Text(
                      '₹ ${txn.value.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isExpense ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
