import 'package:briefshot/services/MapService.dart';
import 'package:briefshot/widgets/LocationRequestPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/map/map_bloc.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MapScreen());
  }

  void dispose() {
    _controller.dispose();
  }

  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MapService(context),
      child: BlocProvider(
        create: (context) =>
            MapBloc(RepositoryProvider.of<MapService>(context)),
        child: BlocConsumer<MapBloc, MapState>(
          builder: (context, state) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: state.initialCameraPosition ??
                      const CameraPosition(
                        target: LatLng(48.856614, 2.3522219),
                        zoom: 7,
                      ),
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    _controller = controller;

                    BlocProvider.of<MapBloc>(context)
                        .add(InitMapEvent(controller));
                  },
                ),
                Positioned(
                  bottom: 130,
                  right: 40,
                  child: FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<MapBloc>(context)
                          .add(GoToDevicePosition());
                    },
                    backgroundColor: Color.fromARGB(255, 232, 137, 84),
                    child: const Icon(Icons.radio_button_checked),
                  ),
                ),
                if (state.isLocationDisabled == true)
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Container(
                      color: Color.fromARGB(255, 187, 0, 0).withOpacity(0.5),
                    ),
                  ),
              ],
            );
          },
          listener: (context, state) {
            if (state.isLocationDisabled == true) {
              print('toto location disabled');
              print(state.isLocationDisabled);
              showDialog(
                context: context,
                builder: (context) => const LocationRequestPopup(),
              );
            }
          },
        ),
      ),
    );
  }
}
