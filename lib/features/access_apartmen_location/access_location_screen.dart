import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/access_apartmen_location/widgets/access_location_map.dart';
import 'logic/access_location_cubit.dart';
import 'logic/access_location_state.dart';

class AccessLocationScreen extends StatefulWidget {
  const AccessLocationScreen({super.key});

  @override
  State<AccessLocationScreen> createState() => _AccessLocationScreenState();
}

class _AccessLocationScreenState extends State<AccessLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AccessLocationCubit, AccessLocationState>(
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: SizedBox(
                  child: AccessLocationMap(
                    onLocationPicked: () {},
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Column(
                      children: [
                        SizedBox(height: 40.h),
                        Text(
                          "تأكد من تحديد الموقع",
                          style: TextStyle(fontSize: 24.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Text(
                          "قم بتحريك المؤشر للحصول على الموقع المناسب",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            minimumSize: Size(240.w, 45.h),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                          child: Text(
                            "تأكيد",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
