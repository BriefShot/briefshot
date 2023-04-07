import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  void dispose() {
    _controller?.dispose();
  }

  GoogleMapController? _controller;
  String mapStyle = '';

  @override
  Widget build(BuildContext context) {
    DefaultAssetBundle.of(context)
        .loadString('assets/json/mapStyle.json')
        .then((string) {
      mapStyle = string;
    });
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // final isLoading = state.isLoading;
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: state.initialCameraPosition ??
                    const CameraPosition(
                      target: LatLng(48.856614, 2.3522219),
                      zoom: 7,
                    ),
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  BlocProvider.of<HomeBloc>(context)
                      .add(SetMapController(controller));
                  BlocProvider.of<HomeBloc>(context).add(SetMapStyle(mapStyle));
                  // BlocProvider.of<HomeBloc>(context).add(GoToDevicePosition());

                  controller.setMapStyle(mapStyle);
                },
              ),
              Positioned(
                bottom: 130,
                right: 40,
                child: FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(GoToDevicePosition());
                  },
                  backgroundColor: Color.fromARGB(255, 232, 137, 84),
                  child: const Icon(Icons.radio_button_checked),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
