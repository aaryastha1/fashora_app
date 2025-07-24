import 'dart:convert'; // Needed for jsonDecode

import 'package:fashora_app/core/error/server_exception.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_item_entity.dart';
import 'package:fashora_app/core/network/api_service.dart';
import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements ICartRepository {
  final ApiService apiService;

  CartRepositoryImpl({required this.apiService});

  // Helper method to parse cart JSON into CartEntity
  CartEntity _parseCart(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];
    final items = itemsJson.map((itemJson) => CartItemEntity.fromJson(itemJson)).toList();
    return CartEntity(items: items);
  }

  @override
  Future<CartEntity> getCart() async {
    try {
      final response = await apiService.dio.get('/api/cart');
      if (response.statusCode == 200) {
        final data = response.data;
        final parsed = data is String ? jsonDecode(data) : data;
        return _parseCart(parsed);
      } else {
        throw ServerException('Failed to fetch cart');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CartEntity> addToCart(String productId) async {
    try {
      final response = await apiService.dio.post(
        '/api/cart/add',
        data: {'productId': productId},
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final parsed = data is String ? jsonDecode(data) : data;
        return _parseCart(parsed);
      } else {
        throw ServerException('Failed to add to cart');
      }
    } catch (e) {
      rethrow;
    }
  }
@override
Future<CartEntity> removeFromCart(String productId) async {
  try {
    final response = await apiService.dio.delete('/api/cart/remove/$productId');
    if (response.statusCode == 200) {
      final data = response.data;
      final parsed = data is String ? jsonDecode(data) : data;
      return _parseCart(parsed);
    } else {
      throw ServerException('Failed to remove from cart');
    }
  } catch (e) {
    throw ServerException('Remove from cart failed: $e');
  }
}

@override
Future<CartEntity> updateQuantity(String productId, int quantity) async {
  try {
    final response = await apiService.dio.put('/api/cart/quantity', data: {
      'productId': productId,
      'quantity': quantity,
    });
    if (response.statusCode == 200) {
      return _parseCart(response.data);
    } else {
      throw ServerException('Failed to update quantity');
    }
  } catch (e) {
    rethrow;
  }
}


  @override
  Future<void> clearCart() async {
    try {
      final response = await apiService.dio.post('/api/cart/clear');
      if (response.statusCode != 200) {
        throw ServerException('Failed to clear cart');
      }
    } catch (e) {
      rethrow;
    }
  }
}
