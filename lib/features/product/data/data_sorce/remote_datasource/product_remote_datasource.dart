import 'package:dio/dio.dart';
import 'package:fashora_app/app/constant/api_endpoints.dart';
import 'package:fashora_app/core/network/api_service.dart';
import 'package:fashora_app/features/product/data/data_sorce/product_data_source.dart';

import 'package:fashora_app/features/product/data/model/product_model.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';


class ProductRemoteDataSource implements IProductDataSource {
  final ApiService _apiService;

  ProductRemoteDataSource({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<ProductEntity>> getProductsByCategory(String categoryName) async {
    try {
      final response = await _apiService.dio.get(
      ApiEndpoints.getProductsByCategory,
  queryParameters: {'categoryName': categoryName},
);


      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];
        final products = productsJson
            .map((json) => ProductApiModel.fromJson(json).toEntity())
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load products: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
