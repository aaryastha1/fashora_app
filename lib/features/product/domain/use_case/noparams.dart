// lib/core/usecase/usecase.dart
import 'package:dartz/dartz.dart';
import 'package:fashora_app/core/error/failure.dart';


abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
