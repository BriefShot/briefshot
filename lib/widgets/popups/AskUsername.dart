import 'package:briefshot/blocs/profile/profile_bloc.dart';
import 'package:briefshot/blocs/usernameDialog/username_dialog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';

class AskUsername extends StatelessWidget {
  AskUsername({super.key});

  static final _askUsernameFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  final _usernameValidator = ValidationBuilder(
    requiredMessage: "Le nom d'utilisateur est obligatoire",
  )
      .minLength(
          4, "Le nom d'utilisateur doit contenir au moins 4 caractères !")
      .build();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsernameDialogBloc, UsernameDialogState>(
      bloc: BlocProvider.of<UsernameDialogBloc>(context),
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocListener<UsernameDialogBloc, UsernameDialogState>(
                listener: (context, state) {
              if (state is UsernameDialogError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Une erreur est survenue',
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
              } else if (state is UsernameDialogCancelled) {
                Navigator.of(context).pop();
              }
            }, child: BlocBuilder<UsernameDialogBloc, UsernameDialogState>(
              builder: (context, state) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xFF2A3D45),
                  title: ListTile(
                    leading: SvgPicture.asset(
                      "assets/icons/edit-user.svg",
                      color: Colors.white,
                      width: 24,
                      height: 24,
                    ),
                    minLeadingWidth: 0,
                    title: const Text(
                      "Saississez votre nouveau nom d'utilisateur",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: _askUsernameFormKey,
                        child: TextFormField(
                          onChanged: (value) {
                            context.read<UsernameDialogBloc>().add(
                                  UsernameDialogFieldChanged(
                                    value,
                                  ),
                                );
                          },
                          validator: _usernameValidator,
                          controller: _usernameController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            fillColor: Color(0xFF141E22),
                            filled: true,
                            hintText: 'Nom d\'utilisateur',
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
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                            )),
                          ),
                          child: const Text(
                            'Annuler',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            BlocProvider.of<UsernameDialogBloc>(context)
                                .add(const UsernameDialogCancelled());

                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
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
                            if (_askUsernameFormKey.currentState!.validate()) {
                              context.read<UsernameDialogBloc>().add(
                                    UsernameDialogFieldSubmitted(
                                      _usernameController.text,
                                    ),
                                  );
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            )));
      },
    );
  }
}
