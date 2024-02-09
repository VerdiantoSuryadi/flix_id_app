import '../../../domain/usecases/change_user_name/change_user_name.dart';
import '../repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_user_name_provider.g.dart';

@riverpod
ChangeUserName changeUserName(ChangeUserNameRef ref) =>
    ChangeUserName(userRepository: ref.watch(userRepositoryProvider));
