import 'package:briefshot/blocs/profile/profile_bloc.dart';
import 'package:briefshot/blocs/usernameDialog/username_dialog_bloc.dart';
import 'package:briefshot/screens/AuthentificationScreen.dart';
import 'package:briefshot/widgets/Wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MaterialApp(
    home: FirebaseAuth.instance.currentUser != null
        ? MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ProfileBloc(),
              ),
              BlocProvider(
                create: (context) => UsernameDialogBloc(),
              ),
            ],
            child: Wrapper(),
          )
        : AuthentificationScreen(),
  ));
}
