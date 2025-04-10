import 'package:flutter/material.dart';

void showLogoutDialog(BuildContext context, VoidCallback onYesPressed) {
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: const Text(
            'Confirm Logout',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ❌ Close dialog
              child: const Text('No', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // ✅ Close dialog first
                onYesPressed(); // Then run your custom function
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Yes', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
  );
}
