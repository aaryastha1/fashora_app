import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  
  @override
  List<Object> get props => [];
}

class FetchProductsByCategory extends ProductEvent {
  final String categoryName;

  const FetchProductsByCategory(this.categoryName);

  @override
  List<Object> get props => [categoryName];
}
