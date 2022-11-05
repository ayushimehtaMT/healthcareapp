class CartItem {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? price;
  final int? quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as int,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
    );
  }

  CartItem.fromMap(Map<String, dynamic> res)
  : id = res['id'],
  productId = res['productId'],
  productName = res['productName'],
  price = res['price'],
  quantity = res['quantity'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
    };
  }
}