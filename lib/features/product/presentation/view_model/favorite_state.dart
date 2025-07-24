import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/product/domain/entity/favorite_entity.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}
class FavoriteLoaded extends FavoriteState {
  final List<ProductEntity> favorites; // new

  FavoriteLoaded(this.favorites);
}


class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);

  @override
  List<Object?> get props => [message];
}
