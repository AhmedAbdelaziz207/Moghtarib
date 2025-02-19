import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/widgets/custom_button.dart';

 showDeletionDialog(context) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "هل انت متأكد من حذف الشقه؟",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
              ),
              SizedBox(
                height: 21.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        "لا",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      onPressed: () {Navigator.pop(context); },
                    ),
                  ),
                  Expanded(
                    child: CustomElevatedButton(
                      backgroundColor: Colors.red,
                      child: Text(
                        "نعم",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontSize: 12.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
