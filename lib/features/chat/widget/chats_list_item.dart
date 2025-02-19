import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/constants/assets.dart';

class ChatsListItem extends StatelessWidget {
  const ChatsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
          leading: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.white,
            child: Image.asset(Assets.iconsPin, width: 30,),
          ),
          title: Text(
            "Ahmed Ali",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
          subtitle: Text(
            "ازيك يامستر",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 11.sp,
                ),
          ),
          trailing: const Text(
            "02.11",
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          )),
    );
  }
}
