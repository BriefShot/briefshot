import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../blocs/navigation/navigation_bloc.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (BuildContext context, NavigationState state) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: MediaQuery(
          data: const MediaQueryData(
            padding: EdgeInsets.symmetric(vertical: 25),
          ),
          child: SizedBox(
            height: 74,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: null,
                selectedFontSize: 0,
                backgroundColor: const Color(0xFF2A3D45),
                currentIndex: state.currentTabIndex,
                onTap: (index) {
                  BlocProvider.of<NavigationBloc>(context).add(
                    NavigationTabChanged(tabIndex: index),
                  );
                },
                iconSize: 24,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/home.svg",
                    ),
                    label: '',
                    activeIcon: SvgPicture.asset(
                      "assets/icons/home--active.svg",
                    ),
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/icons/messenger.svg",
                      ),
                      label: '',
                      activeIcon: SvgPicture.asset(
                        "assets/icons/messenger--active.svg",
                      )),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/icons/profil.svg",
                      ),
                      label: '',
                      activeIcon: SvgPicture.asset(
                        "assets/icons/profil--active.svg",
                      )),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/notification.svg",
                    ),
                    label: '',
                    activeIcon: SvgPicture.asset(
                      "assets/icons/notification--active.svg",
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
