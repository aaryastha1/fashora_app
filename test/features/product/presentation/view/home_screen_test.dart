import 'package:bloc_test/bloc_test.dart';
import 'package:fashora_app/features/product/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashora_app/features/product/presentation/view_model/product_viewmodel.dart';
import 'package:fashora_app/features/product/presentation/view_model/product_state.dart';

class MockProductViewModel extends MockCubit<ProductState> implements ProductViewModel {}

void main() {
  late MockProductViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockProductViewModel();

    when(() => mockViewModel.state).thenReturn(ProductLoaded([]));

    // Mock async methods expected to be called in your UI
    when(() => mockViewModel.fetchProductsByCategory(any()))
        .thenAnswer((_) async => Future.value());

    when(() => mockViewModel.searchProducts(any()))
        .thenAnswer((_) async => Future.value());
  });

  testWidgets('renders search bar, categories, and grid when ProductLoaded',
      (WidgetTester tester) async {
    whenListen(
      mockViewModel,
      Stream<ProductState>.fromIterable([
        ProductLoaded([]),
      ]),
      initialState: ProductLoaded([]),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ProductViewModel>.value(
          value: mockViewModel,
          child: const FashoraHomeScreen(userId: 'testUser'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
