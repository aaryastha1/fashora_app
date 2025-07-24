

import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

abstract class IProductDataSource {
  /// Fetch products by category name (e.g., Tops, Dresses, Pants, etc.)
  Future<List<ProductEntity>> getProductsByCategory(String categoryName);



  Future<List<ProductEntity>> searchProducts(String query);


  
}












