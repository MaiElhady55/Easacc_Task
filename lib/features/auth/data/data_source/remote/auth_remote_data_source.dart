abstract class AuthRemoteDataSource {
  Future<String> loginByGoogle();
  Future<String> loginByFacebook();
}
