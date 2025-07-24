import 'package:fashora_app/features/order/data/model/order_model.dart';

abstract class IOrderRemoteDataSource {
  Future<void> placeOrder(OrderModel order);
}