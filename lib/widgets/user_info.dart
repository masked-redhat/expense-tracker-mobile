import 'package:expense_tracker_app/services/api_service.dart';
import 'package:expense_tracker_app/services/user_token_service.dart';
import 'package:expense_tracker_app/utils/dialog_box.dart';
import 'package:flutter/material.dart';

class UserBalanceCard extends StatelessWidget {
  final String username;
  final double balance;

  const UserBalanceCard({
    super.key,
    required this.username,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),

              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: balance),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Text(
                    '₹ ${value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: IconButton(
            onPressed: () {
              showLogoutDialog(context, () async {
                await logoutUser();
                await reset();

                Navigator.pushReplacementNamed(context, "/login");
              });
            },
            icon: Icon(Icons.logout),
          ),
        ),
      ],
    );
  }
}
