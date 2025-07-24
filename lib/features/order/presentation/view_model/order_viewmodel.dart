// features/order/presentation/view_model/order_view_model.dart

import 'package:fashora_app/features/order/domain/usecase/order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fashora_app/core/error/failure.dart';


import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final IPlaceOrderUseCase placeOrderUseCase;

  OrderBloc({required this.placeOrderUseCase}) : super(OrderInitial()) {
    on<PlaceOrderEvent>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(
    PlaceOrderEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());

    final failureOrSuccess = await placeOrderUseCase.placeOrder(event.order);

    failureOrSuccess.fold(
      (failure) => emit(OrderFailure(_mapFailureToMessage(failure))),
      (_) => emit(OrderSuccess()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // You can customize failure messages based on Failure type
    return failure.message ?? 'Unexpected error occurred';
  }
}
