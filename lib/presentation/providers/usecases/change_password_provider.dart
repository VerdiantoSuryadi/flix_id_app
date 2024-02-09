import '../../../domain/usecases/change_password/change_password.dart';
import '../repositories/authentication/authentication_provider.dart';
import '../repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_password_provider.g.dart';

@riverpod
ChangePassword changePassword(ChangePasswordRef ref) => ChangePassword(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
