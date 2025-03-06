import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/routing/routes.dart';
import '../../../core/utils/dummy.dart';
import '../../../core/widgets/map_screen.dart';
import '../../add_edit_apartment/model/apartment_params.dart';
import '../../add_edit_apartment/model/edit_or_add_apartment_destination.dart';

class BrokerHome extends StatelessWidget {
  const BrokerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 420.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: MapScreen(
                    displayedApartment: apartments,
                    showInfoWindow: true,
                    showMyLocation: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.withOpacity(.8),
        onPressed: () {
          Navigator.pushNamed(
            context,
            addOrEditApartment,
            arguments: ApartmentDetailsParams(
              destination: EditOrAddApartmentDestination.add,
              apartment: null,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
