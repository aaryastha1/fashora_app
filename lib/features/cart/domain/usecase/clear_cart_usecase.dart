import 'package:fashora_app/features/cart/domain/repository/cart_repository.dart';



class ClearCartUseCase {
  final ICartRepository repository;

  ClearCartUseCase(this.repository);

  Future<void> call() async {
    await repository.clearCart();
  }
}
