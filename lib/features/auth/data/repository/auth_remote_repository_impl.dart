import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/features/auth/data/service/firebase_auth_service.dart';
import 'package:notes/features/auth/domain/repository/auth_remote_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRemoteRepositoryImpl implements AuthRemoteRepository {
  final FirebaseAuthService _authService;

  AuthRemoteRepositoryImpl({
    required FirebaseAuthService authService,
  }) : _authService = authService;

  @override
  Stream<User?> observeAuthState() {
    return _authService.observeAuthState();
  }

  @override
  Future<UserCredential> signInWithCredential(OAuthCredential credential) async {
    return _authService.signInWithCredential(credential);
  }

  @override
  Future<OAuthCredential> getGoogleCredential() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return credential;
  }

  @override
  Future<OAuthCredential> getAppleCredential() async {
    final rawNonce = generateNonce();
    final nonce = _getSha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    print(oauthCredential);

    return oauthCredential;
  }

  @override
  Future<void> logOut() async {
    _authService.logOut();
  }

  @override
  Future<UserCredential?> registerUser(String email, String password) async {
    return _authService.registerUser(email, password);
  }

  @override
  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _authService.signInWithEmailAndPassword(email: email, password: password);
  }

  String _getSha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
