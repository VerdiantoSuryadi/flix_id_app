import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import '../usecase.dart';
import 'get_user_balance_params.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParams> {
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<int>> call(GetUserBalanceParams params) =>
      _userRepository.getUserBalance(uid: params.userId);
}
