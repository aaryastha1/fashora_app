import 'package:bloc_test/bloc_test.dart';
import 'package:fashora_app/features/product/presentation/view/favorite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_event.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_state.dart';
import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';

/// Mock FavoriteBloc
class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}

void main() {
  late MockFavoriteBloc mockFavoriteBloc;

  setUp(() {
    mockFavoriteBloc = MockFavoriteBloc();
  });

  tearDown(() {
    mockFavoriteBloc.close();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<FavoriteBloc>.value(
        value: mockFavoriteBloc,
        child: const WishlistScreen(userId: 'test_user'),
      ),
    );
  }

  testWidgets('displays loading indicator', (WidgetTester tester) async {
    when(() => mockFavoriteBloc.state).thenReturn(FavoriteLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays no favorites message when list is empty', (WidgetTester tester) async {
    when(() => mockFavoriteBloc.state).thenReturn(FavoriteLoaded([]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('No favorites yet.'), findsOneWidget);
  });

  testWidgets('renders favorite product list', (WidgetTester tester) async {
    final product = ProductEntity(
      id: '1',
      name: 'Pink Top',
      price: '1399',
      categoryName: 'Tops',
      sellerName: 'Seller 1',
      image: '',
      description: 'Soft pink stylish top.',
      stock: 10,
    );

    when(() => mockFavoriteBloc.state).thenReturn(FavoriteLoaded([product]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Pink Top'), findsOneWidget);
    expect(find.textContaining('Price: Rs.'), findsOneWidget);
    expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsWidgets); // ✅ Updated to allow multiple
  });

  testWidgets('shows error message when state is FavoriteError', (WidgetTester tester) async {
    when(() => mockFavoriteBloc.state).thenReturn(FavoriteError('Error loading favorites'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Error loading favorites'), findsOneWidget);
  });
}
