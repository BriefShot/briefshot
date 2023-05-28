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

  Future<void> updateUsername(String username) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'username': username});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCoverPicture(String coverPicture) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'cover': coverPicture});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfilePicture(String profilePicture) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'avatar': profilePicture});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTags(List<String> tags) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'interestedInTags': FieldValue.arrayUnion(tags)});
    } catch (e) {
      rethrow;
    }
  }
}
