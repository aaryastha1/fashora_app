// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductApiModel _$ProductApiModelFromJson(Map<String, dynamic> json) =>
    ProductApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      price: json['price'] as String,
      categoryName: json['categoryName'] as String,
      sellerName: json['sellerName'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      stock: (json['stock'] as num).toInt(),
    );

Map<String, dynamic> _$ProductApiModelToJson(ProductApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'categoryName': instance.categoryName,
      'sellerName': instance.sellerName,
      'image': instance.image,
      'description': instance.description,
      'stock': instance.stock,
    };
