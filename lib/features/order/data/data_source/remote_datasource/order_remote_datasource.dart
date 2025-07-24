import 'package:dio/dio.dart';
import 'package:fashora_app/features/order/data/data_source/datasource.dart';
import 'package:fashora_app/features/order/data/model/order_model.dart';

class OrderRemoteDataSourceImpl implements IOrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> placeOrder(OrderModel order) async {
    try {
      final jsonBody = order.toJson();
      ("Sending order: $jsonBody");

      final response = await dio.post(
        '/api/orders/place',
        data: jsonBody,
      );

      ("Response: ${response.statusCode} ${response.data}");

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      ("Order placement error: $e");
      rethrow;
    }
  }
}
