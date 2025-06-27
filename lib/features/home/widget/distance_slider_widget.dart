import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';

class DistanceSlider extends StatefulWidget {
  const DistanceSlider({super.key});

  @override
  State<DistanceSlider> createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  double _distance = 10;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // For Arabic layout
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "نطاق البحث (كم)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          FlutterSlider(
            values: [_distance],
            max: 100,
            min: 0,
            step: const FlutterSliderStep(step: 10),
            trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(color: Colors.orange),
              inactiveTrackBar: BoxDecoration(color: Colors.grey.shade300),
              activeTrackBarHeight: 4,
              inactiveTrackBarHeight: 4,
            ),
            handler: FlutterSliderHandler(
              decoration: const BoxDecoration(),
              child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            hatchMark: FlutterSliderHatchMark(
              labelsDistanceFromTrackBar: 10,
              smallLine: const FlutterSliderSizedBox(
                height: 5,
                width: 1,
                decoration: BoxDecoration(color: Colors.orange),
              ),
              density: 0.5,
              linesDistanceFromTrackBar: 6,
              displayLines: false,
              labels: [],
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                _distance = lowerValue;
                context.read<ApartmentCubit>().distance = lowerValue;
                context.read<ApartmentCubit>().getApartment();


              });
            },
          ),
        ],
      ),
    );
  }
}
