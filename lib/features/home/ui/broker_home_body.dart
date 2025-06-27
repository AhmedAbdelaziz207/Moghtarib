import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_params.dart';
import 'package:mo3tarib/features/home/widget/apartment_card.dart';
import '../../../core/theme/colors.dart';
import '../../add_edit_apartment/model/edit_or_add_apartment_destination.dart';

class BrokerHomeBody extends StatefulWidget {
  const BrokerHomeBody({super.key});

  @override
  State<BrokerHomeBody> createState() => _BrokerHomeBodyState();
}

class _BrokerHomeBodyState extends State<BrokerHomeBody> {
  @override
  void initState() {
    context.read<ApartmentCubit>().getBrokerApartments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async{
          context.read<ApartmentCubit>().getBrokerApartments();
        },
        child: BlocBuilder<ApartmentCubit, ApartmentState>(
          buildWhen: (previous, current) =>
              current is ApartmentSuccess ||
              current is ApartmentError ||
              current is ApartmentLoading,
          builder: (context, state) {
            if (state is ApartmentLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            if (state is ApartmentError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.red, fontSize: 16.sp),
                ),
              );
            }

            if (state is ApartmentSuccess) {
              final apartments = state.apartments;

              if (apartments.isEmpty) {
                return Center(
                  child: Text(
                    "لا يوجد لديك عقارات",
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),
                  ),
                );
              }

              return Column(
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .6,
                      ),
                      itemCount: apartments.length,
                      itemBuilder: (context, index) => ApartmentCard(
                        apartment: apartments[index],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
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
          ).then(
            (value) => context.read<ApartmentCubit>().getBrokerApartments(),
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
