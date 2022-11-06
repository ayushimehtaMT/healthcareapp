class Medicine {
  late final int? id;
  final String? productId;
  final String? productName;
  final double? price;
  final int? quantity;
  final String? description;

  Medicine({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.description
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
        id: json['id'] as int,
        productId: json['productId'] as String,
        productName: json['productName'] as String,
        price: json['price'] as double,
        quantity: json['quantity'] as int,
        description: json['description'] as String
    );
  }

  Medicine.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        price = res['price'],
        quantity = res['quantity'],
        description = res['description'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'description': description
    };
  }

  Map toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'description': description
    };
  }
}