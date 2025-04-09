class Transaction {
  final String id;
  final double value;
  final String type;
  final String message;
  final int createdAt;

  Transaction({
    required this.id,
    required this.value,
    required this.type,
    required this.message,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['_id'],
      value: json['value'].toDouble(),
      type: json['type'],
      message: json['message'],
      createdAt: json['createdAt'],
    );
  }
}
