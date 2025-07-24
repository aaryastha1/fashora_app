import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';



class UpdateQuantityUseCase {
  final ICartRepository repository;

  UpdateQuantityUseCase(this.repository);

  Future<CartEntity> call(String productId, int quantity) async {
    return await repository.updateQuantity(productId, quantity);
  }
}
