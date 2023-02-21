import 'package:authentication_repository/shared/firebase_constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreService {}

class FirestoreServiceDefault implements FirestoreService {
  FirestoreServiceDefault({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<List<DocumentSnapshot>> getInfoFirestore({
    required String pathCollection,
    required int limit,
    required String textSearch,
  }) async {
    List<DocumentSnapshot> result = [];
    QuerySnapshot? response;

    if (textSearch.isEmpty) {
      response = await _firestore
          .collection(pathCollection)
          .limit(limit)
          .where(FirebaseConstants.name, isEqualTo: textSearch)
          .get();

      result = response.docs;
    } else {
      response = await _firestore.collection(pathCollection).limit(limit).get();
      result = response.docs;
    }
    return result;
  }
}
