import 'dart:convert';
import 'package:expense_tracker_app/constants/api.dart';
import 'package:expense_tracker_app/models/transaction.dart';
import 'package:http/http.dart' as http;
import 'package:expense_tracker_app/models/user.dart';

Future<List<Transaction>> getTransactionsData(String token) async {
  final res = await http.get(
    Uri.parse('$baseUrl/$transactionUrl'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (res.statusCode == 200) {
    final json = jsonDecode(res.body);
    List<Transaction> transactions = [];

    for (var transaction in json['transactions']) {
      transactions.add(Transaction.fromJson(transaction));
    }
    return transactions;
  } else {
    throw Exception('Failed to fetch user');
  }
}

Future<User> getUserData(String token) async {
  final res = await http.get(
    Uri.parse('$baseUrl/$accountUrl'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (res.statusCode == 200) {
    final json = jsonDecode(res.body);
    return User.fromJson(json['user']);
  } else {
    throw Exception('Failed to fetch user');
  }
}
