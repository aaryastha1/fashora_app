import 'package:fashora_app/features/product/domain/use_case/search_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/domain/repository/product_repository.dart';


class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late MockProductRepository mockRepository;
  late SearchProductsUseCase usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = SearchProductsUseCase(mockRepository);
  });

  final query = 'Basic Top';

  final products = [
    const ProductEntity(
      id: '1',
      name: 'Basic Top',
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

  test('returns list of products when searchProducts is called', () async {
    when(() => mockRepository.searchProducts(query))
        .thenAnswer((_) async => products);

    final result = await usecase(query);

    expect(result, products);
    verify(() => mockRepository.searchProducts(query)).called(1);
  });
}
