import 'package:briefshot/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFE88954),
              fixedSize: Size.fromWidth(
                MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                PressOnEmailSignUpButton(),
              );
            },
            icon: SvgPicture.asset("assets/icons/mail.svg"),
            label: const Text(
              style: TextStyle(color: Colors.white),
              "Creer un compte gratuit",
            ),
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              fixedSize:
                  Size.fromWidth(MediaQuery.of(context).size.width * 0.8),
            ),
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/logo_google.svg"),
            label: const Text(
              style: TextStyle(color: Colors.black),
              "Continuer avec Google",
            ),
          ),
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 0, 0),
              fixedSize:
                  Size.fromWidth(MediaQuery.of(context).size.width * 0.8),
            ),
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/logo_apple.svg"),
            label: const Text(
              style: TextStyle(color: Colors.white),
              "Continuer avec Apple",
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Déjà inscrit ?",
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 2),
            TextButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  PressOnSignInButton(),
                );
              },
              child: const Text(
                "Connectez vous",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
