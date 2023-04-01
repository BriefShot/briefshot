import 'package:faker/faker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  Future<String> generatedUniqueUsername() async {
    bool isUsernameUnique = false;
    late String username;

    while (!isUsernameUnique) {
      username = faker.internet.userName();
      final response = await Supabase.instance.client
          .from('users')
          .select()
          .eq('username', username)
          .execute();

      isUsernameUnique = response.data == null || response.data.isEmpty;
    }
    return username;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> data,
  }) async {
    try {
      await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      await Supabase.instance.client.auth.signOut();
    } on AuthException catch (e) {
      throw e.message;
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw e.message;
    }
  }
}
