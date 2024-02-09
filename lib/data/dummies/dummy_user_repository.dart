import 'dart:io';

import '../../domain/entities/result.dart';
import '../../domain/entities/user.dart';
import '../repositories/user_repository.dart';

class DummyUserRepository implements UserRepository {
  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser({required String uid}) async {
    await Future.delayed(const Duration(seconds: 2));
    var user = User(uid: uid, email: 'dummy@gmail.com', name: 'dummy');
    return Result.success(user);
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUser({required User user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) {
    // TODO: implement updateUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> uploadProfilePicture(
      {required User user, required File imageFile}) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> deleteProfilePicture({required User user}) {
    // TODO: implement deleteProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUserName(
      {required User user, required String name}) {
    // TODO: implement updateUserName
    throw UnimplementedError();
  }
}
