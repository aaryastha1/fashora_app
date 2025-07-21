// import 'package:equatable/equatable.dart';
// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'product_model.g.dart';

// @JsonSerializable()
// class ProductApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? id;
//   final String name;
//   final String price;
//   final String categoryName;
//   final String sellerName;
//   final String image;
//   final String description;
//   final int stock;

//   const ProductApiModel({
//     this.id,
//     required this.name,
//     required this.price,
//     required this.categoryName,
//     required this.sellerName,
//     required this.image,
//     required this.description,
//     required this.stock,
//   });

//   factory ProductApiModel.fromJson(Map<String, dynamic> json) =>
//       _$ProductApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$ProductApiModelToJson(this);

//   factory ProductApiModel.fromEntity(ProductEntity entity) {
//     return ProductApiModel(
//       id: entity.id,
//       name: entity.name,
//       price: entity.price,
//       categoryName: entity.categoryName,
//       sellerName: entity.sellerName,
//       image: entity.image,
//       description: entity.description,
//       stock: entity.stock,
//     );
//   }

//   ProductEntity toEntity() {
//     return ProductEntity(
//       id: id,
//       name: name,
//       price: price,
//       categoryName: categoryName,
//       sellerName: sellerName,
//       image: image,
//       description: description,
//       stock: stock,
//     );
//   }

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         price,
//         categoryName,
//         sellerName,
//         image,
//         description,
//         stock,
//       ];
// }


import 'package:equatable/equatable.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';


part 'product_model.g.dart';

class ProductApiModel extends Equatable {
  final String? id;
  final String name;
  final String price;
  final String categoryName;
  final String sellerName;
  final String image;
  final String description;
  final int stock;

  const ProductApiModel({
    this.id,
    required this.name,
    required this.price,
    required this.categoryName,
    required this.sellerName,
    required this.image,
    required this.description,
    required this.stock,
  });

  factory ProductApiModel.fromJson(Map<String, dynamic> json) {
    return ProductApiModel(
      id: json['_id']?.toString(),
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      categoryName: json['categoryName']?.toString() ?? '',
      sellerName: json['sellerName']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      stock: json['stock'] is int
          ? json['stock']
          : int.tryParse(json['stock']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'categoryName': categoryName,
      'sellerName': sellerName,
      'image': image,
      'description': description,
      'stock': stock,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      price: price,
      categoryName: categoryName,
      sellerName: sellerName,
      image: image,
      description: description,
      stock: stock,
    );
  }

  factory ProductApiModel.fromEntity(ProductEntity entity) {
    return ProductApiModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      categoryName: entity.categoryName,
      sellerName: entity.sellerName,
      image: entity.image,
      description: entity.description,
      stock: entity.stock,
    );
  }

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
}
