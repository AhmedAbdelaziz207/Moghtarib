import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/home/logic/home_cubit.dart';
import 'package:mo3tarib/features/home/widget/price_range_widget.dart';
import '../../../core/utils/preference_manager.dart';
import 'apartment_or_technical_dropdown.dart';
import 'distance_slider_widget.dart';

class HomeTopSection extends StatefulWidget {
  const HomeTopSection({super.key});

  @override
  State<HomeTopSection> createState() => _HomeTopSectionState();
}

class _HomeTopSectionState extends State<HomeTopSection> {
  final userRole = PreferenceManager.getUserRole();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is NavigateToTechnicalsPage ||
          current is NavigateToApartmentPage,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (userRole != "sanaiee") const ApartmentOrTechnicalDropdown(),
          SizedBox(height: 12.h,),
          if (userRole == "sanaiee") SizedBox(height: 30.h),
          if (state is NavigateToApartmentPage)
            const Row(
              children: [
                Expanded(child: DistanceSlider()),
                SizedBox(
                  width: 8,
                ),
                Expanded(child: PriceRangeWidget()),
              ],
            ),
        ],
      ),
    );
  }
}
