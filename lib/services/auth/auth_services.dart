import 'package:flutter_demo/services/auth/auth_user.dart';
import 'package:flutter_demo/services/auth/firebase_auth_provider.dart';

import 'auth_provider.dart';

class AuthSevice implements AuthProvider {
  final AuthProvider provider;
  const AuthSevice(this.provider);

  factory AuthSevice.firebase() => AuthSevice(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser(
          {required String email, required String password}) =>
      provider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logIn({required String email, required String password}) =>
      provider.logIn(email: email, password: password);

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> snedEmailVerification() => provider.snedEmailVerification();
}
