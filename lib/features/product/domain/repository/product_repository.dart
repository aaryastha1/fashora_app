import 'package:fashora_app/features/product/data/data_sorce/product_data_source.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

abstract class IProductRepository {
  /// Fetch list of products by category name
  Future<List<ProductEntity>> getProductsByCategory(String categoryName);

  
}

class ProductRemoteRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRemoteRepository({required this.dataSource});

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryName) {
    return dataSource.getProductsByCategory(categoryName);
  }
}
