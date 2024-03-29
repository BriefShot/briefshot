import 'package:briefshot/blocs/interests/interests_bloc.dart';
import 'package:briefshot/blocs/profile/profile_bloc.dart';
import 'package:briefshot/blocs/tagPills/tag_pills_bloc.dart';
import 'package:briefshot/blocs/userInfos/user_infos_bloc.dart';
import 'package:briefshot/blocs/usernameDialog/username_dialog_bloc.dart';
import 'package:briefshot/repository/InterestRepository.dart';
import 'package:briefshot/widgets/NewTagPill.dart';
import 'package:briefshot/widgets/TagPill.dart';
import 'package:briefshot/widgets/popups/AskUsername.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UsernameDialogBloc usernameDialogBloc =
        BlocProvider.of<UsernameDialogBloc>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TagPillsBloc(),
        ),
        BlocProvider.value(
          value: BlocProvider.of<UserInfosBloc>(context),
        ),
        BlocProvider.value(
          value: usernameDialogBloc,
        ),
      ],
      child: BlocBuilder<UsernameDialogBloc, UsernameDialogState>(
        builder: (context, state) {
          return MultiBlocListener(
            listeners: [
              BlocListener<UsernameDialogBloc, UsernameDialogState>(
                listener: (context, state) async {
                  if (state is UsernameDialogAppear) {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return BlocProvider.value(
                          value: usernameDialogBloc,
                          child: AskUsername(),
                        );
                      },
                    );
                  }
                },
              ),
              BlocListener<UserInfosBloc, UserInfosState>(
                  listener: (context, state) {
                if (state is UserInfosLoaded) {
                  if (state.userInfos.interestedInTags.isEmpty) {
                    BlocProvider.of<TagPillsBloc>(context)
                        .add(TagPillsCancelDeleteMode());

                    // Ajouter la condition ici pour vérifier le state du TagPillsBloc
                    if (BlocProvider.of<TagPillsBloc>(context).state
                        is TagPillsDeleteMode) {
                      BlocProvider.of<TagPillsBloc>(context)
                          .add(TagPillsCancelDeleteMode());
                    }
                  }
                }
              })
            ],
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
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(state.userInfos.cover),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height:
                                    (MediaQuery.of(context).size.height * 0.3)
                                        .roundToDouble(),
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
                                ),
                              ),
                              BlocBuilder<ProfileBloc, ProfileState>(
                                bloc: BlocProvider.of<ProfileBloc>(context),
                                builder: (context, state) {
                                  if (state.isEditionMode) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 10, 0, 0),
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(
                                            ProfileCoverUpdateAsked(),
                                          );
                                        },
                                        child: const Icon(
                                          Icons.photo_camera_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 70,
                                                backgroundImage: NetworkImage(
                                                    state.userInfos.avatar),
                                                backgroundColor: Colors.white,
                                              ),
                                              BlocBuilder<ProfileBloc,
                                                  ProfileState>(
                                                bloc: BlocProvider.of<
                                                    ProfileBloc>(context),
                                                builder: (context, state) {
                                                  if (state.isEditionMode) {
                                                    return Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          BlocProvider.of<
                                                                      ProfileBloc>(
                                                                  context)
                                                              .add(
                                                            ProfileAvatarUpdateAsked(),
                                                          );
                                                        },
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          20),
                                                                    ),
                                                                    color: Colors
                                                                        .white),
                                                            child: SvgPicture.asset(
                                                                'assets/icons/camera.svg',
                                                                height: 24,
                                                                width: 24)),
                                                      ),
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                state.userInfos.username,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              BlocBuilder<ProfileBloc,
                                                      ProfileState>(
                                                  bloc: BlocProvider.of<
                                                      ProfileBloc>(context),
                                                  builder: (context, state) {
                                                    if (BlocProvider.of<
                                                                ProfileBloc>(
                                                            context)
                                                        .state
                                                        .isEditionMode) {
                                                      return BlocBuilder<
                                                          UsernameDialogBloc,
                                                          UsernameDialogState>(
                                                        bloc: BlocProvider.of<
                                                                UsernameDialogBloc>(
                                                            context),
                                                        builder:
                                                            (context, state) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              BlocProvider.of<
                                                                          UsernameDialogBloc>(
                                                                      context)
                                                                  .add(
                                                                const UsernameDialogAsked(),
                                                              );
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/icons/edit-user.svg',
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                height: 15,
                                                                width: 15,
                                                                color: const Color(
                                                                    0xFFE88954),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    }
                                                    return const SizedBox();
                                                  })
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (BlocProvider.of<TagPillsBloc>(context).state
                                  is TagPillsDeleteMode) {
                                BlocProvider.of<TagPillsBloc>(context)
                                    .add(TagPillsCancelDeleteMode());
                              } else {
                                return;
                              }
                            },
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Color(0xFF0B1012)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Wrap(
                                      spacing: 8.0,
                                      children: [
                                        for (var tag
                                            in state.userInfos.interestedInTags)
                                          BlocBuilder<TagPillsBloc,
                                              TagPillsState>(
                                            bloc: BlocProvider.of<TagPillsBloc>(
                                                context),
                                            builder: (context, state) {
                                              return TagPill(tag: tag);
                                            },
                                          ),
                                        BlocBuilder<TagPillsBloc,
                                            TagPillsState>(
                                          builder: (context, state) {
                                            if (state is! TagPillsDeleteMode) {
                                              return BlocProvider(
                                                create: (context) =>
                                                    InterestsBloc(
                                                        InterestRepository())
                                                      ..add(LoadInterests()),
                                                child: BlocBuilder<
                                                    InterestsBloc,
                                                    InterestsState>(
                                                  builder: (context, state) {
                                                    if (state
                                                        is InterestsLoaded) {
                                                      if (state
                                                          .interests.isEmpty) {
                                                        return const SizedBox();
                                                      }

                                                      return const NewTagPill();
                                                    }
                                                    return const SizedBox();
                                                  },
                                                ),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                        )
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: state
                                              .userInfos.favoritePlaces.isEmpty
                                          ? Container(
                                              color: const Color(0xFF090D0F),
                                              child: Center(
                                                child: Text(
                                                  "Vous n'avez pas de favoris"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFCFCFCF)
                                                            .withOpacity(0.2),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                  width: 10,
                                                );
                                              },
                                              scrollDirection: Axis.horizontal,
                                              itemCount: state.userInfos
                                                  .favoritePlaces.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        state.userInfos
                                                                .favoritePlaces[
                                                            index],
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.9,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: state.userInfos.posts.isEmpty
                                          ? Container(
                                              color: const Color(0xFF090D0F),
                                              child: Center(
                                                child: Text(
                                                  "Vous n'avez pas de publications"
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFCFCFCF)
                                                            .withOpacity(0.2),
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : ListView.separated(
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                  width: 30,
                                                );
                                              },
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  state.userInfos.posts.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        state.userInfos
                                                            .posts[index],
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
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
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text("Erreur"),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
