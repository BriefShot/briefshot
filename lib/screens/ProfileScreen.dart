import 'package:briefshot/screens/SettingsScreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              (MaterialPageRoute(builder: (context) => SettingsScreen())));
        },
        child: const Text("Parametres"));
  }
}
