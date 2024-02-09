import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../domain/entities/result.dart';
import '../repositories/authentication.dart';

class FirebaseAuthentication implements Authentication {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthentication({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => _firebaseAuth.currentUser?.uid;

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message ?? 'Failed to login');
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _firebaseAuth.signOut();
    if (_firebaseAuth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed('Failed to sign out');
    }
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message ?? 'Failed to register');
    }
  }

  @override
  Future<Result<void>> forgotPassword({required String email}) async {
    try {
      QuerySnapshot query =
          await FirebaseFirestore.instance.collection('users').get();
      final allEmail = query.docs.map((e) => e['email']).toList();
      log(email.split('.').toString());
      bool isValid = EmailValidator.validate(email);
      if (allEmail.contains(email) && isValid) {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
        return const Result.success(null);
      } else if (email.isEmpty) {
        return const Result.failed('Please type your email');
      } else if (!isValid) {
        return const Result.failed('Email is badly formatted');
      } else {
        return const Result.failed('User doesn\'t exists');
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      log(e.toString());
      return Result.failed(e.message ?? "Failed to send reset password mail");
    }
  }

  @override
  Future<Result<String>> changePassword(
      {required String email, required String password}) async {
    try {
      var user = _firebaseAuth.currentUser!;
      var cred = firebase_auth.EmailAuthProvider.credential(
          email: user.email!, password: password);
      var userCredential = await user
          .updatePassword(password)
          .then((value) => user.reauthenticateWithCredential(cred));
      return Result.success(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Result.failed(e.message ?? "Failed to change password");
    }
  }
}
