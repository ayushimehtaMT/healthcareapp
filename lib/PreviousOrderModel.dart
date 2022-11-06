class PreviousOrder {
  late final String? id;
  final double? amountPaid;
  final String? placedAt;
  final String? userId;
  final bool? inProgress;

  PreviousOrder({
    required this.id,
    required this.amountPaid,
    required this.placedAt,
    required this.userId,
    required this.inProgress
  });

  factory PreviousOrder.fromJson(Map<String, dynamic> json) {
    return PreviousOrder(
      id: json['id'] as String,
      amountPaid: 0.0 + json['amountPaid'],
      placedAt: json['placedAt'] as String,
      userId: json['userId'] as String,
      inProgress: json['inProgress'] as bool
    );
  }

  PreviousOrder.fromMap(Map<String, dynamic> res)
    : id = res['id'],
    amountPaid = res['amountPaid'],
    placedAt = res['placedAt'],
    userId = res['userId'],
    inProgress = res['inProgress'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'amountPaid': amountPaid,
      'placedAt': placedAt,
      'userId': userId,
      'inProgress': inProgress
    };
  }

  Map toJson() {
    return {
      'id': id,
      'amountPaid': amountPaid,
      'placedAt': placedAt,
      'userId': userId,
      'inProgress': inProgress
    };
  }
}