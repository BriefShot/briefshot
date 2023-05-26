import 'package:briefshot/firebase/firestore/collections/UsersCollection.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserCollection().createUserDocument();
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw "Le mot de passe est trop faible, il doit faire au moins 8 caractères";
      } else if (e.code == 'email-already-in-use') {
        throw "Cette adresse email est déjà utilisée";
      }
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw "Email ou mot de passe incorrect";
      } else if (e.code == 'wrong-password') {
        throw "Email ou mot de passe incorrect";
      }
    }
  }

  Future<void> relogUser(String? password) async {
    if (password != null) {
      try {
        await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: password,
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          throw "Email ou mot de passe incorrect";
        } else if (e.code == 'wrong-password') {
          throw "Email ou mot de passe incorrect";
        } else {
          throw "Une erreur est survenue, merci de réessayer ultérieurement";
        }
      }
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw "L'adresse email est invalide";
      } else if (e.code == 'email-already-in-use') {
        throw "Cette adresse email est déjà utilisée";
      } else {
        throw "Une erreur est survenue, merci de réessayer ultérieurement";
      }
    }
  }
}
