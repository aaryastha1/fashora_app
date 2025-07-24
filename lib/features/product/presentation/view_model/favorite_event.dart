import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Load favorites from repository
class LoadFavoritesEvent extends FavoriteEvent {}

// Toggle a product favorite status
class ToggleFavoriteEvent extends FavoriteEvent {
  final String productId;

  ToggleFavoriteEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
