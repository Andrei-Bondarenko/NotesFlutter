import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes/features/auth/domain/repository/auth_local_repository.dart';

class AuthLocalRepositoryImpl implements AuthLocalRepository {

  User? _user;

  final _controller = StreamController<User?>.broadcast();

  @override
  Stream<User?> get userStream => _controller.stream;

  @override
  User? getUser() {
    return _user;
  }

  @override
  void saveUser(user) {
    _user = user;
    _addToStream(user);
    debugPrint('USER  SAVE => $user');
  }

  void _addToStream(User? user) => _controller.sink.add(user);

  @override
  void logOut() {
    _user = null;
    _addToStream(null);
  }
}
