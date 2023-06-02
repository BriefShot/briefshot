import 'package:briefshot/blocs/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:briefshot/blocs/updatePassword/update_password_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class UpdatePasswordForm extends StatelessWidget {
  UpdatePasswordForm({super.key});

  static final GlobalKey<FormState> _updatePasswordFormKey =
      GlobalKey<FormState>();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  final UpdatePasswordBloc updatePasswordBloc = UpdatePasswordBloc();

  final _passwordValidator =
      ValidationBuilder(requiredMessage: "Le mot de passe est obligatoire")
          .minLength(8, "Le mot de passe doit contenir au moins 8 caractères")
          .build();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => updatePasswordBloc,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<UpdatePasswordBloc, UpdatePasswordState>(
              listener: (context, state) {
                if (state is UpdatePasswordSuccessfully) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Mot de passe mis à jour',
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(20, 15),
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      duration: Duration(
                        seconds: 1,
                      ),
                    ),
                  );
                  BlocProvider.of<SettingsBloc>(context)
                      .add(PressOnBackToSettingButton());
                }
              },
            ),
          ],
          child: Form(
            key: _updatePasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Mot de passe actuel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF292929),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: _passwordValidator,
                ),
                SizedBox(
                  height: 20,
                ),
                const Text("Nouveau mot de passe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: _confirmNewPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Color(0xFF292929),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0)),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  validator: (value) {
                    if (value != _newPasswordController.text) {
                      return "Les mots de passe ne correspondent pas";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE88954),
                    fixedSize: Size.fromWidth(
                      MediaQuery.of(context).size.width,
                    ),
                  ),
                  onPressed: () {
                    if (_updatePasswordFormKey.currentState!.validate()) {
                      BlocProvider.of<UpdatePasswordBloc>(context).add(
                        UpdatePasswordEvent(
                          _newPasswordController.text,
                        ),
                      );
                    }
                  },
                  child: Text('Mettre à jour le mot de passe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
