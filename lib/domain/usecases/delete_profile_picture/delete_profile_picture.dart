import '../../../data/repositories/user_repository.dart';
import '../../entities/user.dart';
import 'delete_profile_picture_params.dart';
import '../usecase.dart';

import '../../entities/result.dart';

class DeleteProfilePicture
    implements UseCase<Result<User>, DeleteProfilePictureParams> {
  final UserRepository _userRepository;

  DeleteProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<User>> call(DeleteProfilePictureParams params) =>
      _userRepository.deleteProfilePicture(user: params.user);
}
