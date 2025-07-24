import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';



abstract class ICartRepository {
  Future<CartEntity> getCart();
  Future<CartEntity> addToCart(String productId);
  Future<CartEntity> removeFromCart(String productId);
  Future<CartEntity> updateQuantity(String productId, int quantity);
  Future<void> clearCart();
}
