import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserInfos extends Equatable {
  String avatar = "";
  String cover = "";
  String username = "";
  List<String> interestedInTags = [];
  List<String> favoritePlaces = [];
  List<String> posts = [];

  UserInfos({
    required this.avatar,
    required this.cover,
    required this.username,
    required this.interestedInTags,
    required this.favoritePlaces,
    required this.posts,
  });

  factory UserInfos.fromMap(Map<String, dynamic> map) {
    return UserInfos(
      avatar: map['avatar'],
      cover: map['cover'],
      username: map['username'],
      interestedInTags: List<String>.from(map['interestedInTags']),
      favoritePlaces: List<String>.from(map['favoritePlaces']),
      posts: List<String>.from(map['posts']),
    );
  }

  @override
  List<Object?> get props =>
      [avatar, cover, username, interestedInTags, favoritePlaces, posts];

  static UserInfos fromSnapshot(DocumentSnapshot doc) {
    UserInfos userInfos = UserInfos(
        avatar: doc['avatar'],
        cover: doc['cover'],
        username: doc['username'],
        interestedInTags: List<String>.from(doc['interestedInTags']),
        favoritePlaces: List<String>.from(doc['favoritePlaces']),
        posts: List<String>.from(doc['posts']));

    return userInfos;
  }
}
