import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:app_settings/app_settings.dart';

class LocationRequestPopup extends StatelessWidget {
  const LocationRequestPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return _dialogBuilder(context);
  }

  Widget _dialogBuilder(BuildContext context) {
    return AlertDialog(
      title: const Text('Activer la géolocalisation'),
      content: const Text('Briefshot a besoin de votre géolocalisation\n'
          'pour vous permettre d\'utiliser toutes\n'
          'les fonctionnalités de l\'application.'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Non merci'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Aller aux réglages'),
          onPressed: () {
            AppSettings.openLocationSettings();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
