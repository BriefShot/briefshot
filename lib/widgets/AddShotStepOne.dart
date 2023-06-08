import 'package:briefshot/blocs/shot/shot_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddShotStepOne extends StatefulWidget {
  const AddShotStepOne({super.key});

  @override
  State<AddShotStepOne> createState() => _AddShotStepOneState();
}

class _AddShotStepOneState extends State<AddShotStepOne> {
  static final GlobalKey<FormState> _shotNameFormKey = GlobalKey<FormState>();
  static final _shotNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _shotNameFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nom",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "DrukWideWeb",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<ShotBloc, ShotState>(
                        builder: (context, state) {
                          return TextFormField(
                            initialValue:
                                state.shotName != null ? state.shotName : null,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            onChanged: (value) =>
                                BlocProvider.of<ShotBloc>(context)
                                    .add(ShotNameChanged(shotName: value)),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              hintText: "Nom du lieu",
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Color(0xFF1F2E34),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Photo",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "DrukWideWeb",
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ShotBloc, ShotState>(
                  builder: (context, state) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: state.shotImage != null
                            ? DecorationImage(
                                image: FileImage(state.shotImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<ShotBloc>(context)
                                .add(ShotImageChangeAsked());
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(28),
                              ),
                              color: Colors.white,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/camera.svg',
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                BlocBuilder<ShotBloc, ShotState>(
                  builder: (context, state) {
                    return AnimatedOpacity(
                      opacity: state.isMapDisplayed &&
                              state.shotImage != null &&
                              (state.shotName != null &&
                                  state.shotName!.isNotEmpty)
                          ? 1
                          : 0,
                      duration: const Duration(seconds: 1),
                      child: state.isMapDisplayed &&
                              state.shotImage != null &&
                              (state.shotName != null &&
                                  state.shotName!.isNotEmpty)
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
