abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddProductToCart extends CartEvent {
  final String productId;

  AddProductToCart(this.productId);
}
