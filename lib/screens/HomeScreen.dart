import 'package:briefshot/repository/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => HomeBloc(),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // final isLoading = state.isLoading;
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: HomeBloc.initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    BlocProvider.of<HomeBloc>(context)
                        .add(SetMapController(controller));
                    BlocProvider.of<HomeBloc>(context)
                        .add(GoToDevicePosition());
                  },
                ),
                // Rond au milieu de l'écran pour faire un effet de chargement
                // /!\ fait ramer le PC si pas de bonne puce graphique
                // const Center(
                //   child: CircularProgressIndicator(),
                // ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context)
                          .add(GoToDevicePosition());
                    },
                    label: const Text('Lake'),
                    icon: const Icon(Icons.directions_boat),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
