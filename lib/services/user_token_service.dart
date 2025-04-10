import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveUserToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userToken', token);
  print("Saved user token $token");
}

Future<String?> getUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('userToken');
  return token;
}

Future<void> reset() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
