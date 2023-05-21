import 'package:briefshot/screens/SettingsScreen.dart';
import 'package:briefshot/widgets/NewTagPill.dart';
import 'package:briefshot/widgets/TagPill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        snapshot.data!['cover'],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      snapshot.data!['avatar'],
                                    ),
                                    backgroundColor: Colors.white,
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              }),
                          FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                  snapshot.data!['username'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              } else {
                                return const CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
        Padding(
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
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Wrap(
                      spacing: 8.0,
                      children: [
                        for (var tag in snapshot.data!["interestedInTags"])
                          TagPill(
                            tag: tag,
                          ),
                        const NewTagPill(),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error");
                  }
                  return const CircularProgressIndicator();
                },
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
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!["favoritePlaces"].length == 0) {
                        return Center(
                          child: Text(
                            "Vous n'avez pas de lieux favoris".toUpperCase(),
                            style: TextStyle(
                              color: const Color(0xFFCFCFCF).withOpacity(0.2),
                              fontSize: 15,
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 30,
                          );
                        },
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!["favoritePlaces"].length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                  snapshot.data!['favoritePlaces'][index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 100,
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Error",
                          style: TextStyle(color: Colors.white));
                    }
                    return Text("data", style: TextStyle(color: Colors.white));
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
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!["posts"].length == 0) {
                          return Center(
                            child: Text(
                              "Vous n'avez pas de publications".toUpperCase(),
                              style: TextStyle(
                                color: const Color(0xFFCFCFCF).withOpacity(0.2),
                                fontSize: 15,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 30,
                            );
                          },
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!["posts"].length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data!['posts'][index],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 100,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Text("Error");
                      }
                      return const Text("data",
                          style: TextStyle(color: Colors.white));
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
