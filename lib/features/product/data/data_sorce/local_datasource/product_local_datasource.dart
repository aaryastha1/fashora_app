// import 'package:hive/hive.dart';
// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';

// abstract class IProductLocalDataSource {
//   Future<void> cacheProducts(List<ProductEntity> products);
//   Future<List<ProductEntity>> getCachedProducts();
//   Future<void> clearCache();
// }

// class ProductLocalDataSource implements IProductLocalDataSource {
//   static const String _boxName = 'productBox';

//   final HiveInterface hive;

//   ProductLocalDataSource({required this.hive});

//   @override
//   Future<void> cacheProducts(List<ProductEntity> products) async {
//     final box = await hive.openBox<ProductEntity>(_boxName);
//     await box.clear();
//     for (var product in products) {
//       await box.put(product.id, product);
//     }
//   }

//   @override
//   Future<List<ProductEntity>> getCachedProducts() async {
//     final box = await hive.openBox<ProductEntity>(_boxName);
//     return box.values.toList();
//   }

//   @override
//   Future<void> clearCache() async {
//     final box = await hive.openBox<ProductEntity>(_boxName);
//     await box.clear();
//   }
// }
