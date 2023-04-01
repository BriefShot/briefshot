import 'package:briefshot/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/SignInFormWidget.dart';
import '../widgets/SignUpFormWidget.dart';
import '../widgets/SignUpWidget.dart';

class AuthenticationScreen extends StatelessWidget {
  AuthenticationScreen({
    super.key,
  });

  final AuthenticationBloc authenticationBloc = AuthenticationBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => authenticationBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/img/briefshot_background_auth.png"),
                    fit: BoxFit.cover),
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
                        state.isSignInFormVisible
                            ? SignInForm()
                            : state.isSignUpFormVisible
                                ? SignUpForm()
                                : const SignUpWidget(),
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
