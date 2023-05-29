import 'package:briefshot/blocs/profile/profile_bloc.dart';
import 'package:briefshot/screens/InterestScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTagPill extends StatelessWidget {
  const NewTagPill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ClipOval(
        child: Container(
          width: 33,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFE88954),
              width: 2.0,
            ),
          ),
          child: Material(
            shape: const CircleBorder(),
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 200),
                      pageBuilder: (_, __, ___) => InterestScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        );
                      },
                    ));
              },
              borderRadius: BorderRadius.circular(100.0),
              child: Container(
                child: const Icon(
                  Icons.add,
                  color: Color(0xFFE88954),
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
