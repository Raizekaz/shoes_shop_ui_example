/* import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:shoes_shop_ui/domain/entities/user_entity.dart';

abstract class AuthService {}

class AuthServiceDefault implements AuthService {
  final fb.FirebaseAuth _firebaseAuth;

  AuthServiceDefault({
    fb.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? fb.FirebaseAuth.instance;

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final fb.UserCredential result =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    fb.User user = result.user!;
    return User.fromFirebase(user);
  }

  @override
  Future<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final fb.UserCredential result =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    fb.User user = result.user!;
    return User.fromFirebase(user);
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User> get currentUser => _firebaseAuth.authStateChanges().map(
        (fb.User user) => user != null ? User.fromFirebase(user) : null,
      );
}
 */