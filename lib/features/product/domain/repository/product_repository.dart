import 'package:fashora_app/features/product/data/data_sorce/product_data_source.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

abstract class IProductRepository {
  /// Fetch list of products by category name
  Future<List<ProductEntity>> getProductsByCategory(String categoryName);


  Future<List<ProductEntity>> searchProducts(String query);


  
}

class ProductRemoteRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRemoteRepository({required this.dataSource});

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryName) {
    return dataSource.getProductsByCategory(categoryName);
  }


  @override
Future<List<ProductEntity>> searchProducts(String query) {
  return dataSource.searchProducts(query);
}




  


}
