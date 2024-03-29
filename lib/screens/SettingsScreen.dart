import 'package:briefshot/blocs/settings/settings_bloc.dart';
import 'package:briefshot/screens/AuthentificationScreen.dart';
import 'package:briefshot/screens/SettingTileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsBloc settingsBloc = SettingsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => settingsBloc,
      child: Scaffold(
          backgroundColor: const Color(0xFF0B1012),
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
                Navigator.pop(context);
              },
            ),
            title: BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return Text(
                  state.appBarTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "DrukWideWeb",
                    fontSize: 24,
                  ),
                );
              },
            ),
          ),
          body: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: ListTile.divideTiles(
                    color: const Color(0xFF2A3D45),
                    context: context,
                    tiles: [
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/mail.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          BlocProvider.of<SettingsBloc>(context).add(
                            PressOnEmailTile(),
                          );
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: settingsBloc,
                                  child: const SettingTileScreen(),
                                ),
                              )));
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/password.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: const Text(
                          "Mot de passe",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          BlocProvider.of<SettingsBloc>(context).add(
                            PressOnPasswordTile(),
                          );
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: settingsBloc,
                                  child: const SettingTileScreen(),
                                ),
                              )));
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/notification.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: const Text(
                          "Notifications",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          BlocProvider.of<SettingsBloc>(context).add(
                            PressOnNotificationsTile(),
                          );
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: settingsBloc,
                                  child: const SettingTileScreen(),
                                ),
                              )));
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/checkmark-badge.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: const Text(
                          "Abonnement",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {
                          BlocProvider.of<SettingsBloc>(context).add(
                            PressOnSubscriptionTile(),
                          );
                          Navigator.push(
                              context,
                              (MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: settingsBloc,
                                  child: const SettingTileScreen(),
                                ),
                              )));
                        },
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/mention.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: const Text(
                          "Nous contacter",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/delete.svg",
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: const Text(
                          "Supprimer mon compte",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                          leading: SvgPicture.asset(
                            "assets/icons/logout.svg",
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: const Text(
                            "Se déconnecter",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            BlocProvider.of<SettingsBloc>(context).add(
                              PressOnLogoutTile(),
                            );

                            Navigator.pushReplacement<void, void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    AuthentificationScreen(),
                              ),
                            );
                          }),
                    ],
                  ).toList());
            },
          )),
    );
  }
}
