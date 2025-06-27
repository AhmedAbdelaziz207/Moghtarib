import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../logic/access_location_cubit.dart';
import '../logic/access_location_state.dart';

class AccessLocationMap extends StatefulWidget {
  const AccessLocationMap({
    super.key,
    required this.onLocationPicked,
  });

  final Function(LatLng) onLocationPicked;

  @override
  State<AccessLocationMap> createState() => _AccessLocationMapState();
}

class _AccessLocationMapState extends State<AccessLocationMap> {
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  LatLng? selectedPosition;

  @override
  void initState() {
    super.initState();
    context.read<AccessLocationCubit>().getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessLocationCubit, AccessLocationState>(
      builder: (context, state) {
        if (state is AccessLocationLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AccessLocationLoaded) {
          final position = state.location;
          selectedPosition ??= LatLng(position.latitude, position.longitude);

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: selectedPosition!,
              zoom: 17.0,
            ),
            onMapCreated: (controller) => mapController.complete(controller),
            markers: {
              Marker(
                markerId: const MarkerId("Selected"),
                position: selectedPosition!,
                draggable: true,
                onDragEnd: (newLatLng) {
                  setState(() {
                    selectedPosition = newLatLng;
                  });
                },
              ),
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomGesturesEnabled: true,
            tiltGesturesEnabled: true,
          );
        }

        if (state is AccessLocationError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox.shrink();
      },
    );
  }

  /// Call this from parent when user clicks "Confirm"
  void confirmLocation() {
    if (selectedPosition != null) {
      widget.onLocationPicked(selectedPosition!);
    }
  }
}
