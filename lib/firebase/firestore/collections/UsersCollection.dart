import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCollection {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> createUserDocument() async {
    const String defaultCoverUrl =
        "https://firebasestorage.googleapis.com/v0/b/bf-project-mds.appspot.com/o/usersPictures%2Fdefault-cover.png?alt=media&token=6fbe6b27-2b80-4ccd-8612-52cecd76c191";
    const String defaultAvatarUrl =
        "https://firebasestorage.googleapis.com/v0/b/bf-project-mds.appspot.com/o/usersPictures%2Fdefault-avatar.png?alt=media&token=91420820-2471-4e26-a835-28fd24a1a1e2";

    users.doc(uid).set(
      {
        'username': faker.internet.userName(),
        'interestedInTags': [],
        'favoritePlaces': [],
        'posts': [],
        'cover': defaultCoverUrl,
        'avatar': defaultAvatarUrl
      },
    );
  }
}
