import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import '../../../core/theme/colors.dart' as AppColors;

class PriceRangeWidget extends StatefulWidget {
  const PriceRangeWidget({super.key, this.onPriceRangeChanged});

  final void Function(double, double)? onPriceRangeChanged;

  @override
  State<PriceRangeWidget> createState() => _PriceRangeWidgetState();
}

class _PriceRangeWidgetState extends State<PriceRangeWidget> {
  double _lowerPrice = 0;
  double _upperPrice = 100000;

  final double _minPrice = 0;
  final double _maxPrice = 100000;
  bool showTooltip = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("السعر",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const Spacer(),
            Text(
              " \$${_upperPrice.toStringAsFixed(1)} - \$${_lowerPrice.toStringAsFixed(1)} ",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14,
                color: Colors.grey

              ),
            )
          ],
        ),
        FlutterSlider(
            values: [_lowerPrice, _upperPrice],
            rangeSlider: true,
            max: _maxPrice,
            min: _minPrice,
            trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(color: AppColors.primaryColor),
              activeTrackBarDraggable: true,
              inactiveTrackBarHeight: 2,
              activeTrackBarHeight: 2,
            ),
            step: const FlutterSliderStep(step: 50),
            tooltip: FlutterSliderTooltip(
                alwaysShowTooltip: showTooltip,
                disabled: !showTooltip,
                disableAnimation: true,
                format: (value) => "\$ $value ",
                positionOffset: FlutterSliderTooltipPositionOffset(top: -20)),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                _lowerPrice = lowerValue;
                _upperPrice = upperValue;
                showTooltip = true;
                context.read<ApartmentCubit>().maxPrice = upperValue;
                context.read<ApartmentCubit>().minPrice = lowerValue;
              });

              context.read<ApartmentCubit>().getApartment();
            },
            onDragCompleted: (handlerIndex, lowerValue, upperValue) {
              setState(
                () => showTooltip = false,
              );
              widget.onPriceRangeChanged!(lowerValue, upperValue);
            }),
      ],
    );
  }
}
