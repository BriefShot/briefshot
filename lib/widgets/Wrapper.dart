import 'package:briefshot/blocs/profile/profile_bloc.dart';
import 'package:briefshot/blocs/userInfos/user_infos_bloc.dart';
import 'package:briefshot/blocs/usernameDialog/username_dialog_bloc.dart';
import 'package:briefshot/repository/UserInfosRepository.dart';
import 'package:briefshot/screens/SettingsScreen.dart';
import 'package:briefshot/widgets/FilterButton.dart';
import 'package:briefshot/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../blocs/navigation/navigation_bloc.dart';

class Wrapper extends StatelessWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(
        UserInfosBloc(UserInfosRepository())..add(LoadUserInfos()),
        BlocProvider.of<ProfileBloc>(context),
        BlocProvider.of<UsernameDialogBloc>(context),
      ),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, NavigationState state) {
          return Scaffold(
            backgroundColor: const Color(0xFF0B1012),
            appBar: state.currentTabIndex == 2
                ? AppBar(
                    backgroundColor: const Color(0xFF0B1012),
                    title: const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Profil",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "DrukWideWeb",
                          fontSize: 24,
                        ),
                      ),
                    ),
                    toolbarHeight: 84,
                    centerTitle: false,
                    titleSpacing: 0,
                    actions: [
                      BlocProvider.value(
                        value: BlocProvider.of<ProfileBloc>(context),
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            if (state.isEditionMode) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ProfileBloc>(context)
                                          .add(ProfileEditionCancelled());
                                    },
                                    child: Text(
                                      "Annuler".toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/icons/edit-filled.svg",
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              );
                            }

                            return IconButton(
                              icon: SvgPicture.asset(
                                "assets/icons/edit.svg",
                              ),
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context)
                                    .add(ProfileEditionAsked());
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icons/settings.svg",
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : null,
            extendBody: true,
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: state.currentTabIndex == 0
                ? const MediaQuery(
                    data: MediaQueryData(
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 0)),
                    child: FilterButton(),
                  )
                : null,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            BlocProvider.of<ProfileBloc>(context),
                      ),
                      BlocProvider(
                        create: (context) =>
                            BlocProvider.of<UsernameDialogBloc>(context),
                      )
                    ],
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: state.screens[state.currentTabIndex],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 150,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(11, 16, 18, 0),
                        Color(0xFF0B1012),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    )),
                  ),
                ),
                const NavBar()
              ],
            ),
          );
        },
      ),
    );
  }
}
