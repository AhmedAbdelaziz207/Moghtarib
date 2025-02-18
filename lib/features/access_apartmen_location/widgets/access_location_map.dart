import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../logic/access_location_cubit.dart';

class AccessLocationMap extends StatefulWidget {
  const AccessLocationMap({
    super.key,
    required this.onLocationPicked,
  });

  final Function() onLocationPicked;

  @override
  State<AccessLocationMap> createState() => _AccessLocationMapState();
}

class _AccessLocationMapState extends State<AccessLocationMap> {
  static Position? currentPosition;

  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  static final CameraPosition myLocationCameraPosition = CameraPosition(
    target: LatLng(
      currentPosition?.latitude ?? 0.0,
      currentPosition?.longitude ?? 0.0,
    ),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 17.0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AccessLocationCubit>().getUserLocation();
    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: myLocationCameraPosition,
        mapType: MapType.normal,
        markers: {
          Marker(
            markerId: const MarkerId("My Location"),
            draggable: true,
            onDragEnd: (value) {
              currentPosition = Position(
                latitude: value.latitude,
                longitude: value.longitude,
                accuracy: 0.0,
                altitude: 0.0,
                heading: 0.0,
                speed: 0.0,
                speedAccuracy: 0.0,
                timestamp: DateTime.now(),
                altitudeAccuracy: currentPosition?.altitudeAccuracy ?? 0,
                headingAccuracy: currentPosition?.headingAccuracy ?? 0.0,
              );

            },
          )
        },
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        buildingsEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        onMapCreated: (controller) {
          mapController.complete(controller);
        },
      ),
    );
  }
}
