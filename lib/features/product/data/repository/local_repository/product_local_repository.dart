// import 'package:fashora_app/features/product/data/data_sorce/local_datasource/product_local_datasource.dart';
// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
// import 'package:fashora_app/features/product/domain/repository/product_repository.dart';


// class ProductLocalRepository implements IProductRepository {
//   final IProductLocalDataSource localDataSource;

//   ProductLocalRepository({required this.localDataSource});

//   @override
//   Future<List<ProductEntity>> getProductsByCategory(String categoryName) async {
//     // Since local cache may not have category filtering, 
//     // you can either filter locally or return all products
//     final products = await localDataSource.getCachedProducts();

//     // Filter by categoryName locally
//     final filtered = products.where((p) => p.categoryName.toLowerCase() == categoryName.toLowerCase()).toList();
//     return filtered;
//   }

//   // Optional: Add a method to save products locally
//   Future<void> cacheProducts(List<ProductEntity> products) async {
//     await localDataSource.cacheProducts(products);
//   }
// }
