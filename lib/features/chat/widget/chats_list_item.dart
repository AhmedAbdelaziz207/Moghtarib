import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mo3tarib/core/constants/assets.dart';
import 'package:mo3tarib/core/routing/routes.dart';

class ChatsListItem extends StatelessWidget {
  const ChatsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, messageScreen);
      },
      child: ListTile(
          leading: CircleAvatar(
            radius: 20.r,
            backgroundColor: Colors.orange,
            child: Text(
              "O",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            "Omar",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
          ),
          subtitle: Text(
            "اي الاخبار؟",
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
