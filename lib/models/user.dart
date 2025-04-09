class User {
  final String username;
  final double currentBalance;

  User({required this.username, required this.currentBalance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      currentBalance: (json['currentBalance'] ?? 0).toDouble(),
    );
  }
}
