import 'dart:async';
import 'dart:developer';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mo3tarib/core/constants/assets.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/register/model/UserModel.dart';
import '../helpers/location_helper.dart';
import 'custom_info_window.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.displayedTechnical,
    this.showMyLocation,
    this.showInfoWindow,
    this.late,
    this.long,
    this.displayedApartment,
  });

  final List<UserModel>? displayedTechnical;
  final List<ApartmentModel>? displayedApartment;
  final String? late;
  final String? long;
  final bool? showMyLocation;
  final bool? showInfoWindow;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  static Position? currentPosition;
  Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();
  BitmapDescriptor? markerIcon;
  CameraPosition? technicalCameraPosition;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();

    if (widget.late != null && widget.long != null) {
      technicalCameraPosition = CameraPosition(
        target: LatLng(double.parse(widget.late!), double.parse(widget.long!)),
        zoom: 4,
        tilt: 2.0,
        bearing: 2.0,
      );
    }

    loadMarkerIcon();
  }

  getCurrentLocation() async {
    Position position = await LocationHelper.getCurrentLocation();
    setState(() {
      currentPosition = position;
      technicalCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 10.0, // Adjust zoom level as needed
        tilt: 0.0,
        bearing: 0.0,
      );
    });
  }

  static final CameraPosition myLocationCameraPosition = CameraPosition(
    target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 9,
  );

  loadMarkerIcon() {
    BitmapDescriptor.asset(const ImageConfiguration(), Assets.iconsHome,
            width: 40.w, height: 50.h)
        .then((value) {
      markerIcon = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return Stack(
      children: [
        SafeArea(
          child: currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
                  initialCameraPosition:
                      technicalCameraPosition ?? myLocationCameraPosition,
                  mapType: MapType.normal,
                  markers: {
                    if (widget.displayedApartment != null)
                      ...?widget.displayedApartment?.map(
                        (apartment) => Marker(
                          markerId: MarkerId(
                            apartment.id.toString(),
                          ),
                          icon: markerIcon ?? BitmapDescriptor.defaultMarker,
                          position: LatLng(
                            double.parse(apartment.addressLat!),
                            double.parse(apartment.addressLong!),
                          ),
                          onTap: () {
                            _customInfoWindowController.addInfoWindow!(
                              MyInfoWindow(
                                apartment: apartment,
                              ),
                              LatLng(
                                double.parse(apartment.addressLat!),
                                double.parse(apartment.addressLong!),
                              ),
                            );
                          },
                        ),
                      ),
                    if (widget.late != null && widget.long != null)
                      Marker(
                        markerId: const MarkerId("0"),
                        icon: markerIcon ?? BitmapDescriptor.defaultMarker,
                        position: LatLng(
                          double.parse(widget.late!),
                          double.parse(widget.long!),
                        ),
                      ),
                  },
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  buildingsEnabled: true,
                  zoomControlsEnabled: true,
                  onTap: (argument) {
                    _customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: (position) {
                    _customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (controller) {
                    mapController.complete(controller);
                    _customInfoWindowController.googleMapController =
                        controller;
                    log("Current Location: $currentPosition");
                  },
                ),
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height:
              MediaQuery.of(context).size.height * 0.28, // 30% of screen height
          width:
              MediaQuery.of(context).size.width * 0.75, // 70% of screen width
          offset: 20, // or adjust based on screen width if needed
        ),
      ],
    );
  }
}
