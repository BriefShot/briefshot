import 'package:briefshot/screens/SettingsScreen.dart';
import 'package:briefshot/widgets/FilterButton.dart';
import 'package:briefshot/widgets/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../blocs/navigation/navigation_bloc.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationBloc navigationBloc = NavigationBloc();
    return BlocProvider<NavigationBloc>(
      create: (context) => navigationBloc,
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, NavigationState state) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: state.currentTabIndex == 2
                ? AppBar(
                    backgroundColor: Colors.black,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/icons/settings.svg",
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                (MaterialPageRoute(
                                    builder: (context) => SettingsScreen())));
                          },
                        ),
                      ),
                    ],
                  )
                : null,
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: state.currentTabIndex == 0
                ? const MediaQuery(
                    data: MediaQueryData(
                        padding: EdgeInsets.fromLTRB(15, 15, 0, 0)),
                    child: FilterButton())
                : null,
            body: SafeArea(
              child: SingleChildScrollView(
                  child: state.screens[state.currentTabIndex]),
            ),
            bottomNavigationBar: const NavBar(),
          );
        },
      ),
    );
  }
}
