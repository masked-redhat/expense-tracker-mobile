import 'package:flutter/material.dart';

Widget AccountForm({required VoidCallback onClick, required String text}) {
  return Column(
    children: [
      TextField(decoration: InputDecoration(hintText: "Username")),
      SizedBox(height: 10),
      TextField(decoration: InputDecoration(hintText: "Password")),
      SizedBox(height: 25),
      ElevatedButton(onPressed: onClick, child: Text(text)),
    ],
  );
}
