import 'package:briefshot/blocs/authentication/authentication_bloc.dart';
import 'package:briefshot/widgets/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';

import '../blocs/passwordVisibility/password_visibility_bloc.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
    super.key,
  });

  final PasswordVisibilityBloc passwordVisibilityBloc =
      PasswordVisibilityBloc();

  static final _signInKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailValidator =
      ValidationBuilder().email("Cet email n'est pas correct").build();
  final _passwordValidator = ValidationBuilder()
      .minLength(8, "Le mot de passe doit contenir au moins 8 caractères")
      .build();

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => passwordVisibilityBloc,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      PressOnBackToSignUpMethodsButton(),
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/arrow.svg",
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Bon Retour ! 👋",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "DrukWideWeb",
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _signInKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.elliptical(20, 15),
                          ),
                          child: TextFormField(
                            validator: _emailValidator,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Color(0xFF9E9E9E)),
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: const Color(0xFF2A3D45),
                              filled: true,
                              hintText: "bonjour@briefshot.app",
                              labelStyle: const TextStyle(
                                color: Color(0xFF9E9E9E),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 13.0),
                                child: SvgPicture.asset(
                                  "assets/icons/mail.svg",
                                  color: const Color(0xFF9E9E9E),
                                ),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                minHeight: 25,
                                maxHeight: 25,
                              ),
                              hintStyle: const TextStyle(
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mot de passe",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        BlocBuilder<PasswordVisibilityBloc,
                            PasswordVisibilityState>(
                          builder: (context, state) {
                            return ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.elliptical(20, 15),
                              ),
                              child: TextFormField(
                                validator: _passwordValidator,
                                style:
                                    const TextStyle(color: Color(0xFF9E9E9E)),
                                controller: _passwordController,
                                obscureText: state.isHidden,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: const Color(0xFF2A3D45),
                                  filled: true,
                                  hintText: "8 caractères minimum",
                                  labelStyle: const TextStyle(
                                    color: Color(0xFF9E9E9E),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 13.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        context
                                            .read<PasswordVisibilityBloc>()
                                            .add(
                                              PressOnPasswordVisibilityButton(
                                                isHidden: state.isHidden,
                                              ),
                                            );
                                      },
                                      child: state.isHidden
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Color(0xFF9E9E9E),
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Color(0xFF9E9E9E),
                                            ),
                                    ),
                                  ),
                                  suffixIconConstraints: const BoxConstraints(
                                    minHeight: 25,
                                    maxHeight: 25,
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Color(0xFF9E9E9E),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(20, 15),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFE88954),
                          fixedSize: Size.fromWidth(
                            MediaQuery.of(context).size.width,
                          ),
                        ),
                        onPressed: () async {
                          if (_signInKey.currentState!.validate()) {
                            BlocProvider.of<AuthenticationBloc>(context).add(
                              PressOnSignInButton(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                            _signInKey.currentState?.reset();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const Wrapper(),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Se connecter",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
