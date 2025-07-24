import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/domain/repository/product_repository.dart';

class SearchProductsUseCase {
  final IProductRepository repository;

  SearchProductsUseCase(this.repository);

  Future<List<ProductEntity>> call(String query) {
    return repository.searchProducts(query);
  }
}
