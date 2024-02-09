import '../../../data/repositories/authentication.dart';
import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import '../../entities/user.dart';
import '../usecase.dart';
import 'change_password_params.dart';

class ChangePassword implements UseCase<Result<User>, ChangePasswordParams> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  ChangePassword(
      {required Authentication authentication,
      required UserRepository userRepository})
      : _authentication = authentication,
        _userRepository = userRepository;

  @override
  Future<Result<User>> call(ChangePasswordParams params) async {
    var idResult = await _authentication.changePassword(
        email: params.email, password: params.password);
    if (idResult is Success) {
      var userResult =
          await _userRepository.getUser(uid: idResult.resultValue!);
      return switch (userResult) {
        Success(:final value) => Result.success(value),
        Failed(:final message) => Result.failed(message)
      };
    }
    return Result.failed(idResult.errorMessage!);
  }
}
