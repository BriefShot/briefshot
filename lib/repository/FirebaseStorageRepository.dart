import 'dart:io';
import 'package:briefshot/repository/UserInfosRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageRepository {
  Reference _firebaseStorage;
  Reference UserPictureRef =
      FirebaseStorage.instance.ref().child('usersPictures');

  FirebaseStorageRepository({Reference? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance.ref();

  Future<void> uploadUserCoverPicture(String path) async {
    try {
      Reference referenceUploadImage = UserPictureRef.child(
          '${FirebaseAuth.instance.currentUser!.uid}/${const Uuid().v4()}');
      await referenceUploadImage.putFile(File(path));
      String downloadUrl = await referenceUploadImage.getDownloadURL();

      UserInfosRepository().updateCoverPicture(downloadUrl);
    } catch (e) {
      throw e;
    }
  }

  Future<void> uploadUserAvatarPicture(String path) async {
    try {
      Reference referenceUploadImage = UserPictureRef.child(
          '${FirebaseAuth.instance.currentUser!.uid}/${const Uuid().v4()}');
      await referenceUploadImage.putFile(File(path));
      String downloadUrl = await referenceUploadImage.getDownloadURL();

      UserInfosRepository().updateProfilePicture(downloadUrl);
    } catch (e) {
      throw e;
    }
  }
}
