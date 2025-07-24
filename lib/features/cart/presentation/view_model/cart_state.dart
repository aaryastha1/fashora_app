// import 'package:equatable/equatable.dart';
// import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';


// abstract class CartState extends Equatable {
//   const CartState();

//   @override
//   List<Object?> get props => [];
// }

// class CartInitial extends CartState {}

// class CartLoading extends CartState {}

// class CartLoaded extends CartState {
//   final CartEntity cart;

//   const CartLoaded(this.cart);

//   @override
//   List<Object?> get props => [cart];
// }

// class CartError extends CartState {
//   final String message;

//   const CartError(this.message);

//   @override
//   List<Object?> get props => [message];
// }



import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/cart/domain/entity/cart_entity.dart';

/// Base class for all Cart states.
abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action has been performed.
class CartInitial extends CartState {}

/// State emitted when the cart data is loading.
class CartLoading extends CartState {}

/// State emitted when the cart is loaded successfully.
class CartLoaded extends CartState {
  final CartEntity cart;

  const CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

/// State emitted when there is an error in cart operations.
class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
