class CartItemEntity {
  final String id;
  final String name;
  final String? image;
  final int quantity;
  final double price;

  CartItemEntity({
    required this.id,
    required this.name,
    this.image,
    required this.quantity,
    required this.price,
  });

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};

    return CartItemEntity(
      id: product['_id'] ?? product['id'] ?? '',
      name: product['name'] ?? '',
      image: product['image'],
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 1,
      price: product['price'] is num
          ? (product['price'] as num).toDouble()
          : double.tryParse(product['price'].toString()) ?? 0.0,
    );
  }
}
