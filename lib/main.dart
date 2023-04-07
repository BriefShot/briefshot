import 'package:briefshot/widgets/Wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/AuthentificationScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await dotenv.load(fileName: ".env");
  } else {
    await dotenv.load(fileName: ".env.development");
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.signOut();

  runApp(MaterialApp(
    home: FirebaseAuth.instance.currentUser != null
        ? const Wrapper()
        : AuthenticationScreen(),
  ));
}
