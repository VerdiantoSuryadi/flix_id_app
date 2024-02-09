import '../../../domain/usecases/forgot_password/forgot_password.dart';
import '../repositories/authentication/authentication_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'forgot_password_provider.g.dart';

@riverpod
ForgotPassword forgotPassword(ForgotPasswordRef ref) =>
    ForgotPassword(authentication: ref.watch(authenticationProvider));
