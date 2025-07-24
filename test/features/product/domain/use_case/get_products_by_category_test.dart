import 'package:fashora_app/features/product/domain/use_case/get_products_by_category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/domain/repository/product_repository.dart';


class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late MockProductRepository mockRepository;
  late GetProductsByCategoryUseCase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProductsByCategoryUseCase(mockRepository);
  });

  final categoryName = 'Tops';

  final products = [
    const ProductEntity(
      id: '1',
      name: 'Blue Shirt',
      price: '1000',
      categoryName: 'Tops',
      sellerName: 'Seller A',
      image: 'image1.png',
      description: 'A nice blue shirt',
      stock: 10,
    ),
    const ProductEntity(
      id: '2',
      name: 'Red Shirt',
      price: '1200',
      categoryName: 'Tops',
      sellerName: 'Seller B',
      image: 'image2.png',
      description: 'A bright red shirt',
      stock: 5,
    ),
  ];

  test('should get list of products for given category', () async {
    // Arrange
    when(() => mockRepository.getProductsByCategory(categoryName))
        .thenAnswer((_) async => products);

    // Act
    final result = await usecase(categoryName);

    // Assert
    expect(result, products);
    verify(() => mockRepository.getProductsByCategory(categoryName)).called(1);
  });
}
