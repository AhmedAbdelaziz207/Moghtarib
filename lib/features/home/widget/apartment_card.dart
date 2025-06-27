import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mo3tarib/core/network/api_endpoints.dart';
import 'package:mo3tarib/core/widgets/custom_dialog.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_model.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/apartment_params.dart';
import 'package:mo3tarib/features/add_edit_apartment/model/edit_or_add_apartment_destination.dart';
import '../../../core/routing/routes.dart';
import '../../add_edit_apartment/logic/apartment_cubit.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({super.key, this.apartment});

  final ApartmentModel? apartment;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Apartment Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp)),
            child: Image.network(
              ApiEndPoints.imagesUrl + apartment!.baseImageURL!,
              fit: BoxFit.cover,
              height: 120.h,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Lottie.asset('assets/lotti/loading.json'),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: 120,
                width: double.maxFinite,
                color: Colors.grey[300],
                child: Icon(Icons.image_not_supported, size: 50.sp),
              ),
            ),
          ),

          // Apartment Details
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "${apartment?.city}, ${apartment?.village}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 6.h),

                // Price & Rent Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${apartment?.price} ج م",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Location
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          showDeletionDialog(context, () async {
                            await context
                                .read<ApartmentCubit>()
                                .deleteApartment(apartment!.id!)
                                .then((value) {
                              Navigator.pop(context);
                              context
                                  .read<ApartmentCubit>()
                                  .getBrokerApartments();
                            });
                          });
                        },
                        child: Icon(Icons.delete_outline_outlined,
                            size: 20.sp, color: Colors.red)),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              editApartment,
                              arguments: apartment,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: Size(50, 30.h),
                          ),
                          child: Text(
                            "تعديل",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ),

                SizedBox(height: 8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
