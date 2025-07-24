import 'package:fashora_app/core/network/api_service.dart';
import 'package:fashora_app/features/product/data/data_sorce/favorite_data_source.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

class FavoriteRemoteDataSource implements IFavoriteDataSource {
  final ApiService apiService;

  FavoriteRemoteDataSource(this.apiService);

  @override
  Future<List<ProductEntity>> getFavorites() async {
    try {
      final response = await apiService.get('/api/favorites');
      final List data = response.data['favorites'];
      return data.map((json) => ProductEntity(
            id: json['_id'],
            name: json['name'],
            price: json['price'].toString(),
            categoryName: json['categoryId'],
            sellerName: json['sellerId'],
            image: json['image'],
            description: json['description'],
            stock: json['stock'],
          )).toList();
    } catch (e) {
      throw Exception('Failed to load favorites: $e');
    }
  }

  @override
  Future<bool> toggleFavorite(String productId) async {
    try {
      final response = await apiService.post(
        '/api/favorites/toggle',
        data: {'productId': productId},
      );
      return response.data['isFavorite'];
    } catch (e) {
      throw Exception('Failed to toggle favorite: $e');
    }
  }
}
