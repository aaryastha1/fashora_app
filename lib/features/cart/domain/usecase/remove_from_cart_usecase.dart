import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';



class RemoveFromCartUseCase {
  final ICartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<CartEntity> call(String productId) async {
    return await repository.removeFromCart(productId);
  }
}
