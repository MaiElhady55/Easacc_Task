import 'package:dartz/dartz.dart';
import 'package:easacc_task/core/errors/failures.dart';
import 'package:easacc_task/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:easacc_task/features/auth/data/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> loginByGoogle() async {
    try {
      final message = await authRemoteDataSource.loginByGoogle();
      return Right(message);
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginByFacebook() async {
    try {
      final message = await authRemoteDataSource.loginByFacebook();
      return Right(message);
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }
}
