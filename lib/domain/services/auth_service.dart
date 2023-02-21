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

// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:firebase_auth/firebase_auth.dart' as fb;
// import 'package:authentication_repository/src/shared/firebase_constans.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthServiceDefault {
//   final AuthenticationRepository _authRepository;
//   AuthServiceDefault({AuthenticationRepository? authRepository,}) : _authRepository = authRepository ?? AuthenticationRepository();


//   Future<User?> SignUp({
//     required String email,
//     required String password,
//   }) async{
//     fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
//     User? _user;

//       final response = await _authRepository.signUp(
//         email: email,
//         password: password,
//       );
//       final user = response.user;
//       if (user != null) {
//         final QuerySnapshot result = await FirebaseFirestore.instance
//             .collection(FirebaseConstants.pathUserCollection)
//             .where(FirebaseConstants.id, isEqualTo: user.uid)
//             .get();
//         final List<DocumentSnapshot> documents = result.docs;
//         if (documents.isEmpty) {
//           await FirebaseFirestore.instance
//               .collection(FirebaseConstants.pathUserCollection)
//               .doc(user.uid)
//               .set({
//             FirebaseConstants.name: user.toUser.name,
//             FirebaseConstants.email: user.toUser.email,
//             FirebaseConstants.country: user.toUser.country,
//             FirebaseConstants.photoUrl: user.toUser.photo,
//             FirebaseConstants.id: user.uid,
//             'createAt': DateTime.now().millisecondsSinceEpoch.toString(),
//           });
//         }
//       }
  
//   }
// }
