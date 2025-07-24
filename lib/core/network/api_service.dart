



// import 'package:dio/dio.dart';
// import 'package:fashora_app/app/constant/api_endpoints.dart';
// import 'package:fashora_app/core/network/dio_error_interceptor.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   final Dio _dio;

//   Dio get dio => _dio;

//   ApiService(this._dio) {
//     _dio
//       ..options.baseUrl = ApiEndpoints.baseUrl
//       ..options.connectTimeout = ApiEndpoints.connectionTimeout
//       ..options.receiveTimeout = ApiEndpoints.receiveTimeout
//       ..interceptors.add(DioErrorInterceptor())
//       ..interceptors.add(
//         PrettyDioLogger(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: true,
//         ),
//       )
//       ..interceptors.add(InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           // Fetch token from SharedPreferences
//           final prefs = await SharedPreferences.getInstance();
//           final token = prefs.getString('token');
//           if (token != null && token.isNotEmpty) {
//             options.headers['Authorization'] = 'Bearer $token';
//           }
//           return handler.next(options); // continue with the request
//         },
//       ))
//       ..options.headers = {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       };
//   }
// }


import 'package:dio/dio.dart';
import 'package:fashora_app/app/constant/api_endpoints.dart';
import 'package:fashora_app/core/network/dio_error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      )
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final prefs = await SharedPreferences.getInstance();
            final token = prefs.getString('token');
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          },
        ),
      )
      ..options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
  }

  // ✅ HTTP GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters, options: options);
  }

  // ✅ HTTP POST
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters, options: options);
  }

 Future<Response> put(
  String path, {
  dynamic data,
  Map<String, dynamic>? queryParameters,
  Options? options,
}) async {
  return await _dio.put(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );
}


  // ✅ HTTP DELETE
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete(path, data: data, queryParameters: queryParameters, options: options);
  }
}
