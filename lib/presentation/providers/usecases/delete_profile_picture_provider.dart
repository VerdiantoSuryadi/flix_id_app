import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/delete_profile_picture/delete_profile_picture.dart';
import '../repositories/user_repository/user_repository_provider.dart';

part 'delete_profile_picture_provider.g.dart';

@riverpod
DeleteProfilePicture deleteProfilePicture(DeleteProfilePictureRef ref) =>
    DeleteProfilePicture(userRepository: ref.watch(userRepositoryProvider));
