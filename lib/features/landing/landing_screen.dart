import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/features/chat/ui/all_chats_screen.dart';
import 'package:mo3tarib/features/home/ui/student_home_screen.dart';
import 'package:mo3tarib/features/profile/profile_screen.dart';
import 'package:mo3tarib/features/settings/ui/settings_screen.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/user_role.dart';
import '../../core/utils/preference_manager.dart';
import '../home/ui/broker_home.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  final List<Widget> screens = [
    const StudentHome(),
    if (PreferenceManager.getUserRole() == UserRole.translate(UserRole.broker))
    const ProfileScreen(),
    const AllChatsScreen(),
    const Center(child: Text("Favourites")),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: ListTile(
          title: Text(
            "مرحبا احمد 👋",
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
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 28.sp,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items:  [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "الرئيسية",
          ),
          if (PreferenceManager.getUserRole() == UserRole.translate(UserRole.broker))
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "البروفايل",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "المحادثات",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "المفضلة",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "الاعدادات",
          ),
        ],
      ),
    );
  }
}
