import 'package:dio/dio.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_item_entity.dart';

abstract class ICartRemoteDataSource {
  Future<CartEntity> getCart();
  Future<CartEntity> addToCart(String productId);
  Future<CartEntity> removeFromCart(String productId);
  Future<CartEntity> updateQuantity(String productId, int quantity);
  Future<void> clearCart();
}

class CartRemoteDataSourceImpl implements ICartRemoteDataSource {
  final Dio dio;

  CartRemoteDataSourceImpl({required this.dio});

  final String baseUrl = 'http://10.0.2.2:5006/api/cart';

  CartItemEntity _mapJsonToCartItem(Map<String, dynamic> json) {
    final product = json['product'] ?? {};

    return CartItemEntity(
      id: product['_id']?.toString() ?? '',
      name: product['name']?.toString() ?? 'Unknown',
      image: product['image']?.toString() ?? '',
      quantity: json['quantity'] is int
          ? json['quantity']
          : int.tryParse(json['quantity'].toString()) ?? 1,
      price: product['price'] is num
          ? (product['price'] as num).toDouble()
          : double.tryParse(product['price'].toString()) ?? 0.0,
    );
  }

  CartEntity _mapJsonToCartEntity(Map<String, dynamic> json) {
    final List<CartItemEntity> items = (json['items'] as List)
        .map((item) => _mapJsonToCartItem(item))
        .toList();

    return CartEntity(items: items);
  }

  @override
  Future<CartEntity> getCart() async {
    final response = await dio.get(baseUrl);
    return _mapJsonToCartEntity(response.data);
  }

  @override
  Future<CartEntity> addToCart(String productId) async {
    final response = await dio.post('$baseUrl/add', data: {'productId': productId});
    return _mapJsonToCartEntity(response.data);
  }

  @override
  Future<CartEntity> removeFromCart(String productId) async {
    final response = await dio.delete('$baseUrl/remove/$productId');
    return _mapJsonToCartEntity(response.data);
  }

  @override
  Future<CartEntity> updateQuantity(String productId, int quantity) async {
    final response = await dio.put(
      '$baseUrl/quantity',
      data: {'productId': productId, 'quantity': quantity},
    );
    return _mapJsonToCartEntity(response.data);
  }

  @override
  Future<void> clearCart() async {
    await dio.delete('$baseUrl/clear');
  }
}

