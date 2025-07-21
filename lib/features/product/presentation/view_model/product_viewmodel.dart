import 'package:fashora_app/features/product/domain/use_case/get_products_by_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';


class ProductViewModel extends Cubit<ProductState> {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  ProductViewModel(this.getProductsByCategoryUseCase) : super(ProductInitial());

  Future<void> fetchProductsByCategory(String categoryName) async {
    emit(ProductLoading());
    try {
      final products = await getProductsByCategoryUseCase(categoryName);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
