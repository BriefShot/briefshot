import 'package:briefshot/entities/UserInfos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfosRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserInfosRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<UserInfos> getUserInfos(String uid) {
    return _firebaseFirestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => UserInfos.fromSnapshot(snapshot));
  }

  Future<void> removeTag(String tag) {
    return _firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'interestedInTags': FieldValue.arrayRemove([tag])
    });
  }
}
