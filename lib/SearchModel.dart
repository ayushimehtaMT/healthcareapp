class SearchItem {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? price;
  int? quantity;
  final String? description;

  SearchItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.description
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      id: json['id'] as int,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      description: json['description'] as String
    );
  }

  SearchItem.fromMap(Map<String, dynamic> res)
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