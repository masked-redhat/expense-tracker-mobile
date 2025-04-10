import 'dart:convert';
import 'package:expense_tracker_app/constants/api.dart';
import 'package:expense_tracker_app/models/transaction.dart';
import 'package:expense_tracker_app/services/user_token_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:expense_tracker_app/models/user.dart';

Future<dynamic> getTransactionsData(int page) async {
  final token = await getUserToken();
  final res = await http.get(
    Uri.parse('$baseUrl/$transactionUrl?page=$page'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (res.statusCode == 200) {
    final json = jsonDecode(res.body);
    print(json);
    List<Transaction> transactions = [];

    for (var transaction in json['transactions']) {
      transactions.add(Transaction.fromJson(transaction));
    }
    return {"transactions": transactions, "nextPage": json['nextPage']};
  } else {
    return null;
  }
}

Future<User?> getUserData() async {
  final token = await getUserToken();
  final res = await http.get(
    Uri.parse('$baseUrl/$accountUrl'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (res.statusCode == 200) {
    final json = jsonDecode(res.body);
    return User.fromJson(json['user']);
  } else {
    return null;
  }
}

Future<bool> checkUsername(String username) async {
  final res = await http.get(
    Uri.parse('$baseUrl/$checkUsernameUrl?username=$username'),
  );

  return res.statusCode == 200;
}

Future<String?> loginUser(String username, String password) async {
  final res = await http.post(
    Uri.parse('$baseUrl/$loginUrl'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"username": username, "password": password}),
  );

  if (res.statusCode == 200) {
    final json = jsonDecode(res.body);
    return json['userToken'];
  } else {
    debugPrint("Login Failed");
    return null;
  }
}

Future<String?> signupUser(String username, String password) async {
  final res = await http.post(
    Uri.parse('$baseUrl/$signupUrl'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"username": username, "password": password}),
  );

  if (res.statusCode == 201) {
    final json = jsonDecode(res.body);
    return json['userToken'];
  } else {
    debugPrint("Signup Failed");
    return null;
  }
}

Future<bool> validUserToken() async {
  final token = await getUserToken();
  if (token == null) {
    return false;
  }

  final res = await http.get(
    Uri.parse('$baseUrl/$checkUserTokenUrl'),
    headers: {'Authorization': 'Bearer $token'},
  );

  return res.statusCode == 200;
}

Future<bool> logoutUser() async {
  final token = await getUserToken();
  final res = await http.get(
    Uri.parse('$baseUrl/$logoutUrl'),
    headers: {'Authorization': 'Bearer $token'},
  );

  return res.statusCode == 200;
}
