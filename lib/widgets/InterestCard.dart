import 'package:briefshot/blocs/interests/interests_bloc.dart';
import 'package:briefshot/entities/Interest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InterestCard extends StatelessWidget {
  Interest interest;

  InterestCard({super.key, required this.interest});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<InterestsBloc>(context),
      child: BlocBuilder<InterestsBloc, InterestsState>(
        builder: (context, state) {
          if (state is InterestsLoaded) {
            return GestureDetector(
              onTap: () {
                if (!state.interestsSelected.contains(interest)) {
                  BlocProvider.of<InterestsBloc>(context).add(SelectInterest(
                    interestSelected: interest,
                    currentSelectedInterests: state.interestsSelected,
                    interests: state.interests,
                  ));
                } else {
                  BlocProvider.of<InterestsBloc>(context).add(UnselectInterest(
                    unselectedInterest: interest,
                    currentSelectedInterests: state.interestsSelected,
                    interests: state.interests,
                  ));
                }
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(interest.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF1C1C1C).withOpacity(0),
                            const Color(0xFF1C1C1C).withOpacity(1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (state.interestsSelected.contains(interest))
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE88954),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          "assets/icons/check.svg",
                          color: Colors.white,
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 15,
                    left: 20,
                    child: Text(
                      interest.label.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
