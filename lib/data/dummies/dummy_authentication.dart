import '../../domain/entities/result.dart';
import '../repositories/authentication.dart';

class DummyAuthentication implements Authentication {
  @override
  String? getLoggedInUserId() {
    // TODO: implement getLoggedInUserId
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));
    // return const Result.success("ID-123456");
    return const Result.failed("Gagal login ");
  }

  @override
  Future<Result<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> forgotPassword({required String email}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> changePassword(
      {required String email, required String password}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
}
