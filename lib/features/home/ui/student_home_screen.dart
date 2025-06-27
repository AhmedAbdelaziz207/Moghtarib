import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/widgets/map_screen.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import 'package:mo3tarib/features/home/logic/home_cubit.dart';
import 'package:mo3tarib/features/home/widget/home_technicans_section.dart';
import 'package:mo3tarib/features/home/widget/home_top_section.dart';

import '../../../core/helpers/location_helper.dart';
import '../../../core/utils/preference_manager.dart';

class StudentHomeBody extends StatefulWidget {
  const StudentHomeBody({super.key});

  @override
  State<StudentHomeBody> createState() => _StudentHomeBodyState();
}

class _StudentHomeBodyState extends State<StudentHomeBody> {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    context.read<ApartmentCubit>().getApartment();
    context.read<HomeCubit>().navigateToApartment();
    LocationHelper.getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("User Role " + PreferenceManager.getUserRole().toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                current is NavigateToApartmentPage ||
                current is NavigateToTechnicalsPage,
            builder: (context, state) {
              return Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                    const HomeTopSection(),
                  if (state is NavigateToApartmentPage)
                    BlocConsumer<ApartmentCubit, ApartmentState>(
                      listener: (context, state) {
                        if (state is ApartmentSuccess) {
                          if (state.apartments.isNotEmpty) {
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                      " تم العثور علي ${state.apartments.length}شقة"),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                          } else {
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("لم تم العثور علي شقق"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                          }
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is ApartmentSuccess,
                      builder: (BuildContext context, state) {
                        if (state is ApartmentSuccess) {
                          return SizedBox(
                            height: 350.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: MapScreen(
                                displayedApartments: state.apartments,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  if (state is NavigateToTechnicalsPage)
                    const HomeTechnicalsSection()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
