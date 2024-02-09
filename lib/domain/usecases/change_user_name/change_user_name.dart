import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import '../../entities/user.dart';
import 'change_user_name_params.dart';
import '../usecase.dart';

class ChangeUserName implements UseCase<Result<User>, ChangeUserNameParams> {
  final UserRepository _userRepository;

  ChangeUserName({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<User>> call(ChangeUserNameParams params) =>
      _userRepository.updateUserName(user: params.user, name: params.name);
}
