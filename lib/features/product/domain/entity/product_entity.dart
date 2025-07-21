import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String name;
  final String price;
  final String categoryName;
  final String sellerName;
  final String image;
  final String description;
  final int stock;

  const ProductEntity({
    this.id,
    required this.name,
    required this.price,
    required this.categoryName,
    required this.sellerName,
    required this.image,
    required this.description,
    required this.stock,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        categoryName,
        sellerName,
        image,
        description,
        stock,
      ];

  factory ProductEntity.empty() {
    return const ProductEntity(
      id: null,
      name: '',
      price: '',
      categoryName: '',
      sellerName: '',
      image: '',
      description: '',
      stock: 0,
    );
  }
}
