import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

abstract class IFavoriteDataSource {
  Future<List<ProductEntity>> getFavorites();
  Future<bool> toggleFavorite(String productId);
}
