import 'package:briefshot/widgets/Wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/AuthentificationScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode) {
    await dotenv.load(fileName: ".env");
  } else {
    await dotenv.load(fileName: ".env.development");
  }

  await Supabase.initialize(
    url: dotenv.env["SUPABASE_URL"]!,
    anonKey: dotenv.env["SUPABASE_ANONKEY"]!,
  );

  runApp(MaterialApp(
    home: Supabase.instance.client.auth.currentSession != null
        ? const Wrapper()
        : AuthenticationScreen(),
  ));
}
