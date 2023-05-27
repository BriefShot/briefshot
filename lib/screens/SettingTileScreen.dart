import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../blocs/settings/settings_bloc.dart';

class SettingTileScreen extends StatelessWidget {
  const SettingTileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1012),
        toolbarHeight: 84,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/arrow.svg",
          ),
          onPressed: () {
            BlocProvider.of<SettingsBloc>(context).add(
              PressOnBackToSettingButton(),
            );
            Navigator.pop(context);
          },
        ),
        title: Text(
          BlocProvider.of<SettingsBloc>(context).state.appBarTitle,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "DrukWideWeb",
            fontSize: 24,
          ),
        ),
      ),
      body: Center(child: BlocProvider.of<SettingsBloc>(context).state.widget),
    );
  }
}
