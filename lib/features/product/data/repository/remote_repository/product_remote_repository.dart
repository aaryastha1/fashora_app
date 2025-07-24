import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/data/data_sorce/product_data_source.dart'; // adjust path if needed
import 'package:fashora_app/features/product/domain/repository/product_repository.dart';

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
