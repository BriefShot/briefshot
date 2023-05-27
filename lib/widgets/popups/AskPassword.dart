import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

import '../../blocs/passwordDialog/password_dialog_bloc.dart';

class AskPassword extends StatelessWidget {
  AskPassword({super.key});

  static final _askPasswordFormKey = GlobalKey<FormState>();

  final _passwordValidator =
      ValidationBuilder(requiredMessage: "Le mot de passe est obligatoire")
          .minLength(8, "Le mot de passe doit contenir au moins 8 caractères")
          .build();

  final _passwordController = TextEditingController();

  void dispose() {
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordDialogBloc, PasswordDialogState>(
      listener: (context, state) {
        if (state is PasswordDialogWrongPasswordValue) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Mot de passe incorrect',
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
        if (state is PasswordDialogValueOk) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<PasswordDialogBloc, PasswordDialogState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              backgroundColor: const Color(0xFF2A3D45),
              title: const ListTile(
                leading: Icon(Icons.warning, color: Colors.white),
                minLeadingWidth: 0,
                title: Text('Veuillez saisir votre mot de passe',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              content: BlocBuilder<PasswordDialogBloc, PasswordDialogState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _askPasswordFormKey,
                        child: TextFormField(
                          validator: _passwordValidator,
                          controller: _passwordController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            BlocProvider.of<PasswordDialogBloc>(context)
                                .add(PasswordDialogFieldChanged(value));
                          },
                          decoration: const InputDecoration(
                            fillColor: Color(0xFF141E22),
                            filled: true,
                            hintText: 'Mot de passe',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            errorMaxLines: 2,
                            errorStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF1F2E34),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 11,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                            top: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text('Annuler',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: () {
                        BlocProvider.of<PasswordDialogBloc>(context)
                            .add(const PasswordDialogCancelled());
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    BlocBuilder<PasswordDialogBloc, PasswordDialogState>(
                      builder: (context, state) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF1F2E34),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 11,
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10),
                              top: Radius.circular(10),
                            )),
                          ),
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            if (_askPasswordFormKey.currentState!.validate()) {
                              BlocProvider.of<PasswordDialogBloc>(context).add(
                                  PasswordDialogFieldSubmitted(state.password));
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
