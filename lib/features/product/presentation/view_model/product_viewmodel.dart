// import 'package:fashora_app/features/product/domain/use_case/get_products_by_category.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'product_event.dart';
// import 'product_state.dart';


// class ProductViewModel extends Cubit<ProductState> {
//   final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

//   ProductViewModel(this.getProductsByCategoryUseCase) : super(ProductInitial());

//   Future<void> fetchProductsByCategory(String categoryName) async {
//     emit(ProductLoading());
//     try {
//       final products = await getProductsByCategoryUseCase(categoryName);
//       emit(ProductLoaded(products));
//     } catch (e) {
//       emit(ProductError(e.toString()));
//     }
//   }


  
// }




import 'package:fashora_app/features/product/domain/use_case/search_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashora_app/features/product/domain/use_case/get_products_by_category.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductViewModel extends Cubit<ProductState> {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  ProductViewModel({
    required this.getProductsByCategoryUseCase,
    required this.searchProductsUseCase,
  }) : super(ProductInitial());

  Future<void> fetchProductsByCategory(String categoryName) async {
    emit(ProductLoading());
    try {
      final products = await getProductsByCategoryUseCase(categoryName);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> searchProducts(String query) async {
    emit(ProductLoading());
    try {
      final products = await searchProductsUseCase(query);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}



