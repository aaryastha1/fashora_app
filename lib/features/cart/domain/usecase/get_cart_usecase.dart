import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';



class GetCartUseCase {
  final ICartRepository repository;

  GetCartUseCase(this.repository);

  Future<CartEntity> call() async {
    return await repository.getCart();
  }
}
