import 'dart:async';

import 'package:briefshot/blocs/location/location_bloc.dart';
import 'package:briefshot/blocs/location/location_bloc.dart';
import 'package:briefshot/blocs/map/map_bloc.dart';
import 'package:briefshot/blocs/shot/shot_bloc.dart';
import 'package:briefshot/services/MapService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddShotStepTwo extends StatefulWidget {
  AddShotStepTwo({super.key});

  @override
  State<AddShotStepTwo> createState() => _AddShotStepTwoState();
}

class _AddShotStepTwoState extends State<AddShotStepTwo> {
  static final GlobalKey<FormState> _locationFormKey = GlobalKey<FormState>();
  late GoogleMapController _googleMapController;
  static final _addressController = TextEditingController();

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MapService(context),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MapBloc(
              RepositoryProvider.of<MapService>(context),
            ),
          ),
        ],
        child: BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is LocationSelected) {
              BlocProvider.of<ShotBloc>(context).add(
                ShotPlaceChangedAsked(location: state.location),
              );
              _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(
                      state.location.lat,
                      state.location.lng,
                    ),
                    zoom: 11.0,
                  ),
                ),
              );
            }
          },
          child: BlocListener<ShotBloc, ShotState>(
            listener: (context, state) {
              if (state is ShotCreated) {
                _locationFormKey.currentState!.reset();
                _addressController.clear();
              }
            },
            child: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Form(
                              key: _locationFormKey,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      "Emplacement",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "DrukWideWeb",
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    BlocBuilder<LocationBloc, LocationState>(
                                      bloc: BlocProvider.of<LocationBloc>(
                                          context),
                                      builder: (context, state) {
                                        return TextFormField(
                                          style: const TextStyle(
                                              color: Colors.white),
                                          controller: _addressController,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 20.0,
                                              vertical: 16.0,
                                            ),
                                            filled: true,
                                            fillColor: Color(0xFF1F2E34),
                                          ),
                                          onChanged: (value) async {
                                            BlocProvider.of<LocationBloc>(
                                                    context)
                                                .add(
                                              LocationSearch(
                                                  input:
                                                      _addressController.text),
                                            );
                                          },
                                        );
                                      },
                                    )
                                  ]),
                            ),
                            BlocBuilder<LocationBloc, LocationState>(
                              bloc: BlocProvider.of<LocationBloc>(context),
                              builder: (context, state) {
                                if (state.predictions.isNotEmpty) {
                                  return SizedBox(
                                    height: 200, // Set the desired height
                                    child: ListView.builder(
                                      itemCount: state.predictions.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF1F2E34),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              state.predictions[index]
                                                  .description!,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              _addressController.text = state
                                                  .predictions[index]
                                                  .description!;
                                              BlocProvider.of<LocationBloc>(
                                                      context)
                                                  .add(
                                                LocationPredictionSelected(
                                                    prediction: state
                                                        .predictions[index]),
                                              );

                                              FocusScope.of(context).unfocus();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: BlocBuilder<LocationBloc, LocationState>(
                          bloc: BlocProvider.of<LocationBloc>(context),
                          builder: (context, state) {
                            // if (state.location != null) {
                            // _googleMapController.animateCamera(
                            // CameraUpdate.newCameraPosition(
                            // CameraPosition(
                            // target: LatLng(
                            // state.location!.lat,
                            // state.location!.lng,
                            // ),
                            // zoom: 11.0,
                            // ),
                            // ),
                            // );
                            // }
                            return GoogleMap(
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(
                                  48.8566,
                                  2.3522,
                                ),
                                zoom: 11.0,
                              ),
                              onMapCreated: (controller) {
                                _googleMapController = controller;
                                if (state.location != null) {
                                  _googleMapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                          state.location!.lat,
                                          state.location!.lng,
                                        ),
                                        zoom: 11.0,
                                      ),
                                    ),
                                  );
                                }
                                BlocProvider.of<MapBloc>(context)
                                    .add(InitMapEvent(controller));
                              },
                              onTap: (LatLng latLng) {
                                // BlocProvider.of<MapBloc>(context)
                                //     .add(MapEvent.addMarker(latLng));
                              },
                              markers: state.location != null
                                  ? {
                                      Marker(
                                        markerId: const MarkerId("location"),
                                        position: LatLng(
                                          state.location!.lat,
                                          state.location!.lng,
                                        ),
                                      ),
                                    }
                                  : {},
                            );
                          },
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
