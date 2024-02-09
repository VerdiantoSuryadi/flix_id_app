import '../../../data/repositories/authentication.dart';
import 'forgot_password_params.dart';
import '../usecase.dart';

import '../../entities/result.dart';

class ForgotPassword implements UseCase<Result<void>, ForgotPasswordParams> {
  final Authentication _authentication;

  ForgotPassword({required Authentication authentication})
      : _authentication = authentication;
  @override
  Future<Result<void>> call(ForgotPasswordParams params) {
    return _authentication.forgotPassword(email: params.email);
  }
}
