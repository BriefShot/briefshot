import 'package:briefshot/widgets/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../widgets/SignInFormWidget.dart';
import '../widgets/SignUpFormWidget.dart';
import '../widgets/SignUpWidget.dart';

class AuthentificationScreen extends StatelessWidget {
  AuthentificationScreen({
    super.key,
  });

  final AuthenticationBloc authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authenticationBloc,
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSignUpSuccessfullyState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Inscription réussie ! Vous pouvez vous connecter !',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(20, 15),
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: Duration(
                  seconds: 1,
                ),
              ),
            );
          }
          if (state is AuthenticationSignUpFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(20, 15),
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(
                  seconds: 1,
                ),
              ),
            );
          }
          if (state is AuthenticationSignInFailedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.error,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(20, 15),
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                duration: const Duration(
                  seconds: 1,
                ),
              ),
            );
          }
          if (state is AuthenticationSignInSuccessfullyState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Wrapper()),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/briefshot_background_auth.png"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0B1012),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Wrap(
                      children: [
                        if (state is AuthenticationSignUpFormRequestedState ||
                            state is AuthenticationSignUpFailedState)
                          SignUpForm(),
                        if (state is AuthenticationSignInFormRequestedState ||
                            state is AuthenticationSignInFailedState ||
                            state is AuthenticationSignUpSuccessfullyState)
                          SignInForm(),
                        if (state is AuthenticationInitialState)
                          const SignUpWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
