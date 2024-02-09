import '../../entities/user.dart';

class ChangeUserNameParams {
  final User user;
  final String name;

  ChangeUserNameParams({required this.user, required this.name});
}
