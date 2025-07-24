import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import 'package:fashora_app/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/get_cart_usecase.dart';

class CartBlocFavorite extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartUseCase getCartUseCase;

  CartBlocFavorite({
    required this.addToCartUseCase,
    required this.getCartUseCase,
  }) : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      emit(CartLoading());
      try {
        final cart = await getCartUseCase();
        emit(CartLoaded(cart));
      } catch (_) {
        emit(CartError("Failed to load cart"));
      }
    });

    on<AddProductToCart>((event, emit) async {
      emit(CartLoading());
      try {
        final cart = await addToCartUseCase(event.productId);
        emit(CartLoaded(cart));
      } catch (_) {
        emit(CartError("Failed to add product to cart"));
      }
    });
  }
}
