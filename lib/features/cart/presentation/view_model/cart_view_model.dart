import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';
import 'package:fashora_app/features/cart/domain/usecase/add_to_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/clear_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/remove_from_cart_usecase.dart';
import 'package:fashora_app/features/cart/domain/usecase/update_quantity_usecase.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateQuantityUseCase updateQuantityUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateQuantityUseCase,
    required this.clearCartUseCase,
  }) : super(CartInitial()) {
    on<LoadCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final CartEntity cart = await getCartUseCase();
        emit(CartLoaded(cart));
      } catch (e) {
        emit(CartError('Failed to load cart: ${e.toString()}'));
      }
    });

    on<AddToCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final CartEntity cart = await addToCartUseCase(event.productId);
        emit(CartLoaded(cart));
      } catch (e) {
        emit(CartError('Failed to add to cart: ${e.toString()}'));
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final CartEntity cart = await removeFromCartUseCase(event.productId);
        emit(CartLoaded(cart));
      } catch (e) {
        emit(CartError('Failed to remove from cart: ${e.toString()}'));
      }
    });

    on<UpdateQuantityEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final CartEntity cart =
            await updateQuantityUseCase(event.productId, event.quantity);
        emit(CartLoaded(cart));
      } catch (e) {
        emit(CartError('Failed to update quantity: ${e.toString()}'));
      }
    });

    on<ClearCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        await clearCartUseCase();
        emit(CartLoaded(CartEntity(items: const []))); // empty cart
      } catch (e) {
        emit(CartError('Failed to clear cart: ${e.toString()}'));
      }
    });
  }
}
