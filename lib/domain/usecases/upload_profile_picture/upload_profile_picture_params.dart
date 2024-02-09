import 'dart:io';

import '../../entities/user.dart';

class UploadProfilePictureParams {
  final File imageFile;
  final User user;

  UploadProfilePictureParams({required this.imageFile, required this.user});
}
