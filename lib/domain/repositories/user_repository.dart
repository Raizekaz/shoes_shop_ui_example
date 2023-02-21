/* import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:shoes_shop_ui/domain/entities/user_entity.dart';

abstract class UserRepository {
  Stream<User> getUser(String userId);
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
}

class UserReposityDefault implements UserRepository {
  UserReposityDefault({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toDocument());
  }

  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => User.fromSnapshot(snapshot));
  }

  @override
  Future<void> updateUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument());
  }
}
 */