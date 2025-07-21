import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

import 'package:fashora_app/features/product/domain/repository/product_repository.dart';

class GetProductsByCategoryUseCase {
  final IProductRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<List<ProductEntity>> call(String categoryName) {
    return repository.getProductsByCategory(categoryName);
  }
}
