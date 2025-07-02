import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/constants/user_role.dart';
import 'package:mo3tarib/core/utils/preference_manager.dart';
import 'package:mo3tarib/features/add_edit_apartment/logic/apartment_cubit.dart';
import 'package:mo3tarib/features/chat/logic/chat_cubit.dart';
import 'package:mo3tarib/features/chat/ui/all_chats_screen.dart';
import 'package:mo3tarib/features/home/ui/broker_home_body.dart';
import 'package:mo3tarib/features/home/ui/student_home_screen.dart';
import 'package:mo3tarib/features/profile/profile_screen.dart';
import '../../core/constants/assets.dart';
import '../favorites/favorites_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  String? userType = PreferenceManager.getUserRole();
  final isSemsar = PreferenceManager.getUserRole()?.toLowerCase() == "semsar";

  @override
  Widget build(BuildContext context) {
    final List<Widget> brokerScreens = [
      isSemsar ? const BrokerHomeBody() : const StudentHomeBody(),

      BlocProvider(
        create: (_) => ChatCubit(),
        child: const AllChatsScreen(),
      ),

      // Conditionally add Favorite screen (example: use any screen you want)
      if (!isSemsar) const FavoritesScreen(),
      // Replace with your actual favorite screen

      const ProfileScreen(),
      // Profile is always shown
    ];

    log("userType: $userType");


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ListTile(
          title: Text(
            "مرحبا ${PreferenceManager.getUsername()} 👋",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "هل تحتاج مساعدة اليوم؟",
            style: TextStyle(fontSize: 12.sp),
          ),
          trailing: Image.asset(Assets.appLogo, height: 20.h),
        ),
      ),
      body: brokerScreens[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: const Color(0xff102E50),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 26,
          items: [
            _buildBarItem("assets/icons/home.png", 0),
            _buildBarItem("assets/icons/chat.png", 1),
            if (userType?.toLowerCase() != "semsar".toLowerCase())
              _buildBarItem("assets/icons/bookmarks.png", 2),
            _buildBarItem("assets/icons/user.png", isSemsar ? 2 : 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBarItem(String icon, int index) {
    final bool isActive = _currentIndex == index;
    return BottomNavigationBarItem(
      label: '',
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              isActive ? Colors.orange.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          icon,
          width: 24,
          color: isActive ? Colors.orange : Colors.white,
        ),
      ),
    );
  }
}
