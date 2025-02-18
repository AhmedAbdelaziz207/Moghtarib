import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/core/utils/dummy.dart';
import 'package:mo3tarib/features/home/widget/apartment_card.dart';

class BrokerHomeBody extends StatelessWidget {
  const BrokerHomeBody({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .6,
              ),
              itemCount: 12,
              itemBuilder: (context, index) => ApartmentCard(
                apartment: dummyApartment,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.withOpacity(.8),
        onPressed: () {
          Navigator.pushNamed(context, addOrEditApartment);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
