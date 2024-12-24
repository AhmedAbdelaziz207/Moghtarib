import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/network/model/user_role.dart';
import 'package:mo3tarib/core/utils/preference_manager.dart';
import 'package:mo3tarib/core/widgets/custom_button.dart';
import '../../core/routing/routes.dart';
import '../../core/theme/colors.dart';

class SelectUserRoleScreen extends StatelessWidget {
  const SelectUserRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo at the top
              Image.asset(
                'assets/images/app_logo.png',
                // Replace with your logo asset path
                height: 40.h,
              ),
              SizedBox(height: 16.h),
              // Images
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left Image
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Background container
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            // Replace with `secondaryColor`
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Positioned image
                        Positioned(
                          top: -28,
                          // Adjust as needed to position the image partially above the container
                          left: 20,
                          // Adjust as needed for horizontal alignment
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/worker.png',
                              // Replace with your image asset path
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16.h),
                  // Right Image
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Background container
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            // Replace with `secondaryColor`
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // Positioned image
                        Positioned(
                          top: -24,
                          // Adjust as needed to position the image partially above the container
                          right: 20,
                          // Adjust as needed for horizontal alignment
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/student.png',
                              // Replace with your image asset path
                              height: 145,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              // Buttons
              buildUserTypeButton(UserRole.student, context),
              SizedBox(height: 12.h),
              buildUserTypeButton(UserRole.broker, context),
              SizedBox(height: 12.h),
              buildUserTypeButton(UserRole.technical, context),

              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildUserTypeButton(String role, BuildContext context) {
    switch (role) {
      case UserRole.student:
        PreferenceManager.saveUserRole(UserRole.student);
        break;
      case UserRole.broker:
        PreferenceManager.saveUserRole(UserRole.broker);
        break;
      case UserRole.technical:
        PreferenceManager.saveUserRole(UserRole.technical);
        break;
    }

    return ElevatedButton(
      onPressed: () {
        PreferenceManager.saveUserRole(UserRole.student);

        Navigator.pushNamed(context, login);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        role,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
