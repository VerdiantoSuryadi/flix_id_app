import '../../../data/repositories/user_repository.dart';
import '../../entities/result.dart';
import '../../entities/user.dart';
import '../usecase.dart';
import 'upload_profile_picture_params.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParams> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<User>> call(UploadProfilePictureParams params) =>
      _userRepository.uploadProfilePicture(
          user: params.user, imageFile: params.imageFile);
}
