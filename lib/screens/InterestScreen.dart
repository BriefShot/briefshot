import 'package:briefshot/blocs/interests/interests_bloc.dart';
import 'package:briefshot/repository/InterestRepository.dart';
import 'package:briefshot/widgets/InterestCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          InterestsBloc(InterestRepository())..add(LoadInterests()),
      child: BlocBuilder<InterestsBloc, InterestsState>(
        builder: (context, state) {
          if (state is InterestsLoaded) {
            return Scaffold(
              backgroundColor: const Color(0xFF0B1012),
              appBar: AppBar(
                backgroundColor: const Color(0xFF0B1012),
                toolbarHeight: 84,
                centerTitle: false,
                titleSpacing: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: const Text(
                  "Intérêts",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "DrukWideWeb",
                    fontSize: 24,
                  ),
                ),
              ),
              body: Stack(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: GridView.builder(
                        itemCount: state.interests.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 15.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final interest = state.interests[index];
                          return InterestCard(
                            interest: interest,
                          );
                        },
                      ),
                    ),
                  ),
                  if (state.interestsSelected.isNotEmpty)
                    Positioned(
                      bottom: 30,
                      left: MediaQuery.of(context).size.width * 0.08,
                      right: MediaQuery.of(context).size.width * 0.08,
                      child: SizedBox(
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<InterestsBloc>(context)
                                .add(SubmitInterests(
                              interestsToSubmit: state.interestsSelected,
                            ));
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: const Color(0xFFE88954),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.0),
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                              ),
                              Text(
                                'Ajouter les intérêts (${state.interestsSelected.length})',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
