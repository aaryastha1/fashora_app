// import 'package:fashora_app/features/product/presentation/view_model/favorite_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import 'package:fashora_app/features/product/domain/entity/product_entity.dart';
// import 'package:fashora_app/features/product/domain/use_case/get_favorite.dart';
// import 'package:fashora_app/features/product/presentation/view_model/favorite_event.dart';
// import 'package:fashora_app/features/product/presentation/view_model/favorite_state.dart';


// // MOCKS

// class MockGetFavoritesUseCase extends Mock implements GetFavoritesUseCase {}

// class MockToggleFavoriteUseCase extends Mock implements ToggleFavoriteUseCase {}

// class FakeFavoriteEvent extends Fake implements FavoriteEvent {}

// void main() {
//   late MockGetFavoritesUseCase mockGetFavoritesUseCase;
//   late MockToggleFavoriteUseCase mockToggleFavoriteUseCase;
//   late FavoriteViewModel favoriteViewModel;

//   // Use your full ProductEntity constructor here:
//   final product = ProductEntity(
//     id: '1',
//     name: 'T-Shirt',
//     price: '1000',
//     categoryName: 'Tops',
//     sellerName: 'Fashora',
//     image: 'tshirt.jpg',
//     description: 'A comfortable cotton t-shirt',
//     stock: 15,
//   );

//   setUpAll(() {
//     registerFallbackValue(FakeFavoriteEvent());
//   });

//   setUp(() {
//     mockGetFavoritesUseCase = MockGetFavoritesUseCase();
//     mockToggleFavoriteUseCase = MockToggleFavoriteUseCase();
//     favoriteViewModel = FavoriteViewModel(
//       getFavoritesUseCase: mockGetFavoritesUseCase,
//       toggleFavoriteUseCase: mockToggleFavoriteUseCase,
//     );
//   });

//   // testWidgets('FavoriteViewModel loads favorites and emits states', (tester) async {
//   //   when(() => mockGetFavoritesUseCase()).thenAnswer((_) async => [product]);

//   //   await tester.pumpWidget(
//   //     MaterialApp(
//   //       home: Scaffold(
//   //         body: Builder(
//   //           builder: (context) {
//   //             WidgetsBinding.instance.addPostFrameCallback((_) {
//   //               favoriteViewModel.add(LoadFavoritesEvent());
//   //             });
//   //             return Container(key: const Key('fav_container'));
//   //           },
//   //         ),
//   //       ),
//   //     ),
//   //   );

//   //   await tester.pumpAndSettle();

//   //   expect(favoriteViewModel.state, isA<FavoriteLoaded>());
//   //   final loadedState = favoriteViewModel.state as FavoriteLoaded;
//   //   expect(loadedState.favorites.length, 1);
//   //   expect(loadedState.favorites.first.name, 'T-Shirt');

//   //   verify(() => mockGetFavoritesUseCase()).called(1);
//   // });

// //   testWidgets('FavoriteViewModel toggles favorite and reloads favorites', (tester) async {
// //  when(() => mockToggleFavoriteUseCase('1')).thenAnswer((_) async => true);

// //     when(() => mockGetFavoritesUseCase()).thenAnswer((_) async => [product]);

// //     await tester.pumpWidget(
// //       MaterialApp(
// //         home: Scaffold(
// //           body: Builder(
// //             builder: (context) {
// //               WidgetsBinding.instance.addPostFrameCallback((_) {
// //                 favoriteViewModel.add(ToggleFavoriteEvent('1'));
// //               });
// //               return Container(key: const Key('fav_toggle_container'));
// //             },
// //           ),
// //         ),
// //       ),
// //     );

// //     await tester.pumpAndSettle();

// //     expect(favoriteViewModel.state, isA<FavoriteLoaded>());
// //     final loadedState = favoriteViewModel.state as FavoriteLoaded;
// //     expect(loadedState.favorites.length, 1);
// //     expect(loadedState.favorites.first.name, 'T-Shirt');

// //     verify(() => mockToggleFavoriteUseCase('1')).called(1);
// //     verify(() => mockGetFavoritesUseCase()).called(1);
// //   });

//   testWidgets('FavoriteViewModel emits error when getFavorites fails', (tester) async {
//     when(() => mockGetFavoritesUseCase()).thenThrow(Exception('Load failed'));

//     await tester.pumpWidget(
//       MaterialApp(
//         home: Scaffold(
//           body: Builder(
//             builder: (context) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 favoriteViewModel.add(LoadFavoritesEvent());
//               });
//               return Container(key: const Key('fav_error_container'));
//             },
//           ),
//         ),
//       ),
//     );

//     await tester.pumpAndSettle();

//     expect(favoriteViewModel.state, isA<FavoriteError>());
//     final errorState = favoriteViewModel.state as FavoriteError;
//     expect(errorState.message, contains('Load failed'));

//     verify(() => mockGetFavoritesUseCase()).called(1);
//   });
// }
