import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mo3tarib/core/network/api_endpoints.dart';
import 'package:mo3tarib/core/routing/routes.dart';
import 'package:mo3tarib/features/favorites/logic/favorites_cubit.dart';
import '../../add_edit_apartment/model/apartment_model.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({super.key, this.apartment});

  final ApartmentModel? apartment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        apartmentDetails,
        arguments: apartment,
      ).then(
        (value) => context.read<FavoritesCubit>().getFavorites(),
      ),
      child: Card(
        elevation: 1,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
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
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: Lottie.asset('assets/lotti/loading.json'),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
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
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        buildWhen: (previous, current) =>
                            current is DeleteFavoriteLoading,
                        builder: (context, state) {
                          return Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  showDeleteFavoriteDialog(
                                    context,
                                    () {
                                      context
                                          .read<FavoritesCubit>()
                                          .removeFavoriteApartment(
                                              apartment!.id!);
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  minimumSize: Size(50, 30.h),
                                ),
                                child: state is DeleteFavoriteLoading
                                    ? const CircularProgressIndicator()
                                    : Text(
                                        "حذف",
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                          );
                        },
                      )
                    ],
                  ),

                  SizedBox(height: 8.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteFavoriteDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Warning Icon
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red.withOpacity(0.1),
                  child: const Icon(Icons.delete_outline,
                      color: Colors.red, size: 30),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  "حذف من المفضلة",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Message
                const Text(
                  "هل أنت متأكد أنك تريد حذف هذا العنصر من المفضلة؟",
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("إلغاء"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "حذف",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
