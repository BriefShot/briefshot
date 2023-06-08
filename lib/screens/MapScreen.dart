import 'package:briefshot/screens/AddMarkerScreen.dart';
import 'package:briefshot/services/MapService.dart';
import 'package:briefshot/widgets/popups/LocationRequestPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
                  markers: <Marker>{
                    const Marker(
                      markerId: MarkerId("paris"),
                      position: LatLng(48.8566, 2.3522), // Paris coordinates
                    ),
                    const Marker(
                      markerId: MarkerId("lille"),
                      position: LatLng(50.6292, 3.0573), // Lille coordinates
                    ),
                    const Marker(
                      markerId: MarkerId("marseille"),
                      position:
                          LatLng(43.2965, 5.3698), // Marseille coordinates
                    ),
                  },
                  initialCameraPosition: state.initialCameraPosition ??
                      const CameraPosition(
                        target: LatLng(48.856614, 2.3522219),
                        zoom: 7,
                      ),
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: (controller) {
                    _controller = controller;

                    BlocProvider.of<MapBloc>(context)
                        .add(InitMapEvent(controller));
                  },
                ),
                Positioned(
                  bottom: 130,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        heroTag: "DevicePosition",
                        onPressed: () {
                          BlocProvider.of<MapBloc>(context)
                              .add(const GoToDevicePosition());
                        },
                        backgroundColor: const Color(0xFF1F2E34),
                        child:
                            SvgPicture.asset("assets/icons/location-user.svg"),
                      ),
                      const SizedBox(height: 20),
                      FloatingActionButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        heroTag: "AddMarker",
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              pageBuilder: (_, __, ___) =>
                                  const AddMarkerScreen(),
                              transitionsBuilder: (_, animation, __, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(
                                        0.0, 1.0), // Modification ici
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        backgroundColor: const Color(0xFF00A896),
                        child: SvgPicture.asset("assets/icons/add.svg"),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state.isLocationDisabled == true) {
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
