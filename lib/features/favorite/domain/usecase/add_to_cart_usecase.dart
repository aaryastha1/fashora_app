// domain/usecase/add_to_cart_usecase.dart
import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';

class AddToCartUseCase {
  final ICartRepository repository;

  AddToCartUseCase(this.repository);

  Future<CartEntity> call(String productId) async {
    return await repository.addToCart(productId);
  }
}
