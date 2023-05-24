import 'package:briefshot/blocs/tagPills/tag_pills_bloc.dart';
import 'package:briefshot/blocs/userInfos/user_infos_bloc.dart';
import 'package:briefshot/widgets/NewTagPill.dart';
import 'package:briefshot/widgets/TagPill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TagPillsBloc(),
      child: BlocBuilder<UserInfosBloc, UserInfosState>(
        bloc: BlocProvider.of<UserInfosBloc>(context),
        builder: (context, state) {
          if (state is UserInfosLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is UserInfosLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(state.userInfos.cover),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: (MediaQuery.of(context).size.height * 0.3)
                      .roundToDouble(),
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(11, 16, 18, 0.5),
                          Color(0xFF0B1012)
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                NetworkImage(state.userInfos.avatar),
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            state.userInfos.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Color(0xFF0B1012)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/edit.svg",
                                color: const Color(0xFFE88954),
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Editer le profil",
                                style: TextStyle(
                                  color: Color(0xFFE88954),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          spacing: 8.0,
                          children: [
                            for (var tag in state.userInfos.interestedInTags)
                              BlocBuilder<TagPillsBloc, TagPillsState>(
                                bloc: BlocProvider.of<TagPillsBloc>(context),
                                builder: (context, state) {
                                  return TagPill(tag: tag);
                                },
                              ),
                            const NewTagPill()
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Favoris",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DrukWideWeb',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: state.userInfos.favoritePlaces.isEmpty
                              ? Center(
                                  child: Text(
                                    "Vous n'avez pas de favoris".toUpperCase(),
                                    style: TextStyle(
                                      color: const Color(0xFFCFCFCF)
                                          .withOpacity(0.2),
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 10,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state.userInfos.favoritePlaces.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.userInfos
                                                .favoritePlaces[index],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    );
                                  },
                                ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Publications",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DrukWideWeb',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: state.userInfos.posts.isEmpty
                              ? Center(
                                  child: Text(
                                    "Vous n'avez pas de publications"
                                        .toUpperCase(),
                                    style: TextStyle(
                                      color: const Color(0xFFCFCFCF)
                                          .withOpacity(0.2),
                                      fontSize: 15,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 30,
                                    );
                                  },
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.userInfos.posts.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.userInfos.posts[index],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 100,
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text("Erreur"),
          );
        },
      ),
    );
  }
}
