import 'dart:io';

import 'package:briefshot/repository/FirebaseStorageRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_maps_webservice/places.dart';

class PlaceRepository {
  final FirebaseFirestore _firestore;

  PlaceRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addPlace(
      String placeName, String placeImage, Location placeLocation) async {
    Reference uploadImageReference = FirebaseStorageRepository()
        .ShotPictureRef
        .child(FirebaseAuth.instance.currentUser!.uid);
    await uploadImageReference.putFile(File(placeImage));
    String downloadUrl = await uploadImageReference.getDownloadURL();

    var newPlace = {
      'name': placeName,
      'image': downloadUrl,
      'location': GeoPoint(placeLocation.lat, placeLocation.lng),
    };

    _firestore
        .collection('places')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'places': FieldValue.arrayUnion([newPlace])
    }, SetOptions(merge: true));
  }
}
