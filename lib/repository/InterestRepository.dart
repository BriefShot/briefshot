import 'package:briefshot/entities/Interest.dart';
import 'package:briefshot/repository/FirebaseStorageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InterestRepository {
  final FirebaseFirestore _firebaseFirestore;

  InterestRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<String> getImageUrl(String imageName) async {
    try {
      Reference interestsImageRef = FirebaseStorage.instance.ref().child(
          'interests/${imageName.toLowerCase()}.png'); // Append '.png' to the image name

      String url = await interestsImageRef.getDownloadURL();

      return url;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Interest>> getInterests() {
    return _firebaseFirestore
        .collection('interests')
        .doc("rOZGFUDTE0JsgsijZ1u3")
        .snapshots()
        .asyncMap((snapshot) async {
      if (!snapshot.exists) return [];

      List<String> interestList = List<String>.from(snapshot.get('list'));

      DocumentSnapshot userSnapshot = await _firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      List<String> interestedInTags =
          List<String>.from(userSnapshot.get('interestedInTags'));

      List<String> filteredInterestList = interestList
          .where((interest) => !interestedInTags.contains(interest))
          .toList();

      return await Future.wait(filteredInterestList.map((String label) async {
        Interest interest = Interest(label: label, image: '');
        interest.image = await getImageUrl(label);
        return interest;
      }));
    });
  }
}
