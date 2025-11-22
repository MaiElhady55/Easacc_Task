import 'package:dartz/dartz.dart';
import 'package:easacc_task/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> loginByGoogle();
  Future<Either<Failure, String>> loginByFacebook();
}
