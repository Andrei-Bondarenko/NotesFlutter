import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/features/auth/domain/repository/auth_local_repository.dart';
import 'package:notes/features/auth/domain/repository/auth_remote_repository.dart';

class AuthInteractor {
  final AuthRemoteRepository _authRemoteRepository;
  final AuthLocalRepository _authLocalRepository;

  AuthInteractor({
    required AuthRemoteRepository authRemoteRepository,
    required AuthLocalRepository authLocalRepository,
  }) : _authRemoteRepository = authRemoteRepository,
  _authLocalRepository = authLocalRepository;

  Stream<User?> observeRemoteUser() {
    return _authRemoteRepository.observeAuthState();
  }

  Stream<User?> observeLocalUser() {
    return _authLocalRepository.userStream;
  }

  User? getUser() {
    return _authLocalRepository.getUser();
  }

  void saveUser(user) {
    _authLocalRepository.saveUser(user);
  }

  Future<OAuthCredential> getGoogleCredential() {
    return _authRemoteRepository.getGoogleCredential();
  }
  Future<OAuthCredential> getAppleCredential() {
    return _authRemoteRepository.getAppleCredential();
  }

  Future<UserCredential> signInWithCredential(OAuthCredential credential) {
    return _authRemoteRepository.signInWithCredential(credential);
  }

  Future logOut() async {
    _authRemoteRepository.logOut();
  }

  Future<UserCredential?> registerUser(String email, String password) async {
    return _authRemoteRepository.registerUser(email, password);
  }

  Future<UserCredential?> signInWithEmailAndPassword({required String email,required String password}) async {
    return _authRemoteRepository.signInWithEmailAndPassword(email: email, password: password);
  }

}
