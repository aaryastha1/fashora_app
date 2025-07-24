
// // core/error/server_failure.dart

// import 'failure.dart';

// class ServerFailure extends Failure {
//   const ServerFailure(String s, {required super.message});
// }


import 'package:fashora_app/core/error/failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}
