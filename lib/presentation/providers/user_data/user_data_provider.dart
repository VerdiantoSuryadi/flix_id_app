import 'dart:io';

import '../../../domain/usecases/change_user_name/change_user_name.dart';
import '../../../domain/usecases/change_user_name/change_user_name_params.dart';
import '../usecases/change_user_name_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/result.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/change_password/change_password.dart';
import '../../../domain/usecases/change_password/change_password_params.dart';
import '../../../domain/usecases/delete_profile_picture/delete_profile_picture.dart';
import '../../../domain/usecases/delete_profile_picture/delete_profile_picture_params.dart';
import '../../../domain/usecases/forgot_password/forgot_password.dart';
import '../../../domain/usecases/forgot_password/forgot_password_params.dart';
import '../../../domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import '../../../domain/usecases/login/login.dart';
import '../../../domain/usecases/register/register.dart';
import '../../../domain/usecases/register/register_params.dart';
import '../../../domain/usecases/top_up/top_up.dart';
import '../../../domain/usecases/top_up/top_up_params.dart';
import '../../../domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import '../../../domain/usecases/upload_profile_picture/upload_profile_picture_params.dart';
import '../movie/movie_detail_provider.dart';
import '../movie/now_playing_provider.dart';
import '../movie/upcoming_provider.dart';
import '../repositories/movie_repository/movie_repository_provider.dart';
import '../transaction_data/transaction_data_provider.dart';
import '../usecases/change_password_provider.dart';
import '../usecases/delete_profile_picture_provider.dart';
import '../usecases/forgot_password_provider.dart';
import '../usecases/get_logged_in_user_provider.dart';
import '../usecases/login_provider.dart';
import '../usecases/logout_provider.dart';
import '../usecases/register_provider.dart';
import '../usecases/top_up_provider.dart';
import '../usecases/upload_profile_picture_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    var userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();

    Login login = ref.read(loginProvider);

    var result = await login(LoginParams(email: email, password: password));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String name,
      String? imageUrl}) async {
    state = const AsyncLoading();

    Register register = ref.read(registerProvider);

    var result = await register(RegisterParams(
        name: name, email: email, password: password, photoUrl: imageUrl));

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);

    var result = await getLoggedInUser(null);

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    var logout = ref.read(logoutProvider);

    ref.invalidate(transactionDataProvider);
    ref.invalidate(movieDetailProvider);
    ref.invalidate(movieRepositoryProvider);
    var result = await logout(null);

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    TopUp topUp = ref.read(topUpProvider);
    String? userId = state.valueOrNull?.uid;

    if (userId != null) {
      var result = await topUp(TopUpParams(amount: amount, userId: userId));
      if (result.isSuccess) {
        refreshUserData();
        ref.read(transactionDataProvider.notifier).refreshTransactionData();
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    var result = await uploadProfilePicture(
        UploadProfilePictureParams(imageFile: imageFile, user: user));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProvider.notifier).getMovies();
    ref.read(upComingProvider.notifier).getMovies();
  }

  Future<void> deleteProfilePicture({required User user}) async {
    DeleteProfilePicture deleteProfilePicture =
        ref.read(deleteProfilePictureProvider);
    var result =
        await deleteProfilePicture(DeleteProfilePictureParams(user: user));
    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    state = const AsyncLoading();

    ForgotPassword forgotPassword = ref.read(forgotPasswordProvider);

    var result = await forgotPassword(ForgotPasswordParams(email: email));

    if (result case Success(value: _)) {
      state = const AsyncData(null);
      return true;
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = const AsyncData(null);
      return false;
    }
  }

  Future<void> changePassword(
      {required String email, required String password}) async {
    state = const AsyncLoading();

    ChangePassword changePassword = ref.read(changePasswordProvider);

    if (state.valueOrNull != null) {
      var result = await changePassword(
          ChangePasswordParams(email: email, password: password));
      switch (result) {
        case Success(value: final user):
          state = AsyncData(user);
        case Failed(:final message):
          state = AsyncError(FlutterError(message), StackTrace.current);
          state = AsyncData(state.valueOrNull);
      }
    }
  }

  Future<void> changeUserName(
      {required User user, required String name}) async {
    ChangeUserName changeUserName = ref.read(changeUserNameProvider);

    var result =
        await changeUserName(ChangeUserNameParams(user: user, name: name));

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }
}
