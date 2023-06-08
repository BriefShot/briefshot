// ignore_for_file: use_build_context_synchronousl
import 'package:briefshot/blocs/passwordDialog/password_dialog_bloc.dart';
import 'package:briefshot/blocs/settings/settings_bloc.dart';
import 'package:briefshot/blocs/updateEmail/update_email_bloc.dart';
import 'package:briefshot/widgets/popups/AskPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class UpdateEmailForm extends StatelessWidget {
  UpdateEmailForm({super.key});

  static final GlobalKey<FormState> _updateEmailFormKey =
      GlobalKey<FormState>();

  final UpdateEmailBloc updateEmailBloc = UpdateEmailBloc();
  final PasswordDialogBloc passwordDialogBloc = PasswordDialogBloc();
  final _emailValidator =
      ValidationBuilder(requiredMessage: "L'email est obligatoire")
          .email("Cet email n'est pas correct")
          .build();

  final TextEditingController _newEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => updateEmailBloc,
          ),
          BlocProvider(
            create: (context) => passwordDialogBloc,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<PasswordDialogBloc, PasswordDialogState>(
                listener: (context, state) async {
              if (state is PasswordDialogAppear) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: passwordDialogBloc,
                    child: AskPassword(),
                  ),
                );
              }
              if (state is PasswordDialogValueOk) {
                BlocProvider.of<UpdateEmailBloc>(context).add(
                  UpdateEmailEvent(
                    _newEmailController.text,
                  ),
                );
              }
            }),
            BlocListener<UpdateEmailBloc, UpdateEmailState>(
              listener: (context, state) {
                if (state is UpdateEmailSuccessfully) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Email mis à jour',
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
                  BlocProvider.of<SettingsBloc>(context).add(
                    PressOnBackToSettingButton(),
                  );
                  Navigator.of(context).pop();
                }
                if (state is UpdateEmailUnsuccessfull) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Erreur lors de la mise à jour de l\'email',
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
                }
              },
            ),
          ],
          child: BlocBuilder<UpdateEmailBloc, UpdateEmailState>(
            builder: (context, state) {
              return Form(
                key: _updateEmailFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email actuel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(20, 15)),
                      child: TextFormField(
                        style: const TextStyle(
                          color: Color(0xFF9E9E9E),
                        ),
                        enabled: false,
                        initialValue: state.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xFF292929),
                          filled: true,
                          labelStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Nouveau courriel",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.elliptical(20, 15),
                      ),
                      child: TextFormField(
                        validator: _emailValidator,
                        controller: _newEmailController,
                        style: const TextStyle(
                          color: Color(0xFF9E9E9E),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          errorStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            backgroundColor: Colors.transparent,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          fillColor: Color(0xFF1F2E34),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(20, 20),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          labelStyle: TextStyle(
                            color: Color(0xFF9E9E9E),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 11),
                        backgroundColor: const Color(0xFFE88954),
                        fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width,
                        ),
                      ),
                      onPressed: () async {
                        if (_updateEmailFormKey.currentState!.validate()) {
                          BlocProvider.of<PasswordDialogBloc>(context)
                              .add(const PasswordDialogAsked());
                        }
                      },
                      child: const Text(
                        "Mettre à jour",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
